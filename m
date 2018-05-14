Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752246AbeENWyL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:54:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4EMs2Si009920
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 18:54:10 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hyg9pf46t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 18:54:10 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 18:54:09 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 7/8] atomic_ops.rst: Fix wrong example code
Date: Mon, 14 May 2018 15:55:32 -0700
In-Reply-To: <20180514225457.GA5142@linux.vnet.ibm.com>
References: <20180514225457.GA5142@linux.vnet.ibm.com>
Message-ID: <1526338533-6044-7-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, SeongJae Park <sj38.park@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180514225532.8jAeIOS6fQXOngIdwzSTI8zRi41fWov4CexTU-Ukvqo@z>

From: SeongJae Park <sj38.park@gmail.com>

Example code snippets for necessary of READ_ONCE() and WRITE_ONCE() has
an unnecessary line of code and wrong condition.  This commit fixes
them.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 Documentation/core-api/atomic_ops.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index fce929144ccd..4ea4af71e68a 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -111,7 +111,6 @@ If the compiler can prove that do_something() does not store to the
 variable a, then the compiler is within its rights transforming this to
 the following::
 
-	tmp = a;
 	if (a > 0)
 		for (;;)
 			do_something();
@@ -119,7 +118,7 @@ the following::
 If you don't want the compiler to do this (and you probably don't), then
 you should use something like the following::
 
-	while (READ_ONCE(a) < 0)
+	while (READ_ONCE(a) > 0)
 		do_something();
 
 Alternatively, you could place a barrier() call in the loop.
-- 
2.5.2
