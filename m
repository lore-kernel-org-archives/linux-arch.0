Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:59063 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBIH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:08:07 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:38:53 -0500
Message-ID: <20190523003916.20726-4-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20190523003853.-H6fvS88pjK4TlEA3Pl2puVB4rkSfmDLOwRrpBwrmZM@z>

It really only matters to debuggers but the SIGKILL does not have any
si_codes that use the fault member of the siginfo union.  Correct this
the simple way and call force_sig instead of force_sig_fault when the
signal is SIGKILL.

Cc: stable@vger.kernel.org
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/traps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ade32046f3fe..0feb17bdcaa0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -282,6 +282,11 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 		current->thread.fault_address = 0;
 		current->thread.fault_code = err;
 
+		if (signo == SIGKILL) {
+			arm64_show_signal(signo, str);
+			force_sig(signo, current);
+			return;
+		}
 		arm64_force_sig_fault(signo, sicode, addr, str);
 	} else {
 		die(str, regs, err);
-- 
2.21.0
