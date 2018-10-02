From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 11/32] LSM: Introduce LSM_FLAG_LEGACY_MAJOR
Date: Mon,  1 Oct 2018 17:54:44 -0700
Message-ID: <20181002005505.6112-12-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This adds a flag for the current "major" LSMs to distinguish them when
we have a universal method for ordering all LSMs. It's called "legacy"
since the distinction of "major" will go away in the blob-sharing world.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h  | 3 +++
 security/apparmor/lsm.c    | 1 +
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 security/tomoyo/tomoyo.c   | 1 +
 5 files changed, 7 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ae159b02f3ab..531e219a49b9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,8 +2039,11 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+#define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	unsigned long flags;	/* Optional: flags describing LSM */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index dca4b7dbf368..768cb539fb6c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1608,5 +1608,6 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = apparmor_init,
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9651bccae270..020886895819 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7204,6 +7204,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = selinux_init,
 };
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2fb56bcf1316..db8bc6b6d8b0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4884,5 +4884,6 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 1b5b5097efd7..09f7af130d3a 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -552,5 +552,6 @@ static int __init tomoyo_init(void)
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = tomoyo_init,
 };
-- 
2.17.1
