# -*- coding: utf-8 -*-
"""
Created on Fri Feb 23 10:22:46 2024

@author: ZC
"""

import sqlite3
import pandas as pd

# SQLite veritabanı dosyasını bağlayın
conn = sqlite3.connect('hotelDB2.db')

# SQL sorgusu ile veritabanından veriyi çekin
query = "SELECT * FROM otel;"
df = pd.read_sql_query(query, conn)

# CSV dosyasına dönüştürün
df.to_csv('hotelDB2.csv', index=False)

# Veritabanı bağlantısını kapatın
conn.close()
