Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728144AbeH3BJo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 21:09:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TL8pgl066082
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 17:11:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m629dsxhn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 17:11:01 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:11:01 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC LKMM 7/7] EXP tools/memory-model: Add .cfg and .cat files for s390
Date: Wed, 29 Aug 2018 14:10:53 -0700
In-Reply-To: <20180829211018.GA19646@linux.vnet.ibm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
Message-ID: <20180829211053.20531-7-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180829211053.9B5dv8JJekRMqebjeGww0Z3howI5Ahe9RXTm58VDfrU@z>

This commit adds s390.cat and s390.cfg files to allow users to check
litmus tests for s390-specific code.  Note that this change only enables
herd7 checking of C-language litmus tests.  Larger changes are required
to enable the litmus7 and klitmus7 tools to check litmus tests on real
hardare.

Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Add fixes suggested by Alan Stern. ]
---
 tools/memory-model/s390.cat | 18 ++++++++++++++++++
 tools/memory-model/s390.cfg | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 tools/memory-model/s390.cat
 create mode 100644 tools/memory-model/s390.cfg

diff --git a/tools/memory-model/s390.cat b/tools/memory-model/s390.cat
new file mode 100644
index 000000000000..216bf33d3ffe
--- /dev/null
+++ b/tools/memory-model/s390.cat
@@ -0,0 +1,18 @@
+s390
+
+include "fences.cat"
+include "cos.cat"
+
+(* Fundamental coherence ordering *)
+let com = rf | co | fr
+acyclic po-loc | com as coherence
+
+(* Atomic *)
+empty rmw & (fre;coe) as atom
+
+(* Fences *)
+let mb = [M] ; fencerel(Mb) ; [M]
+
+(* TSO with multicopy atomicity (tso-mca) *)
+let po-ghb = ([R] ; po ; [M]) | ([M] ; po ; [W])
+acyclic mb | po-ghb | fr | rf | co as tso-mca
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
-- 
2.17.1
