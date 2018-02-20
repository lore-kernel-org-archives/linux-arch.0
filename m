Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751746AbeBTXZH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KNNedf077479
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:06 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g8v9ga1qb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:04 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 20 Feb 2018 18:25:03 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 09/12] tools/memory-model: Add required herd7 version to README file
Date: Tue, 20 Feb 2018 15:25:09 -0800
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
Message-Id: <1519169112-20593-9-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

LKMM and the herd7 tool are co-evolving, and out-of-date herd7 tools
produce inaccurate results, often with no obvious error messages.  This
commit therefore adds the required herd7 version to the LKMM README file.

Longer term, it would be good if .cat files could specify the required
version in a manner allowing herd7 to produce clear diagnostics.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 91414a49fac5..ea950c566ffd 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -20,7 +20,8 @@ that litmus test to be exercised within the Linux kernel.
 REQUIREMENTS
 ============
 
-The "herd7" and "klitmus7" tools must be downloaded separately:
+Version 7.48 of the "herd7" and "klitmus7" tools must be downloaded
+separately:
 
   https://github.com/herd/herdtools7
 
-- 
2.5.2
