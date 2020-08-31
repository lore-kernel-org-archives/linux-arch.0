Return-Path: <SRS0=2cKs=CJ=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F91C433E7
	for <linux-arch@archiver.kernel.org>; Mon, 31 Aug 2020 18:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F4A20678
	for <linux-arch@archiver.kernel.org>; Mon, 31 Aug 2020 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598898091;
	bh=SAhAZUtzH0cBxplGAiQtrOEz8wzNJYljnan7d2lUgLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HRCz5js6Vvx3vEpuu2vN+y0Pt204qAXcxT2aVnjWwDpU0odBSOnjhe6D1IGi0wAHU
	 2rzAGmfzC3PuE4GW7KImJAv2uHgYmpL119obbB+A7Eu6qUA/tTiFH5i699g63P2XbH
	 ZZUdHLAFybMEc5etZSWmhll8aY6d/69DUkQM9Yww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgHaSVV (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbgHaSUl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:41 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF28D20EDD;
        Mon, 31 Aug 2020 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898040;
        bh=SAhAZUtzH0cBxplGAiQtrOEz8wzNJYljnan7d2lUgLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0saRHrYD22aE9Hc4KkJyuCQ4fUQZVN2dEC++p0Je9DWUE7AxJDBXULMBMjtSlIXv9
         uvRtQIaGiKCr+JW4vX80RtThdH6wugeCO1ypB2N6jB2aAsc/Xv8kOjMOkRd36M1f5x
         bMGyEFl0Xzv0p6ASoJfhDG/vfn6MI7pruz7/i2CY=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt notion of relaxed
Date:   Mon, 31 Aug 2020 11:20:34 -0700
Message-Id: <20200831182037.2034-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831182012.GA1965@paulmck-ThinkPad-P72>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a key entry enumerating the various types of relaxed
operations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/cheatsheet.txt | 27 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 33ba98d..31b814d 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -5,7 +5,7 @@
 
 Store, e.g., WRITE_ONCE()            Y                                       Y
 Load, e.g., READ_ONCE()              Y                          Y   Y        Y
-Unsuccessful RMW operation           Y                          Y   Y        Y
+Relaxed operation                    Y                          Y   Y        Y
 rcu_dereference()                    Y                          Y   Y        Y
 Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
 Successful *_release()         C        Y  Y    Y     W                      Y
@@ -17,14 +17,17 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
 smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
 
 
-Key:	C:	Ordering is cumulative
-	P:	Ordering propagates
-	R:	Read, for example, READ_ONCE(), or read portion of RMW
-	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
-	Y:	Provides ordering
-	a:	Provides ordering given intervening RMW atomic operation
-	DR:	Dependent read (address dependency)
-	DW:	Dependent write (address, data, or control dependency)
-	RMW:	Atomic read-modify-write operation
-	SELF:	Orders self, as opposed to accesses before and/or after
-	SV:	Orders later accesses to the same variable
+Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
+		  operation, an unsuccessful RMW operation, or one of
+		  the atomic_read() and atomic_set() family of operations.
+	C:	  Ordering is cumulative
+	P:	  Ordering propagates
+	R:	  Read, for example, READ_ONCE(), or read portion of RMW
+	W:	  Write, for example, WRITE_ONCE(), or write portion of RMW
+	Y:	  Provides ordering
+	a:	  Provides ordering given intervening RMW atomic operation
+	DR:	  Dependent read (address dependency)
+	DW:	  Dependent write (address, data, or control dependency)
+	RMW:	  Atomic read-modify-write operation
+	SELF:	  Orders self, as opposed to accesses before and/or after
+	SV:	  Orders later accesses to the same variable
-- 
2.9.5

