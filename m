From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 31/32] LSM: Separate idea of "major" LSM from "exclusive" LSM
Date: Mon,  1 Oct 2018 17:55:04 -0700
Message-ID: <20181002005505.6112-32-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In order to both support old "security=" Legacy Major LSM selection, and
handling real exclusivity, this creates LSM_FLAG_EXCLUSIVE and updates
the selection logic to handle them.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/apparmor/lsm.c    |  2 +-
 security/security.c        | 12 ++++++++++++
 security/selinux/hooks.c   |  2 +-
 security/smack/smack_lsm.c |  2 +-
 security/tomoyo/tomoyo.c   |  2 +-
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 36e7a716fdfe..2c9cf89a20ad 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+#define LSM_FLAG_EXCLUSIVE	BIT(1)
 
 enum lsm_order {
 	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4cd96a66ed6f..4eb74a6f2020 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1599,7 +1599,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 };
diff --git a/security/security.c b/security/security.c
index 813dab3b5b97..7d542e78b7e8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,6 +52,7 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
+static __initdata struct lsm_info *exclusive;
 
 static __initdata bool debug;
 #define init_debug(...)						\
@@ -196,6 +197,12 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (!is_enabled(lsm))
 		return false;
 
+	/* Not allowed if another exclusive LSM already initialized. */
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		return false;
+	}
+
 	return true;
 }
 
@@ -211,6 +218,11 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		int ret;
 
+		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+			exclusive = lsm;
+			init_debug("exclusive: %s\n", lsm->name);
+		}
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8f5eea097612..c070d3761ddc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7181,7 +7181,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled,
 	.init = selinux_init,
 };
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f243044d5a55..92e4baa342f8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4881,6 +4881,6 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index a46f6bc1e97c..daff7d7897ad 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -550,6 +550,6 @@ static int __init tomoyo_init(void)
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = tomoyo_init,
 };
-- 
2.17.1
