Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34871 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964980AbbKCUXY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 15:23:24 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 25/28] signal: use CONFIG_X86_32 instead of __i386__
Date: Tue,  3 Nov 2015 22:20:56 +0200
Message-ID: <1446582059-17355-26-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
Message-ID: <20151103202056.r9hgK-j9Xe4p_X-2Lok1zBiIQThVOOSHc_b9NbMtQeU@z>

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 0f6bbbe..0367131 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1137,7 +1137,7 @@ static void print_fatal_signal(int signr)
 	struct pt_regs *regs = signal_pt_regs();
 	printk(KERN_INFO "potentially unexpected fatal signal %d.\n", signr);
 
-#if defined(__i386__) && !defined(__arch_um__)
+#ifdef CONFIG_X86_32
 	printk(KERN_INFO "code at %08lx: ", regs->ip);
 	{
 		int i;
-- 
2.1.0

