From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [RFC] remove linux/hardirq.h from asm-generic/local.h
Date: Sun, 14 Dec 2008 13:39:41 +0000
Message-ID: <20081214133941.GA18035@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53563 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbYLNNjw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 14 Dec 2008 08:39:52 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

While looking at reducing the amount of architecture namespace pollution
in the generic kernel, I found that asm/irq.h is included in the vast
majority of compilations on ARM (around 650 files.)

Since asm/irq.h includes a sub-architecture include file on ARM, this
causes a negative impact on the ccache's ability to re-use the build
results from other sub-architectures, so we have a desire to reduce
the dependencies on asm/irq.h.

It turns out that a major cause of this is the needless include of
linux/hardirq.h into asm-generic/local.h.  The patch below removes this
include, resulting in some 250 to 300 files (around half) of the kernel
then omitting asm/irq.h.

My test builds still succeed, provided two ARM files are fixed
(arch/arm/kernel/traps.c and arch/arm/mm/fault.c) - so there may be
negative impacts for this on other architectures.

Note that x86 does not include asm/irq.h nor linux/hardirq.h in its
asm/local.h, so this patch can be viewed as bringing the generic version
into line with the x86 version.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
index 33d7d04..43c0b81 100644
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -2,7 +2,6 @@
 #define _ASM_GENERIC_LOCAL_H
 
 #include <linux/percpu.h>
-#include <linux/hardirq.h>
 #include <asm/atomic.h>
 #include <asm/types.h>
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
