package WhatToPlay;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

import java.text.BreakIterator;

import java.util.Locale;
import java.util.ResourceBundle;
import java.util.MissingResourceException;

import CLIPSJNI.*;

public class WhatToPlay implements ActionListener {

    JLabel displayLabel;
    JButton nextButton;
    JPanel choicesPanel;
    ButtonGroup choicesButtons;
    ResourceBundle resources;

    Environment clips;
    boolean isExecuting = false;
    Thread executionThread;

    WhatToPlay() {
        try {
            resources = ResourceBundle.getBundle("resources.resources",Locale.getDefault());
        } catch (MissingResourceException mre) {
            mre.printStackTrace();
            return;
        }

        JFrame jfrm = new JFrame(resources.getString("Title"));
        jfrm.getContentPane().setLayout(new GridLayout(3,1));
        jfrm.setSize(500,300);
        jfrm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jfrm.setLocationRelativeTo(null);

        JPanel displayPanel = new JPanel();
        displayPanel.setBackground(Color.BLACK);
        displayLabel = new JLabel();
        displayLabel.setForeground(Color.WHITE);
        displayPanel.add(displayLabel);

        choicesPanel = new JPanel();
        choicesPanel.setBackground(Color.BLACK);
        choicesPanel.setForeground(Color.WHITE);

        choicesButtons = new ButtonGroup();

        JPanel buttonPanel = new JPanel();
        buttonPanel.setBackground(Color.BLACK);
        buttonPanel.setForeground(Color.WHITE);

        nextButton = new JButton(resources.getString("Next"));
        nextButton.setActionCommand("Next");
        nextButton.setBackground(Color.WHITE);
        nextButton.setForeground(Color.BLACK);
        nextButton.setFocusPainted(false);
        buttonPanel.add(nextButton);
        nextButton.addActionListener(this);

        jfrm.getContentPane().add(displayPanel);
        jfrm.getContentPane().add(choicesPanel);
        jfrm.getContentPane().add(buttonPanel);

        clips = new Environment();

        clips.load("whattoplay.clp");

        clips.reset();
        runClips();

        jfrm.setVisible(true);
    }

    private void nextUIState() throws Exception {

        String evalStr = "(find-all-facts ((?f state-list)) TRUE)";
        String result = clips.eval(evalStr).get(0).getFactSlot("is-result").toString();

        if (result.equals("Yes")) {
            nextButton.setActionCommand("Restart");
            nextButton.setText(resources.getString("Restart"));
        } else {
            nextButton.setActionCommand("Next");
            nextButton.setText(resources.getString("Next"));
        }

        PrimitiveValue numOfAnswers = clips.eval(evalStr).get(0).getFactSlot("numOfAnswers");
        choicesPanel.removeAll();
        choicesButtons = new ButtonGroup();

        for (int i = 0; i < numOfAnswers.intValue(); i++) {
            JRadioButton rButton;
            String answer = clips.eval(evalStr).get(0).getFactSlot("answer" + (i+1)).toString();

            rButton = new JRadioButton(resources.getString(answer),true);
            rButton.setActionCommand(answer);
            rButton.setBackground(Color.BLACK);
            rButton.setForeground(Color.WHITE);
            rButton.setFocusPainted(false);
            choicesPanel.add(rButton);
            choicesButtons.add(rButton);
        }

        choicesPanel.repaint();
        String questionContent = clips.eval(evalStr).get(0).getFactSlot("content").toString();
        wrapLabelText(displayLabel, resources.getString(questionContent));

        executionThread = null;
        isExecuting = false;
    }

    @Override
    public void actionPerformed(ActionEvent ae) {
        try {
            onActionPerformed(ae);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void runClips() {
        Runnable runThread = new Runnable() {
            public void run() {
                clips.run();
                SwingUtilities.invokeLater(new Runnable() {
                    public void run() {
                        try {
                            nextUIState();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                });
            }
        };

        isExecuting = true;
        executionThread = new Thread(runThread);
        executionThread.start();
    }

    // Correct
    public void onActionPerformed(ActionEvent ae) throws Exception {
        if (isExecuting) return;
        String evalStr = "(find-all-facts ((?f state-list)) TRUE)";
        String about = clips.eval(evalStr).get(0).getFactSlot("about").toString();

        if (ae.getActionCommand().equals("Next")) {
            clips.assertString(resources.getString("waitForAns"));
            if (choicesButtons.getButtonCount() == 0) {
                clips.assertString("(" + about + ")");
            } else {
                clips.assertString("(" + about + " " + choicesButtons.getSelection().getActionCommand() + ")");
            }
            runClips();
        } else if (ae.getActionCommand().equals("Restart")) {
            clips.reset();
            runClips();
        }
    }

    private void wrapLabelText(JLabel label, String text) {
        FontMetrics fm = label.getFontMetrics(label.getFont());
        Container container = label.getParent();
        int containerWidth = container.getWidth();
        int textWidth = SwingUtilities.computeStringWidth(fm,text);
        int desiredWidth;

        if (textWidth <= containerWidth) {
            desiredWidth = containerWidth;
        } else {
            int lines = (int) ((textWidth + containerWidth) / containerWidth);
            desiredWidth = (int) (textWidth / lines);
        }

        BreakIterator boundary = BreakIterator.getWordInstance();
        boundary.setText(text);

        StringBuffer trial = new StringBuffer();
        StringBuffer real = new StringBuffer("<html><center>");

        int start = boundary.first();
        for (int end = boundary.next(); end != BreakIterator.DONE; start = end, end = boundary.next()) {
            String word = text.substring(start,end);
            trial.append(word);
            int trialWidth = SwingUtilities.computeStringWidth(fm,trial.toString());
            if (trialWidth > containerWidth) {
                trial = new StringBuffer(word);
                real.append("<br>");
                real.append(word);
            } else if (trialWidth > desiredWidth) {
                trial = new StringBuffer("");
                real.append(word);
                real.append("<br>");
            } else {
                real.append(word);
            }
        }
        real.append("</html>");
        label.setText(real.toString());
    }

    public static void main(String args[]) {
        SwingUtilities.invokeLater(new Runnable() {
            public void run() { new WhatToPlay(); }
        });
    }

}
