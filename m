Return-Path: <SRS0=bmjM=EC=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5779AC4363A
	for <linux-arch@archiver.kernel.org>; Tue, 27 Oct 2020 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E3C2224E
	for <linux-arch@archiver.kernel.org>; Tue, 27 Oct 2020 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603835500;
	bh=Ka4lRA9eCqvV0mOQOAKOwdP3JXDO0/rJj+vKpZ1rCUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F0Eu2DKYqkyWedmwgsB8ZvtVGiNsMA5VZ8u7W8uOqM0TOWEEsUDrMg/62PNtUAqQ7
	 G0XbpHvKOWfeDbtCBoNCUOUFonm2sstKYw2zcxiDy2N5xUFAieGa3ruG9wdIldiqSP
	 nDJI/URAaPVgWf64R5V4yt78I5i7l0lKqwxvizSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374488AbgJ0Vvj (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgJ0Vvj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 17:51:39 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C464E22249;
        Tue, 27 Oct 2020 21:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835498;
        bh=Ka4lRA9eCqvV0mOQOAKOwdP3JXDO0/rJj+vKpZ1rCUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYFhzVnjg1EqcT7oLaMbsjThTi5jopeWooHM/SUSykJR7E/YAYGHKyk+lfPzBCkxB
         cCP/K9H5xhPonZa32Z4HOPjfWmCtNOoqaT7tLkkUsUF0WYUWjxPu+8RXw68R4JepEW
         Jd5kaSBSGx0jz4Sp7CbGuy99h2b4hktL2xGYDmXA=
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
Subject: [PATCH 6/6] arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
Date:   Tue, 27 Oct 2020 21:51:18 +0000
Message-Id: <20201027215118.27003-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027215118.27003-1-will@kernel.org>
References: <20201027215118.27003-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Allow systems with mismatched 32-bit support at EL0 to run 32-bit
applications based on a new kernel parameter.

Signed-off-by: Will Deacon <will@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 arch/arm64/kernel/cpufeature.c                  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..1d9021db4d9f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -289,6 +289,13 @@
 			do not want to use tracing_snapshot_alloc() as it needs
 			to be done where GFP_KERNEL allocations are allowed.
 
+	allow_mismatched_32bit_el0 [ARM64]
+			Allow execve() of 32-bit applications and setting of the
+			PER_LINUX32 personality on systems where not all of the
+			CPUs support 32-bit EL0. When this parameter is present,
+			the set of CPUs supporting 32-bit EL0 is indicated by
+			/sys/devices/system/cpu/aarch32_el0.
+
 	amd_iommu=	[HW,X86-64]
 			Pass parameters to the AMD IOMMU driver in the system.
 			Possible values are:
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9f29d4d1ef7e..ccc08da443ec 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1237,6 +1237,13 @@ bool system_has_mismatched_32bit_el0(void)
 	return fld == ID_AA64PFR0_EL0_64BIT_ONLY;
 }
 
+static int __init parse_32bit_el0_param(char *str)
+{
+	__allow_mismatched_32bit_el0 = true;
+	return 0;
+}
+early_param("allow_mismatched_32bit_el0", parse_32bit_el0_param);
+
 static ssize_t aarch32_el0_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-- 
2.29.0.rc2.309.g374f81d7ae-goog

