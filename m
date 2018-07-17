From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model] Model effects of volatile on ctrl
Date: Tue, 17 Jul 2018 10:10:42 -0700
Message-ID: <20180717171042.GA2299@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This commit models the fact that compilers are not allowed to reorder
volatile accesses.  This modeling is at best approximate, although it
does correctly handle C-RomanPenyaev-list-rcu-rr.litmus from the litmus
github archive.  The approach is to extend control dependencies to
subsequent volatiles accesses.

Probable issues with this change:

1.	It does not correctly handle the case of identical WRITE_ONCE()
	invocations at the beginning of both legs of an "if" statement.
	(Of course, the current state does not correctly handle this
	either.)
    
2.	It might not correctly handle the ARMv8 conditional-move instruction.
    
3.	It is probably missing some handling of atomic RWM operations.
    
4.	It does not insist that the initial ctrl dependency end in
	a volatile access.  This is not yet a problem because we
	don't yet model unmarked accesses.

That said, this patch is not intended for inclusion, but rather in the
hope that it inspires someone to come up with something better.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 882fc33274ac..f745337ba10e 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -57,7 +57,9 @@ empty rmw & (fre ; coe) as atomic
 
 (* Preserved Program Order *)
 let dep = addr | data
-let rwdep = (dep | ctrl) ; [W]
+let volatile = [Once] | [Release] | [Acquire] (* No unmarked accesses. *)
+let ctrl-volatile = ctrl ; (po ; volatile)*
+let rwdep = (dep | ctrl-volatile) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
 let to-r = addr | (dep ; rfi)
