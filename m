From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v5 29/30] LSM: Introduce enum lsm_order
Date: Wed, 10 Oct 2018 17:18:45 -0700
Message-ID: <20181011001846.30964-30-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In preparation for distinguishing the "capability" LSM from other LSMs, it
must be ordered first. This introduces LSM_ORDER_MUTABLE for the general
LSMs and LSM_ORDER_FIRST for capability. In the future LSM_ORDER_LAST
for could be added for anything that must run last (e.g. Landlock may
use this).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 6 ++++++
 security/security.c       | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 833ec0f03795..97898679a505 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2042,8 +2042,14 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
 
+enum lsm_order {
+	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
+	LSM_ORDER_MUTABLE = 0,
+};
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
diff --git a/security/security.c b/security/security.c
index 2eb8afdd945d..004938eb8e70 100644
--- a/security/security.c
+++ b/security/security.c
@@ -174,6 +174,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_ordered_lsm(lsm, "first");
+	}
+
 	sep = kstrdup(order, GFP_KERNEL);
 	next = sep;
 	/* Walk the list, looking for matching LSMs. */
@@ -181,7 +187,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (strcmp(lsm->name, name) == 0) {
+			if (lsm->order == LSM_ORDER_MUTABLE &&
+			    strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
 			}
-- 
2.17.1
