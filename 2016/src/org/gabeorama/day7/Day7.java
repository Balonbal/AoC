package org.gabeorama.day7;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Sly on 08.12.2016.
 */
public class Day7 {

    public static void run(String input) {
        int c = 0;
        for (String line: input.split("\n")) {

            List<String> outside = new ArrayList<>();
            List<String> inside = new ArrayList<>();
            Pattern p = Pattern.compile("([\\w]+)\\[([\\w]+)\\]");
            Matcher matcher = p.matcher(line);

            while (matcher.find()) {
                outside.add(matcher.group(1));
                inside.add(matcher.group(2));
            }
            outside.add(line.substring(line.lastIndexOf("]")));

            boolean match = false;
            for (String s: outside) {
                if (containsABBA(s)) { match = true; break; }
            }

            for (String s: inside) {
                if (containsABBA(s)) { match = false; break; }
            }

            if (match) c++;
        }

        System.out.printf("# of IPs found: %d\n", c);
    }

    public static void run2(String input) {
        int c = 0;

        for (String line: input.split("\n")) {

            List<String> outside = new ArrayList<>();
            List<String> inside = new ArrayList<>();
            Pattern p = Pattern.compile("([\\w]+)\\[([\\w]+)\\]");
            Matcher matcher = p.matcher(line);

            while (matcher.find()) {
                outside.add(matcher.group(1));
                inside.add(matcher.group(2));
            }
            outside.add(line.substring(line.lastIndexOf("]")));

            if (contains_ABA_BAB_Pair(inside, outside)) c++;
        }

        System.out.printf("# of IPs found: %d\n", c);
    }

    private static boolean contains_ABA_BAB_Pair(List<String> inside, List<String> outside) {
        List<String> ABA = new ArrayList<>();
        List<String> BAB = new ArrayList<>();

        for (String s: outside) {
            for (int i = 0; i <= s.length() - 3; i++) {
                if (isABBA(s.substring(i, i+3)) && s.charAt(i) != s.charAt(i+1)) ABA.add(s.substring(i, i+3));
            }
        }

        for (String s: inside) {
            for (int i = 0; i <= s.length() -3; i++) {
                if (isABBA(s.substring(i, i+3)) && s.charAt(i) != s.charAt(i+1)) {
                    BAB.add(""+s.charAt(i+1) + s.charAt(i) + s.charAt(i+1));
                }
            }
        }

        ABA.retainAll(BAB);
        return ABA.size() > 0;
    }

    private static boolean containsABBA(String s) {
        for (int i = 0; i <= s.length() - 4; i++) {
            if (isABBA(s.substring(i, i+4))) return true;
        }
        return false;
    }

    private static boolean isABBA(String s) {
        return s.equals(new StringBuffer(s).reverse().toString());
    }
}
