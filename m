From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v5 24/30] selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE
Date: Wed, 10 Oct 2018 17:18:40 -0700
Message-ID: <20181011001846.30964-25-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In preparation for removing CONFIG_DEFAULT_SECURITY, this removes the
soon-to-be redundant SECURITY_SELINUX_BOOTPARAM_VALUE. Since explicit
ordering via CONFIG_LSM or "lsm=" will define whether an LSM is enabled or
not, this CONFIG will become effectively ignored, so remove it. However,
in order to stay backward-compatible with "security=selinux", the enable
variable defaults to true.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/Kconfig | 15 ---------------
 security/selinux/hooks.c |  5 +----
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8af7a690eb40..55f032f1fc2d 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -22,21 +22,6 @@ config SECURITY_SELINUX_BOOTPARAM
 
 	  If you are unsure how to answer this question, answer N.
 
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
index 0f8d7bb88197..14c120842ab4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -120,9 +120,8 @@ __setup("enforcing=", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
 
+int selinux_enabled __lsm_ro_after_init = 1;
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
-
 static int __init selinux_enabled_setup(char *str)
 {
 	unsigned long enabled;
@@ -131,8 +130,6 @@ static int __init selinux_enabled_setup(char *str)
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
-#else
-int selinux_enabled = 1;
 #endif
 
 static unsigned int selinux_checkreqprot_boot =
-- 
2.17.1
