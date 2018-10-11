From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v5 19/30] LSM: Tie enabling logic to presence in ordered list
Date: Wed, 10 Oct 2018 17:18:35 -0700
Message-ID: <20181011001846.30964-20-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Until now, any LSM without an enable storage variable was considered
enabled. This inverts the logic and sets defaults to true only if the
LSM gets added to the ordered initialization list. (And an exception
continues for the major LSMs until they are integrated into the ordered
initialization in a later patch.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h |  2 +-
 security/security.c       | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9ecb623fb39d..b6b05d351eb4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL means enabled. */
+	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/security.c b/security/security.c
index 70cb2d0004e9..f3777ed4ca80 100644
--- a/security/security.c
+++ b/security/security.c
@@ -63,10 +63,10 @@ static __initdata bool debug;
 
 static bool __init is_enabled(struct lsm_info *lsm)
 {
-	if (!lsm->enabled || *lsm->enabled)
-		return true;
+	if (!lsm->enabled)
+		return false;
 
-	return false;
+	return *lsm->enabled;
 }
 
 /* Mark an LSM's enabled flag. */
@@ -117,7 +117,11 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
 		return;
 
+	/* Enable this LSM, if it is not already set. */
+	if (!lsm->enabled)
+		lsm->enabled = &lsm_enabled_true;
 	ordered_lsms[last_lsm++] = lsm;
+
 	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
 		   is_enabled(lsm) ? "en" : "dis");
 }
@@ -210,6 +214,10 @@ static void __init major_lsm_init(void)
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			continue;
 
+		/* Enable this LSM, if it is not already set. */
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+
 		maybe_initialize_lsm(lsm);
 	}
 }
-- 
2.17.1
