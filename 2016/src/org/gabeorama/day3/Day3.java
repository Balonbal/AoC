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

    public static void run2(String input) {
        int[][] triplet = new int[3][3];
        int p = 0;

        String[] lines = input.split("\n");
        for (int i = 0; i < lines.length; i++) {
            String[] integers = lines[i].trim().split("(\\s+)");

            if (i % 3 == 0) triplet = new int[3][3];

            for (int j = 0; j < integers.length; j++) {
                triplet[j][i % 3] = Integer.parseInt(integers[j]);
            }
            
            if (i % 3 == 2) {
                for (int[] col: triplet) {
                    int max = Math.max(col[0], Math.max(col[1], col[2]));

                    if (max < col[0] + col[1] + col[2] - max) p++;
                }
            }
        }

        System.out.printf("# of possible triangles: %d", p);
    }
}
