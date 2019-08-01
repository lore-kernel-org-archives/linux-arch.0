Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389447AbfHAWVF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MHgpW142492
        for <linux-arch@vger.kernel.org>; Thu, 1 Aug 2019 18:21:04 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u46duw04n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2019 18:21:03 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:21:03 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 28/31] tools/memory-model: Make judgelitmus.sh handle scripted Result: tag
Date: Thu,  1 Aug 2019 15:20:53 -0700
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Message-ID: <20190801222056.12144-28-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190801222053.YFYANto92KeTpNPrTEBzJVLDDGlw1AXQhbeROOmqNrs@z>

The scripts that generate the litmus tests in the "auto" directory of
the https://github.com/paulmckrcu/litmus archive place the "Result:"
tag into a single-line ocaml comment, which judgelitmus.sh currently
does not recognize.  This commit therefore makes judgelitmus.sh
recognize both the multiline comment format that it currently does
and the automatically generated single-line format.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index eaa2cc7d3b36..6408c012bdf5 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -51,10 +51,10 @@ if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
 then
 	datarace_modeled=1
 fi
-if grep -q '^ \* Result: ' $litmus
+if grep -q '^[( ]\* Result: ' $litmus
 then
-	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
-	if grep -m1 '^ \* Result: .* DATARACE' $litmus
+	outcome=`grep -m 1 '^[( ]\* Result: ' $litmus | awk '{ print $3 }'`
+	if grep -m1 '^[( ]\* Result: .* DATARACE' $litmus
 	then
 		datarace_predicted=1
 	fi
-- 
2.17.1
