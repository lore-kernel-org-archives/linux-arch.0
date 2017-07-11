From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] arm: mm: abort uaccess retries upon fatal signal
Date: Tue, 11 Jul 2017 15:16:30 +0100
Message-ID: <1499782590-31366-3-git-send-email-mark.rutland@arm.com>
References: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kerne@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc: catalin.marinas@arm.com, james.morse@arm.com, labbott@redhat.com, mark.rutland@arm.com, stable@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, viro@zeniv.linux.org.uk, peterz@infradead.org, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

When there's a fatal signal pending, arm's do_page_fault()
implementation returns 0. The intent is that we'll return to the
faulting userspace instruction, delivering the signal on the way.

However, if we take a fatal signal during fixing up a uaccess, this
results in a return to the faulting kernel instruction, which will be
instantly retried, resulting in the same fault being taken forever. As
the task never reaches userspace, the signal is not delivered, and the
task is left unkillable. While the task is stuck in this state, it can
inhibit the forward progress of the system.

To avoid this, we must ensure that when a fatal signal is pending, we
apply any necessary fixup for a faulting kernel instruction. Thus we
will return to an error path, and it is up to that code to make forward
progress towards delivering the fatal signal.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Steve Capper <steve.capper@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: stable@vger.kernel.org
---
 arch/arm/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ff8b0aa..42f5853 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -315,8 +315,11 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 	 * signal first. We do not need to release the mmap_sem because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+		if (!user_mode(regs))
+			goto no_context;
 		return 0;
+	}
 
 	/*
 	 * Major/minor page fault accounting is only done on the
-- 
1.9.1
