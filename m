From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v5 26/30] LSM: Split LSM preparation from initialization
Date: Wed, 10 Oct 2018 17:18:42 -0700
Message-ID: <20181011001846.30964-27-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since we already have to do a pass through the LSMs to figure out if
exclusive LSMs should be disabled after the first one is seen as enabled,
this splits the logic up a bit more cleanly. Now we do a full "prepare"
pass through the LSMs (which also allows for later use by the blob-sharing
code), before starting the LSM initialization pass.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/security/security.c b/security/security.c
index 4f52bd06705f..b40c4c212892 100644
--- a/security/security.c
+++ b/security/security.c
@@ -139,22 +139,28 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	return true;
 }
 
-/* Check if LSM should be initialized. */
-static void __init maybe_initialize_lsm(struct lsm_info *lsm)
+/* Prepare LSM for initialization. */
+static void __init prepare_lsm(struct lsm_info *lsm)
 {
 	int enabled = lsm_allowed(lsm);
 
 	/* Record enablement (to handle any following exclusive LSMs). */
 	set_enabled(lsm, enabled);
 
-	/* If selected, initialize the LSM. */
+	/* If enabled, do pre-initialization work. */
 	if (enabled) {
-		int ret;
-
 		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
 			exclusive = lsm;
 			init_debug("exclusive chosen: %s\n", lsm->name);
 		}
+	}
+}
+
+/* Initialize a given LSM, if it is enabled. */
+static void __init initialize_lsm(struct lsm_info *lsm)
+{
+	if (is_enabled(lsm)) {
+		int ret;
 
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
@@ -230,7 +236,10 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		maybe_initialize_lsm(*lsm);
+		prepare_lsm(*lsm);
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		initialize_lsm(*lsm);
 
 	kfree(ordered_lsms);
 }
-- 
2.17.1
