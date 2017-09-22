using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;

public class Encrypt
{
    public string CreateHash(string pPassword)
    {
        string source = pPassword;
        using (MD5 md5Hash = MD5.Create())
        {
            string hash = GetMd5Hash(md5Hash, source);
            return hash;
        }
    }

    public string GetMd5Hash(MD5 md5Hash, string input)
    {
        //GetMd5Hash
        // Convert the input string to a byte array and compute the hash. 
        byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));
        // Create a new Stringbuilder to collect the bytes 
        // and create a string. 
        StringBuilder sBuilder = new StringBuilder();
        // Loop through each byte of the hashed data  
        // and format each one as a hexadecimal string. 
        int i = 0;
        for (i = 0; i <= data.Length - 1; i++)
        {
            sBuilder.Append(data[i].ToString("x2"));
        }
        // Return the hexadecimal string. 
        return sBuilder.ToString();
    }

    public bool VerifyMd5Hash(MD5 md5Hash, string input, string hash)
    {
        // Verify a hash against a string. 
        // Hash the input. 
        string hashOfInput = GetMd5Hash(md5Hash, input);
        // Create a StringComparer an compare the hashes. 
        StringComparer comparer = StringComparer.OrdinalIgnoreCase;
        if (0 == comparer.Compare(hashOfInput, hash))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public string EncryptOrderId(int orderId)
    {
        return CreateHash(orderId.ToString());
    }
    public string RandomString(int size, bool lowerCase)
    {
        StringBuilder sb = new StringBuilder();
        Random r = new Random();

        for (int i = 0; i < size; i++)
        {
            char ch = Convert.ToChar(Convert.ToInt32((26 * r.NextDouble() + 66)));
            sb.Append(ch);
        }

        if (lowerCase)
        {
            return sb.ToString().Replace("[", "x").Replace("\"", "x").ToLower();
        }
        else
        {
            return sb.ToString().Replace("[", "X").Replace("\"", "X").ToUpper();
        }
    }
}