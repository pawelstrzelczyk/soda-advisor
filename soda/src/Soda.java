import javax.swing.*;
import javax.swing.border.*;
import javax.swing.table.*;
import java.awt.*;
import java.awt.event.*;
import java.text.BreakIterator;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.MissingResourceException;
import java.util.logging.Level;
import java.util.logging.Logger;

import net.sf.clipsrules.jni.*;

class Soda implements ActionListener {
    private JPanel rootPanel;
    private JRadioButton YESRadioButton;
    private JButton button2;
    private JButton button1;
    private JRadioButton NORadioButton;
    private JButton button3;
    private JPanel question;
    private JPanel choice;
    private JPanel navigation;
    private JLabel text;

    static Environment clips;
    boolean isExecuting = false;
    Thread executionThread;

    Soda() throws CLIPSException {
        ResourceBundle sodaResources;
        try {
            sodaResources = ResourceBundle.getBundle("resources.SodaResources", Locale.getDefault());
        } catch (MissingResourceException e) {
            e.printStackTrace();
            return;
        }

        JFrame frame = new JFrame(sodaResources.getString("Soda"));
        frame.getContentPane().setLayout(new GridLayout(3, 1));
        frame.setSize(600, 300);
        frame.setPreferredSize(new Dimension(600, 300));
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        question = new JPanel();
        text = new JLabel(sodaResources.getString("WelcomeMessage"));
        question.add(text);

        choice = new JPanel();
        YESRadioButton = new JRadioButton(sodaResources.getString("Yes"));
        YESRadioButton.setActionCommand("Yes");
        choice.add(YESRadioButton);
        YESRadioButton.addActionListener(this);

        NORadioButton = new JRadioButton(sodaResources.getString("No"));
        NORadioButton.setActionCommand("No");
        choice.add(NORadioButton);
        NORadioButton.addActionListener(this);


        navigation = new JPanel();
        button1 = new JButton(sodaResources.getString("Restart"));
        button1.setActionCommand("Restart");
        navigation.add(button1);
        button1.addActionListener(this);

        button2 = new JButton(sodaResources.getString("Next"));
        button2.setActionCommand("Next");
        navigation.add(button2);
        button2.addActionListener(this);

        button3 = new JButton("Debug");
        button3.setActionCommand("Debug");
        navigation.add(button3);
        button3.addActionListener(this);


        frame.getContentPane().add(question);
        frame.getContentPane().add(choice);
        frame.getContentPane().add(navigation);

        clips = new Environment();
        clips.load("rules.CLP");
        clips.reset();

        //runSoda();
        frame.setVisible(true);


    }

    @Override
    public void actionPerformed(ActionEvent ae) {
        try {
            onActionPerformed(ae);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void nextUIState() throws Exception {
        ResourceBundle sodaResources;
        try {
            sodaResources = ResourceBundle.getBundle("resources.SodaResources", Locale.getDefault());
        } catch (MissingResourceException e) {
            e.printStackTrace();
            return;
        }

        String stateCurr = "";
        String evalStr = "(find-all-facts ((?f stateCurr)) TRUE)";
        MultifieldValue mv = (MultifieldValue) clips.eval(evalStr);
        for (PrimitiveValue pv : mv) {
            FactAddressValue fv = (FactAddressValue) pv;
            stateCurr = ((LexemeValue) fv.getSlotValue("state")).getValue();
        }

        String display = "";
        evalStr = "(find-all-facts ((?f UI-state)) " +
                "(eq ?f:state " + stateCurr + "))";
        mv = (MultifieldValue) clips.eval(evalStr);
        for (PrimitiveValue pv : mv) {
            FactAddressValue fv = (FactAddressValue) pv;
            display = ((LexemeValue) fv.getSlotValue("display")).getValue();
        }
        System.out.println("display: " + display);
        System.out.println("stateCurr below display: " + stateCurr);

        String theText = sodaResources.getString(display);
        text.setText(theText);
        if(stateCurr.equals("final")){
            button2.setVisible(false);
        }
        executionThread = null;
        isExecuting = false;
    }

    public void runSoda() {
        Runnable runThread = new Runnable() {
            public void run() {
                try {
                    clips.run();
                    SwingUtilities.invokeLater(
                            new Runnable() {
                                @Override
                                public void run() {
                                    try {
                                        nextUIState();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                    );
                } catch (CLIPSException e) {
                    e.printStackTrace();
                }


            }
        };
        isExecuting = true;
        executionThread = new Thread(runThread);
        executionThread.start();
    }

    public void onActionPerformed(ActionEvent ae) throws Exception {
        if (isExecuting) return;

        String stateCurr = "";
        String evalStr = "(find-all-facts ((?f stateCurr)) TRUE)";
        MultifieldValue mv = (MultifieldValue) clips.eval(evalStr);
        for (PrimitiveValue pv : mv) {
            FactAddressValue fv = (FactAddressValue) pv;
            stateCurr = ((LexemeValue) fv.getSlotValue("state")).getValue();
        }
        System.out.println("stateCurr: " + stateCurr);


        if (ae.getActionCommand().equals("Next")) {
            if (YESRadioButton.isSelected()) {
                clips.assertString("(next Yes)");
                clips.assertString("(stateCurr (state " + stateCurr + "))");
            } else if (NORadioButton.isSelected()) {
                clips.assertString("(next No)");
                clips.assertString("(stateCurr (state " + stateCurr + "))");
            }
//            clips.assertString("(stateCurr (state " + stateCurr + "))");
            YESRadioButton.setSelected(false);
            NORadioButton.setSelected(false);

            runSoda();
        } else if (ae.getActionCommand().equals("Restart")) {
            YESRadioButton.setSelected(false);
            NORadioButton.setSelected(false);
            button2.setVisible(true);
            clips.reset();
            runSoda();
        } else if (ae.getActionCommand().equals("Debug")) {

            String debug = "(facts)";
            String res = clips.eval(debug).toString();
            System.out.println(res);
        } else if (ae.getActionCommand().equals("No")) {
            if(YESRadioButton.isSelected()){
                YESRadioButton.setSelected(false);
            }
        }
        else if (ae.getActionCommand().equals("Yes")) {
            if(NORadioButton.isSelected()){
                NORadioButton.setSelected(false);
            }
        }


    }

    public static void main(String[] args) {


        System.out.println("hello");

        SwingUtilities.invokeLater(
                new Runnable() {
                    @Override
                    public void run() {
                        try {
                            new Soda();
                        } catch (CLIPSException e) {
                            e.printStackTrace();
                        }
                    }
                }
        );


    }

}


