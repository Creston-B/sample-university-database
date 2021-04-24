using System;

namespace UniversityDatabaseConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            //using MySQL.Data NuGet package from Oracle

            MySql.Data.MySqlClient.MySqlConnection serverConnection;
            string serverConnectionString = "server=127.0.0.1;Database=universitydatabase;uid=root";

            serverConnection = new MySql.Data.MySqlClient.MySqlConnection();
            serverConnection.ConnectionString = serverConnectionString;
            serverConnection.Open();

            MySql.Data.MySqlClient.MySqlDataReader dataReader;


            //example to test the connection and query / response functionality of MySQL.Data is working
            dataReader = (new MySql.Data.MySqlClient.MySqlCommand("SELECT * FROM country", serverConnection).ExecuteReader());

            //successfully prints console entires for every country
            while (dataReader.Read())
            {
                Console.WriteLine($"Country id: {dataReader["id"]} | Country name: {dataReader["country_name"]}");
            }
        }
    }
}
