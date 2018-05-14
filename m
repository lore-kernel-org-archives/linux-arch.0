Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752484AbeENXce (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ENOHpZ107049
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:34 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hyjrktu19-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:34 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 19:32:33 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 16/19] tools/memory-model: Fix coding style in 'lock.cat'
Date: Mon, 14 May 2018 16:33:54 -0700
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Message-ID: <1526340837-12222-16-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180514233354.5gEJZ2K_ve1DcT4FCLsbbyT311J1mcB6GjjY_w0aa1U@z>

From: Andrea Parri <andrea.parri@amarulasolutions.com>

This commit uses tabs for indentation and adds spaces around binary
operator.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/lock.cat | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index cd002a33ca8a..305ded17e741 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -84,16 +84,16 @@ let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
 
 (* rfe for LF events *)
 let all-possible-rfe-lf =
-  (*
-   * Given an LF event r, compute the possible rfe edges for that event
-   * (all those starting from LKW events in other threads),
-   * and then convert that relation to a set of single-edge relations.
-   *)
-  let possible-rfe-lf r =
-    let pair-to-relation p = p ++ 0
-    in map pair-to-relation ((LKW * {r}) & loc & ext)
-  (* Do this for each LF event r that isn't in rfi-lf *)
-  in map possible-rfe-lf (LF \ range(rfi-lf))
+	(*
+	 * Given an LF event r, compute the possible rfe edges for that event
+	 * (all those starting from LKW events in other threads),
+	 * and then convert that relation to a set of single-edge relations.
+	 *)
+	let possible-rfe-lf r =
+		let pair-to-relation p = p ++ 0
+		in map pair-to-relation ((LKW * {r}) & loc & ext)
+	(* Do this for each LF event r that isn't in rfi-lf *)
+	in map possible-rfe-lf (LF \ range(rfi-lf))
 
 (* Generate all rf relations for LF events *)
 with rfe-lf from cross(all-possible-rfe-lf)
@@ -110,10 +110,10 @@ let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
 
 (* rfe for RU events: an RU may read from an external UL or the initial write *)
 let all-possible-rfe-ru =
-   let possible-rfe-ru r =
-     let pair-to-relation p = p ++ 0
-     in map pair-to-relation (((UL|IW) * {r}) & loc & ext)
-  in map possible-rfe-ru RU
+	let possible-rfe-ru r =
+		let pair-to-relation p = p ++ 0
+		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
+	in map possible-rfe-ru RU
 
 (* Generate all rf relations for RU events *)
 with rfe-ru from cross(all-possible-rfe-ru)
-- 
2.5.2
