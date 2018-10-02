Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:36681 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeJBHpD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 03:45:03 -0400
Received: by mail-io1-f67.google.com with SMTP id p4-v6so295260iom.3
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 18:04:31 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 22/32] apparmor: Remove boot parameter
Date: Mon,  1 Oct 2018 17:54:55 -0700
Message-ID: <20181002005505.6112-23-keescook@chromium.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181002005455.ujEdrolTMpiHmt-rKMd4hKIaAE9fCXrcnAnn38auQDs@z>

Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
"lsm.enable=...", this removes the LSM-specific enabling logic from
AppArmor, though it leaves the existing userspace API visibility into
/sys/module/apparmor/parameters/enabled.

Co-developed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 -------
 security/apparmor/Kconfig                       | 16 ----------------
 security/apparmor/lsm.c                         |  7 ++-----
 3 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f646cfab5613..cf963febebb0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4054,13 +4054,6 @@
 			If enabled at boot time, /selinux/disable can be used
 			later to disable prior to initial policy load.
 
-	apparmor=	[APPARMOR] Disable or enable AppArmor at boot time
-			Format: { "0" | "1" }
-			See security/apparmor/Kconfig help text
-			0 -- disable.
-			1 -- enable.
-			Default value is set via kernel config option.
-
 	serialnumber	[BUGS=X86-32]
 
 	shapers=	[NET]
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index b6b68a7750ce..3de21f46c82a 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -14,22 +14,6 @@ config SECURITY_APPARMOR
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_APPARMOR_BOOTPARAM_VALUE
-	int "AppArmor boot parameter default value"
-	depends on SECURITY_APPARMOR
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'apparmor', which allows AppArmor to be enabled or disabled
-          at boot.  If this option is set to 0 (zero), the AppArmor
-	  kernel parameter will default to 0, disabling AppArmor at
-	  boot.  If this option is set to 1 (one), the AppArmor
-	  kernel parameter will default to 1, enabling AppArmor at
-	  boot.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_APPARMOR_HASH
 	bool "Enable introspection of sha1 hashes for loaded profiles"
 	depends on SECURITY_APPARMOR
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index bc56b058dc75..4cd96a66ed6f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,15 +1303,12 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+static int apparmor_enabled __lsm_ro_after_init;
 module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
-	unsigned long enabled;
-	int error = kstrtoul(str, 0, &enabled);
-	if (!error)
-		apparmor_enabled = enabled ? 1 : 0;
+	pr_err("Boot param 'apparmor=' ignored. Use 'lsm.disable=apparmor'\n");
 	return 1;
 }
 
-- 
2.17.1
