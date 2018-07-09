Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50569 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeGINqC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 09:46:02 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Mon,  9 Jul 2018 16:45:50 +0300
Message-ID: <20180709134550.29541-1-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, David Laight <David.Laight@ACULAB.COM>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>, stable@vger.kernel.org
Message-ID: <20180709134550.l0T2o2ERSJOS9uSEA50f0Xwgc4_dVod5_S-1CoUbjzM@z>

data[] must be 64-bit aligned even on 32-bit architectures because
it might be accessed by instructions that require aligned memory arguments.

One example is "atomic64_t" type accessed by special atomic instructions
which may read/write entire 64-bit word.

Atomic instructions are a bit special compared to normal loads and stores.
Even if normal loads and stores may deal with unaligned data, atomic
instructions still require data to be aligned because it's hard to manage
atomic value that spans through multiple cache lines or even MMU pages.
And hardware just raises an alignment fault exception.

The problem with previously used approach is that depending on ABI
"long long" type of a particular 32-bit CPU might be aligned to
8-, 16-, 32- or 64-bit boundary. Which will get in the way of mentioned
above atomic instructions.

Consider the following snippet:
|        struct mystruct {
|                atomic64_t myvar;
|        }
|
|        struct mystruct *p;
|        p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);

Here address of "myvar" will match  data[] in "struct devres",
that said if "data" is not 64-bit aligned atomic instruction will
fail on the first access to "myvar".

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Cc: <stable@vger.kernel.org> # 4.8+
---

Changes v2 -> v3:

 * Align explicitly to 8 bytes [David]
 * Rephrased in-line comment [David]
 * Added more techinical details to commit message [Greg]
 * Mention more alignment options in commit message [Geert]

Changes v1 -> v2:

 * Reworded commit message
 * Inserted comment right in source [Thomas]

 drivers/base/devres.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f98a097e73f2..d65327cb83c9 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -24,8 +24,12 @@ struct devres_node {
 
 struct devres {
 	struct devres_node		node;
-	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	/*
+	 * data[] must be 64 bit aligned even on 32 bit architectures
+	 * because it might be accessed by instructions that require
+	 * aligned memory arguments such as atomic64_t.
+	 */
+	u8 __aligned(8)			data[];
 };
 
 struct devres_group {
-- 
2.17.1
