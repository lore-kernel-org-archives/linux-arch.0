From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 19/26] LSM: Introduce CONFIG_LSM_ORDER
Date: Thu, 20 Sep 2018 09:23:31 -0700
Message-ID: <20180920162338.21060-20-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This provides a way to declare LSM initialization order via Kconfig.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig    | 11 +++++++++++
 security/security.c | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 27d8b2688f75..de8202886c1d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -276,5 +276,16 @@ config DEFAULT_SECURITY
 	default "apparmor" if DEFAULT_SECURITY_APPARMOR
 	default "" if DEFAULT_SECURITY_DAC
 
+config LSM_ORDER
+	string "Default initialization order of builtin LSMs"
+	default "integrity"
+	help
+	  A comma-separated list of LSMs, in initialization order.
+	  Any LSMs left off this list will be link-order initialized
+	  after any listed LSMs. Any LSMs listed here but not built in
+	  the kernel will be ignored.
+
+	  If unsure, leave this as the default.
+
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 2541a512a0f7..063ee2466e58 100644
--- a/security/security.c
+++ b/security/security.c
@@ -44,6 +44,8 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_major_lsm;
 
+static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
+
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
 
@@ -108,14 +110,44 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		   (!lsm->enabled || *lsm->enabled) ? "en" : "dis");
 }
 
-/* Populate ordered LSMs list from hard-coded list of LSMs. */
+/* Populate ordered LSMs list from given string. */
+static void __init parse_lsm_order(const char *order, const char *origin)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	sep = kstrdup(order, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		bool found = false;
+
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
+			    strcmp(lsm->name, name) == 0) {
+				append_ordered_lsm(lsm, origin);
+				found = true;
+			}
+		}
+
+		if (!found)
+			init_debug("%s ignored: %s\n", origin, name);
+	}
+	kfree(sep);
+}
+
+/* Populate ordered LSMs list from builtin list of LSMs. */
 static void __init prepare_lsm_order(void)
 {
 	struct lsm_info *lsm;
 
+	/* Parse order from builtin list. */
+	parse_lsm_order(builtin_lsm_order, "builtin");
+
+	/* Add any missing LSMs, in link order. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (strcmp(lsm->name, "integrity") == 0)
-			append_ordered_lsm(lsm, "builtin");
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+			append_ordered_lsm(lsm, "link-time");
 	}
 }
 
-- 
2.17.1
