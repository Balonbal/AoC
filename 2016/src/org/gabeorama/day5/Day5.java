package org.gabeorama.day5;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by Sly on 08.12.2016.
 */
public class Day5 {

    public static void run(String input) {
        StringBuilder builder = new StringBuilder("________");
        long index = 0;
        while (builder.toString().contains("_")) {
            String line = "";
            while (!line.startsWith("00000")) {
                line = getMD5(input + ++index);
            }
            try {
                int pos = Integer.parseInt(String.valueOf(line.charAt(5)));

                if (pos <= 7 && builder.charAt(pos) == '_') {
                    builder.setCharAt(pos, line.charAt(6));
                }
                System.out.printf("%s (%s at %d) => %s\n", line, line.charAt(6), pos, builder.toString());
            } catch (Exception e) {

            }
        }

        System.out.println(builder.toString());
    }


    private static String getMD5(String input) {
        try {
            MessageDigest m = MessageDigest.getInstance("MD5");
            m.reset();
            m.update(input.getBytes("UTF-8"));
            byte[] digest = m.digest();
            BigInteger bigInt = new BigInteger(1,digest);
            String hashtext = bigInt.toString(16);
            // Now we need to zero pad it if you actually want the full 32 chars.
            while(hashtext.length() < 32 ){
                hashtext = "0"+hashtext;
            }

            return hashtext;
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

}