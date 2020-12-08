Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0785C19437
	for <linux-arch@archiver.kernel.org>; Tue,  8 Dec 2020 13:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ED023AFB
	for <linux-arch@archiver.kernel.org>; Tue,  8 Dec 2020 13:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgLHN3j (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgLHN3j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 08:29:39 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v5 03/15] KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
Date:   Tue,  8 Dec 2020 13:28:23 +0000
Message-Id: <20201208132835.6151-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208132835.6151-1-will@kernel.org>
References: <20201208132835.6151-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If a vCPU is caught running 32-bit code on a system with mismatched
support at EL0, then we should kill it.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/arm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c0ffb019ca8b..e63e8feae836 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -649,6 +649,15 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 	}
 }
 
+static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
+{
+	if (likely(!vcpu_mode_is_32bit(vcpu)))
+		return false;
+
+	return !system_supports_32bit_el0() ||
+		static_branch_unlikely(&arm64_mismatched_32bit_el0);
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -832,7 +841,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * with the asymmetric AArch32 case), return to userspace with
 		 * a fatal error.
 		 */
-		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+		if (vcpu_mode_is_bad_32bit(vcpu)) {
 			/*
 			 * As we have caught the guest red-handed, decide that
 			 * it isn't fit for purpose anymore by making the vcpu
-- 
2.29.2.576.ga3fc446d84-goog

