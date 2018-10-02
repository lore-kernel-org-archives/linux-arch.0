From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 26/32] LSM: Introduce "lsm.order=" for boottime ordering
Date: Mon,  1 Oct 2018 17:54:59 -0700
Message-ID: <20181002005505.6112-27-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Provide a way to reorder LSM initialization using the new "lsm.order="
comma-separated list of LSMs. Any LSMs not listed will be added in builtin
order.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 security/security.c                             | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0d10ab3d020e..7e01b7a1e73d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2286,6 +2286,12 @@
 			at boot time. This overrides any omissions from
 			CONFIG_LSM_ENABLE.
 
+	lsm.order=lsm1,...,lsmN
+			[SECURITY] Choose order of enabled LSM
+			initialization. Any builtin LSMs not listed here
+			will be implicitly appended to the list in builtin
+			order.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/security.c b/security/security.c
index 0510bb8e0af0..6fafad44b85e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -44,6 +44,7 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_enable;
 static __initdata const char *chosen_lsm_disable;
+static __initdata const char *chosen_lsm_order;
 static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
@@ -152,11 +153,14 @@ static void __init parse_lsm_order(const char *order, const char *origin)
 	kfree(sep);
 }
 
-/* Populate ordered LSMs list from builtin list of LSMs. */
+/* Populate ordered LSMs list from commandline and builtin list of LSMs. */
 static void __init prepare_lsm_order(void)
 {
 	struct lsm_info *lsm;
 
+	/* Parse order from commandline, if present. */
+	parse_lsm_order(chosen_lsm_order, "cmdline");
+
 	/* Parse order from builtin list. */
 	parse_lsm_order(builtin_lsm_order, "builtin");
 
@@ -316,6 +320,14 @@ static int __init choose_major_lsm(char *str)
 }
 __setup("security=", choose_major_lsm);
 
+/* Explicitly choose LSM initialization order. */
+static int __init choose_lsm_order(char *str)
+{
+	chosen_lsm_order = str;
+	return 1;
+}
+__setup("lsm.order=", choose_lsm_order);
+
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
 {
-- 
2.17.1
