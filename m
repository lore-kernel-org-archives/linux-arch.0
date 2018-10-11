Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:35467 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeJLHJl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Oct 2018 03:09:41 -0400
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 5/7] mips/modules: Add rlimit checking for mips modules
Date: Thu, 11 Oct 2018 16:31:15 -0700
Message-ID: <20181011233117.7883-6-rick.p.edgecombe@intel.com>
In-Reply-To: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kernel-hardening@lists.openwall.com, daniel@iogearbox.net, keescook@chromium.org, catalin.marinas@arm.com, will.deacon@arm.com, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de, jeyu@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kristen@linux.intel.com, dave.hansen@intel.com, arjan@linux.intel.com, deneen.t.dock@intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Message-ID: <20181011233115.7QgGEWlBccKo7tDGI7UNzw0JYOcDKJBXT8y01Vg7doU@z>

This adds in the rlimit checking for the mips module allocator.

This has not been tested.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/mips/kernel/module.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 491605137b03..7a23392512d1 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -47,9 +47,18 @@ static DEFINE_SPINLOCK(dbe_lock);
 #ifdef MODULE_START
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
+	void *p;
+
+	if (check_inc_mod_rlimit(size))
+		return NULL;
+
+	p = __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
 				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
+
+	update_mod_rlimit(p, size);
+
+	return p;
 }
 #endif
 
-- 
2.17.1
