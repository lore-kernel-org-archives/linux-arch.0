Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00332C64E75
	for <linux-arch@archiver.kernel.org>; Tue, 24 Nov 2020 15:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FEA206F7
	for <linux-arch@archiver.kernel.org>; Tue, 24 Nov 2020 15:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhnhzOvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390004AbgKXPv0 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:51:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390003AbgKXPv0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:26 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A5F2073C;
        Tue, 24 Nov 2020 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233085;
        bh=JWAroebb1HCZItIPh9mrc9nfp/6O6+i/SBzDf+inaQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhnhzOvvsJpomNu0T5ASHMnDS7sfnVRR/A4efOtlYFr+Cy5T+OtILRGPnMlo6wZez
         zS85xtQKOXcJYq+o4K6deKVSoQuvzLCNOCyc78a9ALua/2fYfqIytho+5y1Rpi46eO
         fiv3c6FEaMIuI4mExATX+8kpX/05B5Qfjiwlq/CU=
From:   Will Deacon <will@kernel.org>
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
Subject: [PATCH v4 09/14] cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
Date:   Tue, 24 Nov 2020 15:50:34 +0000
Message-Id: <20201124155039.13804-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If the scheduler cannot find an allowed CPU for a task,
cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
if cgroup v1 is in use.

In preparation for allowing architectures to provide their own fallback
mask, just return early if we're not using cgroup v2 and allow
select_fallback_rq() to figure out the mask by itself.

Cc: Li Zefan <lizefan@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/cgroup/cpuset.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 57b5b5d0a5fd..e970737c3ed2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3299,9 +3299,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
+	if (!is_in_v2_mode())
+		return; /* select_fallback_rq will try harder */
+
 	rcu_read_lock();
-	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
-		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
+	do_set_cpus_allowed(tsk, task_cs(tsk)->cpus_allowed);
 	rcu_read_unlock();
 
 	/*
-- 
2.29.2.454.gaff20da3a2-goog

