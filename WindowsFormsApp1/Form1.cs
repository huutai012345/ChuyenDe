using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public SqlConnection conn = new SqlConnection();
        public SqlDataReader myReader;

        public Form1()
        {
            InitializeComponent();
            this.KetNoi();
            comboBox.SelectedIndex = 1;
        }

        public SqlDataReader ExecSqlDataReader(String strLenh)
        {
            SqlDataReader myreader;
            SqlCommand sqlcmd = new SqlCommand(strLenh, this.conn);
            sqlcmd.CommandType = CommandType.Text;
            // sqlcmd.CommandTimeout = 600;
            if (this.conn.State == ConnectionState.Closed) this.conn.Open();
            try
            {
                myreader = sqlcmd.ExecuteReader();
                return myreader;

            }
            catch (SqlException ex)
            {
                this.conn.Close();
                MessageBox.Show(ex.Message);
                return null;
            }
        }

        public int KetNoi()
        {
            if (this.conn != null && this.conn.State == ConnectionState.Open)
                this.conn.Close();
            try
            {
                this.conn.ConnectionString = @"Data Source=NHT;Initial Catalog=CHUNGKHOAN;Persist Security Info=True;User ID=sa;Password=123";
                this.conn.Open();
                return 1;
            }

            catch (Exception e)
            {
                MessageBox.Show("Lỗi kết nối cơ sở dữ liệu.\nBạn xem lại user name và password.\n " + e.Message, "", MessageBoxButtons.OK);
                return 0;
            }
        }

        public void run(String maCP, String loaiCP,int soLg,float gia)
        {
            String strLenh1 = "EXEC [dbo].[DAT_LENH] \n" +
                            "@macp = N'" + maCP + "', @LoaiGD = N'" + loaiCP + "', @soluongMB =" + soLg + ", @giadatMB = " + gia+
                            "\n EXEC [dbo].[TAO_BANG_GIA] ";

            this.myReader = this.ExecSqlDataReader(strLenh1);
            if (this.myReader == null)
            {
                return;
            }

            this.myReader.Close();
            return;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            String maCP=textBoxMaCP.Text.Trim();
            String loaiCP = this.comboBox.Text.Trim();
           
            if(maCP == "" || loaiCP =="" || textBoxSoLG.Text.Trim()=="" || textBoxGiaDat.Text.Trim()=="")
            {
                MessageBox.Show("Vui Long Dien Day Du Thong Tin");
                return;
            }


            int soLg = int.Parse(textBoxSoLG.Text.Trim());
            float gia = float.Parse(textBoxGiaDat.Text.Trim());
            if (soLg <= 0 || gia <= 0)
            {
                MessageBox.Show("Vui Long Nhap Lon Hon 0");
                return;
            }

            this.run(maCP, loaiCP, soLg, gia);
            MessageBox.Show("Đặt Thành Công");
        }

        private void textBoxGiaDat_TextChanged(object sender, EventArgs e)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(textBoxGiaDat.Text, "[^0-9]"))
            {
                MessageBox.Show("Vui Long Nhap So.");
                textBoxGiaDat.Text = textBoxGiaDat.Text.Remove(textBoxGiaDat.Text.Length - 1);
            }
        }

        private void textBoxSoLG_TextChanged(object sender, EventArgs e)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(textBoxSoLG.Text, "[^0-9]"))
            {
                MessageBox.Show("Vui Long Nhap So.");
                textBoxSoLG.Text = textBoxSoLG.Text.Remove(textBoxSoLG.Text.Length - 1);
            }
        }
    }
}
