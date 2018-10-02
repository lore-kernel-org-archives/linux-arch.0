From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Mon,  1 Oct 2018 17:54:56 -0700
Message-ID: <20181002005505.6112-24-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
"lsm.enable=...", this removes the LSM-specific enabling logic from
SELinux.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 ------
 security/selinux/Kconfig                      | 29 -------------------
 security/selinux/hooks.c                      | 15 +---------
 3 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cf963febebb0..0d10ab3d020e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4045,15 +4045,6 @@
 			loaded. An invalid security module name will be treated
 			as if no module has been chosen.
 
-	selinux=	[SELINUX] Disable or enable SELinux at boot time.
-			Format: { "0" | "1" }
-			See security/selinux/Kconfig help text.
-			0 -- disable.
-			1 -- enable.
-			Default value is set via kernel config option.
-			If enabled at boot time, /selinux/disable can be used
-			later to disable prior to initial policy load.
-
 	serialnumber	[BUGS=X86-32]
 
 	shapers=	[NET]
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8af7a690eb40..86936528a0bb 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -8,35 +8,6 @@ config SECURITY_SELINUX
 	  You will also need a policy configuration and a labeled filesystem.
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_SELINUX_BOOTPARAM
-	bool "NSA SELinux boot parameter"
-	depends on SECURITY_SELINUX
-	default n
-	help
-	  This option adds a kernel parameter 'selinux', which allows SELinux
-	  to be disabled at boot.  If this option is selected, SELinux
-	  functionality can be disabled with selinux=0 on the kernel
-	  command line.  The purpose of this option is to allow a single
-	  kernel image to be distributed with SELinux built in, but not
-	  necessarily enabled.
-
-	  If you are unsure how to answer this question, answer N.
-
-config SECURITY_SELINUX_BOOTPARAM_VALUE
-	int "NSA SELinux boot parameter default value"
-	depends on SECURITY_SELINUX_BOOTPARAM
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'selinux', which allows SELinux to be disabled at boot.  If this
-	  option is set to 0 (zero), the SELinux kernel parameter will
-	  default to 0, disabling SELinux at bootup.  If this option is
-	  set to 1 (one), the SELinux kernel parameter will default to 1,
-	  enabling SELinux at bootup.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_SELINUX_DISABLE
 	bool "NSA SELinux runtime disable"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 71a10fedecb3..8f5eea097612 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -120,20 +120,7 @@ __setup("enforcing=", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
 
-#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
-
-static int __init selinux_enabled_setup(char *str)
-{
-	unsigned long enabled;
-	if (!kstrtoul(str, 0, &enabled))
-		selinux_enabled = enabled ? 1 : 0;
-	return 1;
-}
-__setup("selinux=", selinux_enabled_setup);
-#else
-int selinux_enabled = 1;
-#endif
+int selinux_enabled __lsm_ro_after_init;
 
 static unsigned int selinux_checkreqprot_boot =
 	CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
-- 
2.17.1
