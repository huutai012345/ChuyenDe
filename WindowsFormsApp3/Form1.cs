using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp3
{
    public partial class Form1 : Form
    {
        private string connectString = @"Data Source=NHT;Initial Catalog=CHUNGKHOAN;Persist Security Info=True;User ID=sa;Password=123";
        private SqlConnection connection = null;
        private delegate void NewHome();
        private event NewHome OnNewHome;

        public Form1()
        {
            InitializeComponent();
            SqlDependency.Start(connectString);
            connection = new SqlConnection(this.connectString);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            OnNewHome += new NewHome(Form1_OnNewHome);
            this.loadData();
        }

        private void Form1_OnNewHome()
        {
            ISynchronizeInvoke i = (ISynchronizeInvoke)this;
            if (i.InvokeRequired)
            {
                NewHome dd = new NewHome(Form1_OnNewHome);
                i.BeginInvoke(dd, null);
                return;
            }
            this.loadData();
        }

        private void loadData()
        {
            DataTable dt = new DataTable();

            if (this.connection.State == ConnectionState.Closed)
            {
                this.connection.Open();
            }

            string sql = "SELECT MACP,GIAMUA3,KLM3,GIAMUA2,KLM2,GIAMUA1,KLM1,GIAKHOP,KLKHOP,GIABAN1,KLB1,GIABAN2,KLB2,GIABAN3,KLB3 FROM dbo.BANGGIATRUCTUYEN";
            SqlCommand cmd = new SqlCommand(sql, this.connection);
            cmd.Notification = null;
            SqlDependency sqlDependency = new SqlDependency(cmd);
            sqlDependency.OnChange += new OnChangeEventHandler(de_OnChange);
            dt.Load(cmd.ExecuteReader(CommandBehavior.CloseConnection));
            dataGridView1.DataSource = dt;
        }

        public void de_OnChange(object sender, SqlNotificationEventArgs e)
        {
            SqlDependency de = sender as SqlDependency;
            de.OnChange -= de_OnChange;
            if (OnNewHome != null)
            {
                OnNewHome();
            }
        }   

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            SqlDependency.Stop(connectString);
        }
    }
}