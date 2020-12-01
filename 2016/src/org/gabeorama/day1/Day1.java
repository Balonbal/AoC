package org.gabeorama.day1;

import java.awt.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Sly on 08.12.2016.
 */
public class Day1 {

    public static void run(String input) {
        int x = 0, y = 0;
        int direction = 0; //N = 0, E = 1, S = 2, W = 3
        String[] dirs = input.split(", ");
        for (int i = 0; i < dirs.length; i++) {
            switch(dirs[i].substring(0, 1)) {
                case "R":
                    //Turn and resolve for a full turn
                    if (++direction > 3) {
                        direction = 0;
                    }
                    break;
                case "L":
                    //Same as above
                    if (--direction < 0) {
                        direction = 3;
                    }
                    break;
            }
            int mult = (direction > 1 ? -1 : 1); //Positive or negative movement
            int movement = mult * Integer.parseInt(dirs[i].substring(1));

            //get direction to add
            if (direction % 2 == 0) { //N or S
                y += movement;
            } else {
                x += movement;
            }
        }

        System.out.printf("Movement is %d", Math.abs(x) + Math.abs(y));
    }

    public static void run2(String input) {
        int x = 0, y = 0;
        int direction = 0; //N = 0, E = 1, S = 2, W = 3
        Set<Point> locations = new HashSet<>();
        locations.add(new Point(x, y));
        String[] dirs = input.split(", ");
        for (int i = 0; i < dirs.length; i++) {
            switch(dirs[i].substring(0, 1)) {
                case "R":
                    //Turn and resolve for a full turn
                    if (++direction > 3) {
                        direction = 0;
                    }
                    break;
                case "L":
                    //Same as above
                    if (--direction < 0) {
                        direction = 3;
                    }
                    break;
            }
            int mult = (direction > 1 ? -1 : 1); //Positive or negative movement
            int movement = Integer.parseInt(dirs[i].substring(1));

            for (int j = 0; j < movement; j++) {
                if (direction % 2 == 0) { //N or S
                    y += mult;
                } else {
                    x += mult;
                }
                Point location = new Point(x, y);
                if (locations.contains(location)) {
                    System.out.printf("Location found at %d blocks away\n", Math.abs(x) + Math.abs(y));
                }
                locations.add(location);
            }

        }

    }
}
