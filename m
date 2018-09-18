Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:46241 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFgb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 01:36:31 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 02:05:30 +0200
Message-ID: <20180918000546.12552-4-ebiederm@xmission.com>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Subject: [REVIEW][PATCH 04/20] signal/x86: Use send_sig_mceerr as apropriate
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918000530.CYhRgNeGhwouTnDzvnZc8wiAV1dv2A1h4L1NtZZi9s0@z>

This simplifies the code making it clearer what is going on.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kvm/mmu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index a282321329b5..95349bfe3b59 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3114,16 +3114,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 
 static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *tsk)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo	= SIGBUS;
-	info.si_errno	= 0;
-	info.si_code	= BUS_MCEERR_AR;
-	info.si_addr	= (void __user *)address;
-	info.si_addr_lsb = PAGE_SHIFT;
-
-	send_sig_info(SIGBUS, &info, tsk);
+	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
 }
 
 static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
-- 
2.17.1
