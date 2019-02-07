Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:50987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfBGMq5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Feb 2019 07:46:57 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 5/7] powerpc: Add ppc_md.name to dump stack arch description
Date: Thu,  7 Feb 2019 23:46:33 +1100
Message-ID: <20190207124635.3885-5-mpe@ellerman.id.au>
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@ozlabs.org
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
Message-ID: <20190207124633.jTa4yDOu2-RuDIeAZ5LIT6rGMn-tzt7srcqe2p5JcGA@z>

As soon as we know the name of the machine description we're using, add
it to the dump stack arch description, which is printed in case of an
oops.

eg: Hardware name: ... machine:pSeries

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ca00fbb97cf8..00d900b1e584 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/platform_device.h>
+#include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
@@ -638,6 +639,8 @@ void probe_machine(void)
 		for (;;);
 	}
 
+	dump_stack_add_arch_desc("machine:%s", ppc_md.name);
+
 	printk(KERN_INFO "Using %s machine description\n", ppc_md.name);
 }
 
-- 
2.20.1
