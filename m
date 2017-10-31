Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753542AbdJaPvh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Oct 2017 11:51:37 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v5 03/30] arm64: signal: Verify extra data is user-readable in sys_rt_sigreturn
Date: Tue, 31 Oct 2017 15:50:55 +0000
Message-ID: <1509465082-30427-4-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171031155055.gKDye_J1Nyb4QBs3MzRStqH7LgZsM-ex1X-RNk3bw28@z>

Currently sys_rt_sigreturn() verifies that the base sigframe is
readable, but no similar check is performed on the extra data to
which an extra_context record points.

This matters because the extra data will be read with the
unprotected user accessors.  However, this is not a problem at
present because the extra data base address is required to be
exactly at the end of the base sigframe.  So, there would need to
be a non-user-readable kernel address within about 59K
(SIGFRAME_MAXSZ - sizeof(struct rt_sigframe)) of some address for
which access_ok(VERIFY_READ) returns true, in order for sigreturn
to be able to read kernel memory that should be inaccessible to the
user task.  This is currently impossible due to the untranslatable
address hole between the TTBR0 and TTBR1 address ranges.

Disappearance of the hole between the TTBR0 and TTBR1 mapping
ranges would require the VA size for TTBR0 and TTBR1 to grow to at
least 55 bits, and either the disabling of tagged pointers for
userspace or enabling of tagged pointers for kernel space; none of
which is currently envisaged.

Even so, it is wrong to use the unprotected user accessors without
an accompanying access_ok() check.

To avoid the potential for future surprises, this patch does an
explicit access_ok() check on the extra data space when parsing an
extra_context record.

Fixes: 33f082614c34 ("arm64: signal: Allow expansion of the signal frame")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0bdc96c..4716729 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -343,6 +343,10 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			 */
 			offset = 0;
 			limit = extra_size;
+
+			if (!access_ok(VERIFY_READ, base, limit))
+				goto invalid;
+
 			continue;
 
 		default:
-- 
2.1.4
