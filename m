From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v3 14/29] LSM: Plumb visibility into optional "enabled" state
Date: Mon, 24 Sep 2018 17:18:17 -0700
Message-ID: <20180925001832.18322-15-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In preparation for lifting the "is this LSM enabled?" logic out of the
individual LSMs, pass in any special enabled state tracking (as needed
for SELinux, AppArmor, and LoadPin). This should be an "int" to include
handling any future cases where "enabled" is exposed via sysctl which
has no "bool" type.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 1 +
 security/apparmor/lsm.c   | 5 +++--
 security/selinux/hooks.c  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5056f7374b3d..2a41e8e6f6e5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Populated automatically. */
 	unsigned long flags;	/* Optional: flags describing LSM */
+	int *enabled;		/* Optional: NULL means enabled. */
 	int (*init)(void);
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4c5f63e9aeba..d03133a267f2 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,8 +1303,8 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
-module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
+static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
@@ -1608,5 +1608,6 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor)
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 END_LSM;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 615cf6498c0f..3f999ed98cfd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7204,6 +7204,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux)
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &selinux_enabled,
 	.init = selinux_init,
 END_LSM;
 
-- 
2.17.1
