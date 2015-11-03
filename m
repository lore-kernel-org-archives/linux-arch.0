Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1240 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964827AbbKCUXN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 15:23:13 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 12/28] init: allow architecture code to overide run_init_process
Date: Tue,  3 Nov 2015 22:20:43 +0200
Message-ID: <1446582059-17355-13-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
Message-ID: <20151103202043.lj9RUDZQAOFIf_Xz6TEDAdJJ0IaqJA2mpXXe-rtCz0k@z>

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

