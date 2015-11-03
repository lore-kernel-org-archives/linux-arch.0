From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 12/28] init: allow architecture code to overide run_init_process
Date: Tue,  3 Nov 2015 22:20:43 +0200
Message-ID: <1446582059-17355-13-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

This is needed for arch/lkl where where execve can not be implemented
and init only runs in kernel space.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 init/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 9e64d70..efd8f7c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -905,13 +905,15 @@ void __init load_default_modules(void)
 	load_default_elevator_module();
 }
 
-static int run_init_process(const char *init_filename)
+#ifndef ARCH_RUN_INIT_PROCESS
+int run_init_process(const char *init_filename)
 {
 	argv_init[0] = init_filename;
 	return do_execve(getname_kernel(init_filename),
 		(const char __user *const __user *)argv_init,
 		(const char __user *const __user *)envp_init);
 }
+#endif
 
 static int try_to_run_init_process(const char *init_filename)
 {
-- 
2.1.0
