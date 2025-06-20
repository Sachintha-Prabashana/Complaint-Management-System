package lk.ijse.db;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

@WebListener
public class DBContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/cms");
        ds.setUsername("root");
        ds.setPassword("Sachintha@2003");
        ds.setInitialSize(5);
        ds.setMaxTotal(50);
        ServletContext context = sce.getServletContext();
        context.setAttribute("dataSource", ds);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try{
            ServletContext context = sce.getServletContext();
            BasicDataSource ds = (BasicDataSource) context.getAttribute("dataSource");
            if (ds != null) {
                ds.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
