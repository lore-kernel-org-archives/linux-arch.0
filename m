Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932289AbdJaPwa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Oct 2017 11:52:30 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v5 30/30] arm64/sve: signal: Include SVE when computing AT_MINSIGSTKSZ
Date: Tue, 31 Oct 2017 15:51:22 +0000
Message-ID: <1509465082-30427-31-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171031155122.O7V194e2EwIXH4WlYeSXiq8uA9X2-JY8V5UCJ7fex-M@z>

The SVE context block in the signal frame needs to be considered
too when computing the maximum possible signal frame size.

Because the size of this block depends on the vector length, this
patch computes the size based not on the thread's current vector
length but instead on the maximum possible vector length: this
determines the maximum size of SVE context block that can be
observed in any signal frame for the lifetime of the process.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
---
 arch/arm64/kernel/signal.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 7c7d9ae..9b8aa92 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -599,8 +599,18 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 	if (system_supports_sve()) {
 		unsigned int vq = 0;
 
-		if (test_thread_flag(TIF_SVE))
-			vq = sve_vq_from_vl(current->thread.sve_vl);
+		if (add_all || test_thread_flag(TIF_SVE)) {
+			int vl = sve_max_vl;
+
+			if (!add_all)
+				vl = current->thread.sve_vl;
+
+			/* Fail safe if something wasn't initialised */
+			if (WARN_ON(!sve_vl_valid(vl)))
+				vl = SVE_VL_MIN;
+
+			vq = sve_vq_from_vl(vl);
+		}
 
 		err = sigframe_alloc(user, &user->sve_offset,
 				     SVE_SIG_CONTEXT_SIZE(vq));
-- 
2.1.4
