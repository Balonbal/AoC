package org.gabeorama.day3;

/**
 * Created by Sly on 08.12.2016.
 */
public class Day3 {
    public static void run(String input) {
        int p = 0;
        String[] lines = input.split("\n");
        for (int i = 0; i < lines.length; i++) {
            String[] integers = lines[i].trim().split("(\\s+)");

            int k = Integer.parseInt(integers[0]);
            int l = Integer.parseInt(integers[1]);
            int m = Integer.parseInt(integers[2]);

            int max = Math.max(k, Math.max(l, m));

            if (max < k + l + m - max) p++;
        }

        System.out.printf("# of possible triangles: %d", p);
    }
}
