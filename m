From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 25/28] signal: use CONFIG_X86_32 instead of __i386__
Date: Tue,  3 Nov 2015 22:20:56 +0200
Message-ID: <1446582059-17355-26-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

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
