From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 16/19] tools/memory-model: Fix coding style in 'lock.cat'
Date: Mon, 14 May 2018 16:33:54 -0700
Message-ID: <1526340837-12222-16-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

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
