Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753006AbeDPQLq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3GFvPHc140689
        for <linux-arch@vger.kernel.org>; Mon, 16 Apr 2018 12:11:46 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hcwd4dquu-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Apr 2018 12:11:45 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Apr 2018 12:11:44 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 14/17] tools/memory-order: Improve key for SELF and SV
Date: Mon, 16 Apr 2018 09:12:42 -0700
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
Message-ID: <1523895165-17576-14-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180416161242.OerFs2IpHaDneELrLcdyN1_xrXxBX7b32KGPH2MLGGQ@z>

The key for "SELF" was missing completely and the key for "SV" was
a bit obtuse.  This commit therefore adds a key for "SELF" and improves
the one for "SV".

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/cheatsheet.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index c0eafdaddfa4..d502993ac7d2 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -26,4 +26,5 @@ Key:	C:	Ordering is cumulative
 	DR:	Dependent read (address dependency)
 	DW:	Dependent write (address, data, or control dependency)
 	RMW:	Atomic read-modify-write operation
-	SV	Same-variable access
+	SELF:	Orders self, as opposed to accesses both before and after
+	SV:	Orders later accesses to the same variable
-- 
2.5.2
