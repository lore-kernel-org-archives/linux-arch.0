From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 05/18] x86: implement nospec_barrier()
Date: Fri, 05 Jan 2018 17:10:21 -0800
Message-ID: <151520102116.32271.8160376567325482844.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753456AbeAFBSg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jan 2018 20:18:36 -0500
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, netdev@vger.kernel.org, Alan Cox <alan.cox@intel.com>, tglx@linutronix.de, Arjan van de Ven <arjan@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

The new speculative execution barrier, nospec_barrier(), ensures
that any userspace controllable speculation doesn't cross the boundary.

Any user observable speculative activity on this CPU thread before this
point either completes, reaches a state it can no longer cause an
observable activity, or is aborted before instructions after the barrier
execute.

In the x86 case nospec_barrier() resolves to an lfence if
X86_FEATURE_LFENCE_RDTSC is present. Other architectures can define
their variants.

Note the expectation is that this barrier is never used directly, at
least outside of architecture specific code. It is implied by the
nospec_{array_ptr,ptr} macros.

x86, for now, depends on the barrier for protection while other
architectures place their speculation prevention in
nospec_{ptr,array_ptr} when a barrier instruction is not available or
too heavy-weight. In the x86 case lfence is not a fully serializing
instruction so it is not as expensive as other barriers.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
Suggested-by: Alan Cox <alan.cox@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/barrier.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7fb336210e1b..1148cd9f5ae7 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -24,6 +24,12 @@
 #define wmb()	asm volatile("sfence" ::: "memory")
 #endif
 
+/*
+ * CPUs without LFENCE don't really speculate much. Possibly fall back to IRET-to-self.
+ */
+#define __nospec_barrier() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
+#define nospec_barrier __nospec_barrier
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else
