import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;

public class window {
    public window() {
        button1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                text.setText("pytanie");
            }
        });

        NORadioButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

            }
        });
        YESRadioButton.addFocusListener(new FocusAdapter() {
            @Override
            public void focusGained(FocusEvent e) {
                super.focusGained(e);
                text.setText("focus");
            }
        });
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("window");
        frame.setContentPane(new window().rootPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

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



}
