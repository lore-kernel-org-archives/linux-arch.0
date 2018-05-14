Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752380AbeENXcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ENOKhl040691
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:32 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hyfnssmfm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:32 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 19:32:31 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 05/19] tools/memory-order: Improve key for SELF and SV
Date: Mon, 14 May 2018 16:33:43 -0700
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Message-ID: <1526340837-12222-5-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180514233343.eC1oLHoNCA5zhAlOnErTh0H8USDaPKxtI6sq5BJhWhU@z>

The key for "SELF" was missing completely and the key for "SV" was
a bit obtuse.  This commit therefore adds a key for "SELF" and improves
the one for "SV".

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/Documentation/cheatsheet.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index c0eafdaddfa4..46fe79afc737 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -26,4 +26,5 @@ Key:	C:	Ordering is cumulative
 	DR:	Dependent read (address dependency)
 	DW:	Dependent write (address, data, or control dependency)
 	RMW:	Atomic read-modify-write operation
-	SV	Same-variable access
+	SELF:	Orders self, as opposed to accesses before and/or after
+	SV:	Orders later accesses to the same variable
-- 
2.5.2
