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

public class Soda {

    static Environment clips;

    public static void main(String[] args) throws CLIPSException {
        try {
            clips = new Environment();
            clips.load("rules.CLP");
            clips.reset();

            clips.assertString("(auto nieiwme)");

            clips.run();
            System.out.println("hello");


        } catch (CLIPSLoadException ex) {
            Logger.getLogger(Soda.class.getName()).log(Level.SEVERE, null, ex);
        }



        String evalStr = "(facts)";

        String currentID = clips.eval(evalStr).toString();

        System.out.println(currentID);



    }
}


