package org.news.dao.impl;

import org.junit.Test;
import org.news.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.Assert.*;

/**
 * @Auther xiaohoo
 * @Date 2018/7/26 12:49
 * @Email 1126457667@qq.com
 */
public class NewsDaoImplTest {

    @Test
    public void getNewsCountByTID() {
        Connection connection = null;
        try {
            connection = DatabaseUtil.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        NewsDaoImpl newsDao = new NewsDaoImpl(connection);
        try {
            int count = newsDao.getNewsCountByTID(1);
            System.out.println(count);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeAll(connection,null,null);
        }
    }
}