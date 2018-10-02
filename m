Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:52626 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBHo5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 03:44:57 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so1016030itz.2
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 18:04:26 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 18/32] LSM: Introduce lsm.enable= and lsm.disable=
Date: Mon,  1 Oct 2018 17:54:51 -0700
Message-ID: <20181002005505.6112-19-keescook@chromium.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181002005451.6E3xwv1-Klfjh9Ak337TUTaER0Y_iIAUbIpVFJdMMtk@z>

This introduces the "lsm.enable=..." and "lsm.disable=..." boot parameters
which each can contain a comma-separated list of LSMs to enable or
disable, respectively. The string "all" matches all LSMs.

This has very similar functionality to the existing per-LSM enable
handling ("apparmor.enabled=...", etc), but provides a centralized
place to perform the changes. These parameters take precedent over any
LSM-specific boot parameters.

Disabling an LSM means it will not be considered when performing
initializations. Enabling an LSM means either undoing a previous
LSM-specific boot parameter disabling or a undoing a default-disabled
CONFIG setting.

For example: "lsm.disable=apparmor apparmor.enabled=1" will result in
AppArmor being disabled. "selinux.enabled=0 lsm.enable=selinux" will
result in SELinux being enabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 .../admin-guide/kernel-parameters.txt         | 12 ++++++++++
 security/Kconfig                              |  4 +++-
 security/security.c                           | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 32d323ee9218..67c90985d2b8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2276,6 +2276,18 @@
 
 	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
 
+	lsm.disable=lsm1,...,lsmN
+			[SECURITY] Comma-separated list of LSMs to disable
+			at boot time. This overrides "lsm.enable=",
+			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
+			parameters.
+
+	lsm.enable=lsm1,...,lsmN
+			[SECURITY] Comma-separated list of LSMs to enable
+			at boot time. This overrides any omissions from
+			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
+			boot parameters.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/Kconfig b/security/Kconfig
index ac23feba584d..1e57619fd561 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -282,7 +282,9 @@ config LSM_ENABLE
 	help
 	  A comma-separated list of LSMs to enable by default at boot. The
 	  default is "all", to enable all LSM modules at boot. Any LSMs
-	  not listed here will be disabled by default.
+	  not listed here will be disabled by default. This can be
+	  changed with the "lsm.enable=" and "lsm.disable=" boot
+	  parameters.
 
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 35601000176b..3fff2d1d1ec4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -44,6 +44,8 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
+static __initdata const char *chosen_lsm_enable;
+static __initdata const char *chosen_lsm_disable;
 
 static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
 
@@ -185,6 +187,10 @@ static void __init prepare_lsm_enable(void)
 {
 	/* Prepare defaults. */
 	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
+
+	/* Process "lsm.enable=" and "lsm.disable=", if given. */
+	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
+	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
 }
 
 /**
@@ -240,6 +246,22 @@ static int __init enable_debug(char *str)
 }
 __setup("lsm.debug", enable_debug);
 
+/* Explicitly enable a list of LSMs. */
+static int __init enable_lsm(char *str)
+{
+	chosen_lsm_enable = str;
+	return 1;
+}
+__setup("lsm.enable=", enable_lsm);
+
+/* Explicitly disable a list of LSMs. */
+static int __init disable_lsm(char *str)
+{
+	chosen_lsm_disable = str;
+	return 1;
+}
+__setup("lsm.disable=", disable_lsm);
+
 static bool match_last_lsm(const char *list, const char *lsm)
 {
 	const char *last;
-- 
2.17.1
