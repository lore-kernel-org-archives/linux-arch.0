Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:55898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965793AbYCSVSv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2008 17:18:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: [PATCH 2/8] alpha ptrace: forced_successful_syscall_return()
In-Reply-To: Roland McGrath's message of  Wednesday, 19 March 2008 14:17:14 -0700 <20080319211714.8B14226F995@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
Message-ID: <20080319211841.253E126F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:18:41 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>, tony.luck@intel.com, linux-ia64@vger.kernel.org
Message-ID: <20080319211841.th_1uUwhFPTS3_GS6fGFFQ_0esfi4ivVrVf2La1GjOA@z>

Define the forced_successful_syscall_return() macro to
pair with our force_successful_syscall_return() definition.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 include/asm-alpha/ptrace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-alpha/ptrace.h b/include/asm-alpha/ptrace.h
index 32c7a5c..1cc330b 100644
--- a/include/asm-alpha/ptrace.h
+++ b/include/asm-alpha/ptrace.h
@@ -77,6 +77,7 @@ extern void show_regs(struct pt_regs *);
   ((struct pt_regs *) (task_stack_page(task) + 2*PAGE_SIZE) - 1)
 
 #define force_successful_syscall_return() (task_pt_regs(current)->r0 = 0)
+#define forced_successful_syscall_return() (task_pt_regs(current)->r0 == 0)
 
 #endif
 
