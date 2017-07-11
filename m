From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] arm64: mm: abort uaccess retries upon fatal signal
Date: Tue, 11 Jul 2017 15:16:29 +0100
Message-ID: <1499782590-31366-2-git-send-email-mark.rutland@arm.com>
References: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kerne@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, james.morse@arm.com, labbott@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, stable@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, viro@zeniv.linux.org.uk, peterz@infradead.org, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

When there's a fatal signal pending, arm64's do_page_fault()
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
Tested-by: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 37b95df..3952d5e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -397,8 +397,11 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	 * signal first. We do not need to release the mmap_sem because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+		if (!user_mode(regs))
+			goto no_context;
 		return 0;
+	}
 
 	/*
 	 * Major/minor page fault accounting is only done on the initial
-- 
1.9.1
