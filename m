From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 29/32] LSM: Introduce enum lsm_order
Date: Mon,  1 Oct 2018 17:55:02 -0700
Message-ID: <20181002005505.6112-30-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In preparation for distinguishing the "capability" LSM from other LSMs,
it must be ordered first. This introduces LSM_ORDER_MUTABLE for the
general LSMs, LSM_ORDER_FIRST for capabilities, and LSM_ORDER_LAST for
anything that must run last (e.g. Landlock may use this in the future).

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  7 +++++++
 security/security.c       | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 63a6caaee8e6..62bc230826e0 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2041,8 +2041,15 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 
+enum lsm_order {
+	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
+	LSM_ORDER_MUTABLE = 0,
+	LSM_ORDER_LAST,
+};
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: set based on CONFIG_LSM_ENABLE */
 	int (*init)(void);	/* Required. */
diff --git a/security/security.c b/security/security.c
index 44c23d23158e..dac379518e60 100644
--- a/security/security.c
+++ b/security/security.c
@@ -140,7 +140,8 @@ static void __init parse_lsm_order(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
+			if (lsm->order == LSM_ORDER_MUTABLE &&
+			    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
 			    strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
@@ -158,6 +159,12 @@ static void __init prepare_lsm_order(void)
 {
 	struct lsm_info *lsm;
 
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_ordered_lsm(lsm, "first");
+	}
+
 	/* Parse order from commandline, if present. */
 	parse_lsm_order(chosen_lsm_order, "cmdline");
 
@@ -166,9 +173,16 @@ static void __init prepare_lsm_order(void)
 
 	/* Add any missing LSMs, in link order. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+		if (lsm->order == LSM_ORDER_MUTABLE &&
+		    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			append_ordered_lsm(lsm, "link-time");
 	}
+
+	/* LSM_ORDER_LAST is always last. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_LAST)
+			append_ordered_lsm(lsm, "last");
+	}
 }
 
 /* Is an LSM allowed to be initialized? */
-- 
2.17.1
