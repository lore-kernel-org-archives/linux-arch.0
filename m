Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:40765 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfEWQL3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 May 2019 12:11:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190523003916.20726-1-ebiederm@xmission.com>
        <20190523003916.20726-4-ebiederm@xmission.com>
        <20190523101702.GG26646@fuggles.cambridge.arm.com>
Date: Thu, 23 May 2019 11:11:19 -0500
In-Reply-To: <20190523101702.GG26646@fuggles.cambridge.arm.com> (Will Deacon's
        message of "Thu, 23 May 2019 11:17:02 +0100")
Message-ID: <875zq1gnh4.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCHv2 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20190523161119.ZXUqrx5vw2HJsWbXpxA-UkMdrpMX9MUDjPK_GnuIAoI@z>


I don't think this is userspace visible but SIGKILL does not have
any si_codes that use the fault member of the siginfo union.  Correct
this the simple way and call force_sig instead of force_sig_fault when
the signal is SIGKILL.

The two know places where synchronous SIGKILL are generated are
do_bad_area and fpsimd_save.  The call paths to force_sig_fault are:
do_bad_area
  arm64_force_sig_fault
    force_sig_fault
force_signal_inject
  arm64_notify_die
    arm64_force_sig_fault
       force_sig_fault

Which means correcting this in arm64_force_sig_fault is enough
to ensure the arm64 code is not misusing the generic code, which
could lead to maintenance problems later.

Cc: stable@vger.kernel.org
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I have also made the corresponding changes to:
09/26 signal: Remove task parameter from force_sig
21/26 signal: Remove the task parameter from force_sig_fault
But I will leave off reposting those as for now as the changes
are obvious.

arch/arm64/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ade32046f3fe..e45d5b440fb1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -256,7 +256,10 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
 			   const char *str)
 {
 	arm64_show_signal(signo, str);
-	force_sig_fault(signo, code, addr, current);
+	if (signo == SIGKILL)
+		force_sig(SIGKILL, current);
+	else
+		force_sig_fault(signo, code, addr, current);
 }
 
 void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
-- 
2.21.0.dirty
