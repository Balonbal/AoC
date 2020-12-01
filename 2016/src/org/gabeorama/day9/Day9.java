package org.gabeorama.day9;

/**
 * Created by Sly on 09.12.2016.
 */
public class Day9 {

    public static void run(String input) {
        System.out.println(decompress(input).length());
    }

    public static String decompress(String input) {
        StringBuilder builder = new StringBuilder();
        while (input.contains("(")) {
            builder.append(input.substring(0, input.indexOf("(")));
            int A = Integer.parseInt(input.substring(input.indexOf("(") + 1, input.indexOf("x")));
            int B = Integer.parseInt(input.substring(input.indexOf("x") + 1, input.indexOf(")")));

            for (int i = 0; i < B; i++) {
                builder.append(input.substring(input.indexOf(")") + 1, input.indexOf(")") + A + 1));
            }

            input = input.substring(input.indexOf(")") + A + 1);
        }

        builder.append(input);
        return builder.toString();
    }

    private static long countDecrompress(String input) {
        long count = 0;
        while (input.contains("(")) {
            count += input.substring(0, input.indexOf("(")).length();
            int A = Integer.parseInt(input.substring(input.indexOf("(") + 1, input.indexOf("x")));
            int B = Integer.parseInt(input.substring(input.indexOf("x") + 1, input.indexOf(")")));

            String decompress = input.substring(input.indexOf(")")+1, input.indexOf(")") + A + 1);
            count += B * countDecrompress(decompress);

            input = input.substring(input.indexOf(")") + A + 1);
        }
        count += input.length();

        return count;
    }

    public static void run2(String input) {
        System.out.println(countDecrompress(input));
    }

}
