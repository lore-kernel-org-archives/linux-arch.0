Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbdJ0KwE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Oct 2017 06:52:04 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v4 23/28] arm64/sve: KVM: Treat guest SVE use as undefined instruction execution
Date: Fri, 27 Oct 2017 11:51:05 +0100
Message-ID: <1509101470-7881-24-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
References: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171027105105.c9D3Q_uAU77tc6_bsqneEa2yQ3x8E95O7yeYTy0cWcc@z>

When trapping forbidden attempts by a guest to use SVE, we want the
guest to see a trap consistent with SVE not being implemented.

This patch injects an undefined instruction exception into the
guest in response to such an exception.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/handle_exit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 7debb74..b712479 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -147,6 +147,13 @@ static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 1;
 }
 
+static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* Until SVE is supported for guests: */
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
 static exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
@@ -160,6 +167,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
 	[ESR_ELx_EC_SMC64]	= handle_smc,
 	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
+	[ESR_ELx_EC_SVE]	= handle_sve,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
-- 
2.1.4
