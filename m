Return-Path: <SRS0=bmjM=EC=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD319C55178
	for <linux-arch@archiver.kernel.org>; Tue, 27 Oct 2020 21:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B96422267
	for <linux-arch@archiver.kernel.org>; Tue, 27 Oct 2020 21:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603835492;
	bh=c7zF3MN4y4ZK0euObvy+1HVIOy0osdnoCeXghTN/qeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KPl2A57NWEMVldnLSi9NphCX1+yELA52ASkwrmDSQWAAqua+nPajad543wvN2383s
	 030JKddWV4+RZLFcAHf1FNSlaolDhTXDd1yguMdJFec67FQD7poAUK61iglgbxPIal
	 zzITrS8AJ6BcAF1la2Tl5J4yPSQKBIMwQUOqaxW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374484AbgJ0Vvc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505991AbgJ0Vvb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 17:51:31 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28282222C;
        Tue, 27 Oct 2020 21:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835491;
        bh=c7zF3MN4y4ZK0euObvy+1HVIOy0osdnoCeXghTN/qeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cs8xjkwYMhG1Qbc9ORqEL9fFj8Ar5rtdS8yziDGSJb6k7+xWOrU4yAdHabSoVSg88
         Ivjkq0sCRYqfRctT1ZOtPpLbMj1+y4QtdOAwA/jEAdmeEGinzwTVmv7dhfziUya4eP
         g3LyBdRM3zWiFk75vMwFzAUQjydR58S4pkIVqmEw=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: [PATCH 3/6] KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
Date:   Tue, 27 Oct 2020 21:51:15 +0000
Message-Id: <20201027215118.27003-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027215118.27003-1-will@kernel.org>
References: <20201027215118.27003-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If a vCPU tries to run 32-bit code on a system with mismatched support
at EL0, then we should kill it.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/arm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a3b32df1afb0..7150dd996e1d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -633,6 +633,14 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 	}
 }
 
+static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
+{
+	if (likely(!vcpu_mode_is_32bit(vcpu)))
+		return false;
+
+	return !system_supports_32bit_el0() || system_has_mismatched_32bit_el0();
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -816,7 +824,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * with the asymmetric AArch32 case), return to userspace with
 		 * a fatal error.
 		 */
-		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+		if (vcpu_mode_is_bad_32bit(vcpu)) {
 			/*
 			 * As we have caught the guest red-handed, decide that
 			 * it isn't fit for purpose anymore by making the vcpu
-- 
2.29.0.rc2.309.g374f81d7ae-goog

