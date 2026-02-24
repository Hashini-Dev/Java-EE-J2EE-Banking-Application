package lk.jiat.app.ejb.interceptor;

import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.InvocationContext;
import java.util.logging.Logger;

public class LoggingInterceptor {

    private static final Logger logger = Logger.getLogger(LoggingInterceptor.class.getName());

    @AroundInvoke
    public Object logMethodInvocation(InvocationContext context) throws Exception {
        String methodName = context.getMethod().getName();
        String className = context.getTarget().getClass().getName();

        long startTime = System.currentTimeMillis();
        logger.info(">>> Entering method: " + className + "." + methodName);

        try {
            return context.proceed();
        } finally {
            long endTime = System.currentTimeMillis();
            logger.info("<<< Exiting method: " + className + "." + methodName + " (Execution Time: "
                    + (endTime - startTime) + "ms)");
        }
    }
}
