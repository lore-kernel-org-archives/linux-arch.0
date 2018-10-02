From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 07/32] LSM: Convert security_initcall() into DEFINE_LSM()
Date: Mon,  1 Oct 2018 17:54:40 -0700
Message-ID: <20181002005505.6112-8-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Instead of using argument-based initializers, switch to defining the
contents of struct lsm_info on a per-LSM basis. This also drops
the final use of the now inaccurate "initcall" naming.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 ++---
 security/apparmor/lsm.c    | 4 +++-
 security/integrity/iint.c  | 4 +++-
 security/selinux/hooks.c   | 4 +++-
 security/smack/smack_lsm.c | 4 +++-
 security/tomoyo/tomoyo.c   | 4 +++-
 6 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d13059feca09..9c6b4198ff5a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2045,11 +2045,10 @@ struct lsm_info {
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
-#define security_initcall(lsm)						\
+#define DEFINE_LSM(lsm)							\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
-		__aligned(sizeof(unsigned long))			\
-		= { .init = lsm, }
+		__aligned(sizeof(unsigned long))
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8b8b70620bbe..c4863956c832 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1606,4 +1606,6 @@ static int __init apparmor_init(void)
 	return error;
 }
 
-security_initcall(apparmor_init);
+DEFINE_LSM(apparmor) = {
+	.init = apparmor_init,
+};
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 70d21b566955..94e8e1820748 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -175,7 +175,9 @@ static int __init integrity_iintcache_init(void)
 			      0, SLAB_PANIC, init_once);
 	return 0;
 }
-security_initcall(integrity_iintcache_init);
+DEFINE_LSM(integrity) = {
+	.init = integrity_iintcache_init,
+};
 
 
 /*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad9a9b8e9979..6ca2e89ddbd6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7202,7 +7202,9 @@ void selinux_complete_init(void)
 
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
-security_initcall(selinux_init);
+DEFINE_LSM(selinux) = {
+	.init = selinux_init,
+};
 
 #if defined(CONFIG_NETFILTER)
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 340fc30ad85d..c62e26939a69 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4882,4 +4882,6 @@ static __init int smack_init(void)
  * Smack requires early initialization in order to label
  * all processes and objects when they are created.
  */
-security_initcall(smack_init);
+DEFINE_LSM(smack) = {
+	.init = smack_init,
+};
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9f932e2d6852..b2d833999910 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -550,4 +550,6 @@ static int __init tomoyo_init(void)
 	return 0;
 }
 
-security_initcall(tomoyo_init);
+DEFINE_LSM(tomoyo) = {
+	.init = tomoyo_init,
+};
-- 
2.17.1
