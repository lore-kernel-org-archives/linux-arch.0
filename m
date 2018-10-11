From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v5 18/30] LSM: Introduce "lsm=" for boottime LSM selection
Date: Wed, 10 Oct 2018 17:18:34 -0700
Message-ID: <20181011001846.30964-19-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Provide a way to explicitly choose LSM initialization order via the new
"lsm=" comma-separated list of LSMs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 security/Kconfig                                |  3 ++-
 security/security.c                             | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 32d323ee9218..d6389ab66f49 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2276,6 +2276,10 @@
 
 	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
 
+	lsm=lsm1,...,lsmN
+			[SECURITY] Choose order of LSM initialization. This
+			overrides CONFIG_LSM.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/Kconfig b/security/Kconfig
index 005634f7c4bb..0aa82c1c928e 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -281,7 +281,8 @@ config LSM
 	default "integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
-	  Any LSMs left off this list will be ignored.
+	  Any LSMs left off this list will be ignored. This can be
+	  controlled at boot with the "lsm=" parameter.
 
 	  If unsure, leave this as the default.
 
diff --git a/security/security.c b/security/security.c
index 1c4889bce917..70cb2d0004e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -47,6 +47,7 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
+static __initdata const char *chosen_lsm_order;
 
 static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
@@ -190,7 +191,10 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	ordered_lsm_parse(builtin_lsm_order, "builtin");
+	if (chosen_lsm_order)
+		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+	else
+		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		maybe_initialize_lsm(*lsm);
@@ -252,6 +256,14 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
+/* Explicitly choose LSM initialization order. */
+static int __init choose_lsm_order(char *str)
+{
+	chosen_lsm_order = str;
+	return 1;
+}
+__setup("lsm=", choose_lsm_order);
+
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
 {
-- 
2.17.1
