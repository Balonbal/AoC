package org.gabeorama.day2;

import java.awt.*;

import static com.sun.org.apache.xalan.internal.xsltc.compiler.util.Type.Int;

/**
 * Created by Sly on 08.12.2016.
 */
public class Day2 {

    public static Integer[][] keyboard = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}};
    public static String[][] keyboard2 = {
            { "" ,  "", "1", "" , "" },
            { "" , "2", "3", "4", "" },
            { "5", "6", "7", "8", "9"},
            { "" , "A", "B", "C", "" },
            { "" , "" , "D", "" , "" }
    };

    public static void run(String input) {
        String directions = "ULDR";
        StringBuilder builder = new StringBuilder();

        String[] steps = input.split("\n");
        for (int i = 0; i < steps.length; i++) {
            String step = steps[i];
            Point position = new Point(1, 1);
            for (int j = 0; j < step.length(); j++) {
                int direction = directions.indexOf(step.charAt(j));
                int x = position.x, y = position.y;
                int mult = direction > 1 ? 1 : -1;


                if (direction % 2 == 0) position.y += mult;
                else position.x += mult;

                if (position.x < 0 || position.y < 0 || position.x > 2 || position.y > 2) position = new Point(x, y);
                System.out.printf("After moving %s we are now at (%d, %d) which is %d\n", step.charAt(j), position.x, position.y, keyboard[position.y][position.x]);
            }

            builder.append(keyboard[position.y][position.x]);
        }

        System.out.printf("The code is %s", builder.toString());
    }

    public static void run2(String input) {
        String directions = "ULDR";
        StringBuilder builder = new StringBuilder();

        String[] steps = input.split("\n");
        for (int i = 0; i < steps.length; i++) {
            String step = steps[i];
            Point position = new Point(0, 2);
            for (int j = 0; j < step.length(); j++) {
                int direction = directions.indexOf(step.charAt(j));
                int x = position.x, y = position.y;
                int mult = direction > 1 ? 1 : -1;


                if (direction % 2 == 0) position.y += mult;
                else position.x += mult;

                if (position.x < 0 || position.y < 0 || position.x > 4 || position.y > 4 || keyboard2[position.y][position.x].equals("")) position = new Point(x, y);
                System.out.printf("After moving %s we are now at (%d, %d) which is %s\n", step.charAt(j), position.x, position.y, keyboard2[position.y][position.x]);
            }

            builder.append(keyboard2[position.y][position.x]);
        }

        System.out.printf("The code is %s", builder.toString());
    }
}
