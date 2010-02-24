// Hack to disable calls to System.exit in your application. Based on code from
// http://sprauer.wordpress.com/2009/03/18/disable-java-systemexit/ which is
// in turn based on http://www.jroller.com/ethdsy/entry/disabling_system_exit
public class SystemExitManager extends SecurityManager {
  public void checkPermission(java.security.Permission permission) {
    if ("exitVM".equals(permission.getName())) {
      throw new SecurityException("System exit disabled");
    }
  }
  
  public static void disableSystemExitCall() {    
    SystemExitManager securityManager = new SystemExitManager();
    System.setSecurityManager(securityManager);
  }

  public static void enableSystemExitCall() {
    System.setSecurityManager(null);
  }
}