Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753134AbeC1NmG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Mar 2018 09:42:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2SDfODu105625
        for <linux-arch@vger.kernel.org>; Wed, 28 Mar 2018 09:42:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h0bpe9q9a-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 28 Mar 2018 09:42:02 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 28 Mar 2018 09:41:45 -0400
Date: Wed, 28 Mar 2018 06:42:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180328134232.GA29274@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: schwidefsky@de.ibm.com, borntraeger@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180328134232.PwyIDaPmwOnLw8gylKgKWCBG-FOPDaqOR_N3zYk0M3Y@z>

Hello!

The prototype patch shown below provides files required to allow herd7 to
evaluate C-language litmus tests for the multicopy-atomic TSO ordering
provided by s390.  This patch should be viewed with great suspicion.
It does what I expect it to do on SB (with and without barriers),
IRIW without barriers, and Alan's SB with read-of-write added, but my
expectations are quite likely faulty, and my test cases are very few
in number.

Either way, this is the easy part.  The hard part (which I am happy
to leave to others) is making litmus7 and klitmus7 able to do tests
on actual hardware, as well as enabling herd to handle litmus tests
containing BAL.  ;-)

Note that CPU architectures already supported by herd might well need
only a .cfg file that refers to herd's pre-existing support.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 2fff0ff161b71215e7f7292b9eff4bc77ba64f29
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed Mar 28 06:30:39 2018 -0700

    tools/memory-model: Add .cfg and .cat files for s390
    
    This commit adds s390.cat and s390.cfg files to allow users to check
    litmus tests for s390-specific code.  Note that this change only enables
    herd7 checking of C-language litmus tests.  Larger changes are required
    to enable the litmus7 and klitmus7 tools to check litmus tests on real
    hardare.
    
    Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
    Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/s390.cat b/tools/memory-model/s390.cat
new file mode 100644
index 000000000000..618e88f50d9a
--- /dev/null
+++ b/tools/memory-model/s390.cat
@@ -0,0 +1,12 @@
+s390
+
+include "fences.cat"
+include "cos.cat"
+
+(* Atomic *)
+empty rmw & (fre;coe) as atom
+
+(* TSO with multicopy atomicity *)
+acyclic (po \ (W * R)) | po-loc | fr | rf | co as sc
+
+(* Fences are somehow handled implicitly, at least for SB+mb... *)
diff --git a/tools/memory-model/s390.cfg b/tools/memory-model/s390.cfg
new file mode 100644
index 000000000000..d77e05d2395c
--- /dev/null
+++ b/tools/memory-model/s390.cfg
@@ -0,0 +1,21 @@
+macros linux-kernel.def
+bell linux-kernel.bell
+model s390.cat
+graph columns
+squished true
+showevents noregs
+movelabel true
+fontsize 8
+xscale 2.0
+yscale 1.5
+arrowsize 0.8
+showinitrf false
+showfinalrf false
+showinitwrites false
+splines spline
+pad 0.1
+edgeattr hb,color,indigo
+edgeattr co,color,blue
+edgeattr mb,color,darkgreen
+edgeattr wmb,color,darkgreen
+edgeattr rmb,color,darkgreen
