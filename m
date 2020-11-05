Return-Path: <SRS0=N3NN=EL=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2960C388F7
	for <linux-arch@archiver.kernel.org>; Thu,  5 Nov 2020 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D4720867
	for <linux-arch@archiver.kernel.org>; Thu,  5 Nov 2020 22:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604613646;
	bh=7l6tGF0alUSY3vg1SiRxaBP3LE7HEENfH/MIrpUO438=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=odRr1fpm0DrTo6oDWt3m3gsStoTI62nkTq7RiqQBjeQSpqtj+wiPU4ERtE3ZO7Teb
	 GeDe8HtTP4QliYqMDiOdogYHYLeJIl9vdbBwuRoKHqOJZwCUjQbNFDuRR5l05d9FLw
	 eyszhWGTCKtRANpE54FAo+rzcyhxwwtkaZHmgASM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbgKEWAY (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbgKEWAW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Nov 2020 17:00:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88AF3221FA;
        Thu,  5 Nov 2020 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613621;
        bh=7l6tGF0alUSY3vg1SiRxaBP3LE7HEENfH/MIrpUO438=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWskn2+3aO7x/jmdukAuKRcwcCyMp/z6nYiKfmN2condzYAOIjI/EbiJO9GuMWcnd
         iWn7LS61Kz/inMC+R3ddZDAgJRQO0vBTmFprWoDYzMUvEgqs3i7ggzV0DfYcUXCf68
         ob+XbXQ7U/bv26o5EE9RzGhAn8r/g5LSc7rW6Znk=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Fox Chen <foxhlchen@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 4/8] docs/memory-barriers.txt: Fix a typo in CPU MEMORY BARRIERS section
Date:   Thu,  5 Nov 2020 14:00:13 -0800
Message-Id: <20201105220017.15410-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105215953.GA15309@paulmck-ThinkPad-P72>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Fox Chen <foxhlchen@gmail.com>

Commit 39323c6 ("smp_mb__{before,after}_atomic(): update Documentation")
has a typo in CPU MEORY BARRIERS section:
"RMW functions that do not imply are memory barrier are ..." should be
"RMW functions that do not imply a memory barrier are ...".

This patch fixes this typo.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 17c8e0c..7367ada 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1870,7 +1870,7 @@ There are some more advanced barrier functions:
 
      These are for use with atomic RMW functions that do not imply memory
      barriers, but where the code needs a memory barrier. Examples for atomic
-     RMW functions that do not imply are memory barrier are e.g. add,
+     RMW functions that do not imply a memory barrier are e.g. add,
      subtract, (failed) conditional operations, _relaxed functions,
      but not atomic_read or atomic_set. A common example where a memory
      barrier may be required is when atomic ops are used for reference
-- 
2.9.5

