Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f193.google.com ([209.85.166.193]:50282 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeJBHpA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 03:45:00 -0400
Received: by mail-it1-f193.google.com with SMTP id j81-v6so1034061ite.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 18:04:29 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 17/32] LSM: Introduce CONFIG_LSM_ENABLE
Date: Mon,  1 Oct 2018 17:54:50 -0700
Message-ID: <20181002005505.6112-18-keescook@chromium.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181002005450.jVSosmoZFaZk3xoKoNTR0FWoQnWhMdFQv9poR2vIb_U@z>

To provide a set of default-enabled LSMs at boot, this introduces the
new CONFIG_LSM_ENABLE. A value of "all" means all builtin LSMs are
enabled by default. Any unlisted LSMs will be implicitly disabled
(excepting those with LSM-specific CONFIGs for enabling/disabling).

The behavior of the LSM-specific CONFIGs for SELinux are AppArmor
unchanged: the default-enabled state for those LSMs remains controlled
through their LSM-specific "enable" CONFIGs.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 2 +-
 security/Kconfig          | 8 ++++++++
 security/security.c       | 4 +++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9ecb623fb39d..fd85637a1931 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL means enabled. */
+	int *enabled;		/* Optional: NULL checks CONFIG_LSM_ENABLE */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/Kconfig b/security/Kconfig
index 27d8b2688f75..ac23feba584d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -276,5 +276,13 @@ config DEFAULT_SECURITY
 	default "apparmor" if DEFAULT_SECURITY_APPARMOR
 	default "" if DEFAULT_SECURITY_DAC
 
+config LSM_ENABLE
+	string "LSMs to enable at boot time"
+	default "all"
+	help
+	  A comma-separated list of LSMs to enable by default at boot. The
+	  default is "all", to enable all LSM modules at boot. Any LSMs
+	  not listed here will be disabled by default.
+
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 9459b4ee4fd9..35601000176b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -45,6 +45,8 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -182,7 +184,7 @@ static void __init parse_lsm_enable(const char *str,
 static void __init prepare_lsm_enable(void)
 {
 	/* Prepare defaults. */
-	parse_lsm_enable("all", default_enabled, true);
+	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
 }
 
 /**
-- 
2.17.1
