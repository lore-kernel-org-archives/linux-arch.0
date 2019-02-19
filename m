Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38116 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSW6A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 17:58:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so23770901wrw.5
        for <linux-arch@vger.kernel.org>; Tue, 19 Feb 2019 14:57:59 -0800 (PST)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Date: Tue, 19 Feb 2019 23:57:37 +0100
Message-ID: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190219225737.Ja_BP_wf3nrIs-SvuGWgyOWKjFmDc0n-ZWxlE6VAlIo@z>

Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
if necessary, but let us not encourage people to rely on this thing.

For example, the following "exists" clause can be satisfied with this
change:

C dep-rfi

{ }

P0(int *x, int *y)
{
	WRITE_ONCE(*x, 1);
	smp_store_release(y, 1);
}

P1(int *x, int *y, int *z)
{
	int r0;
	int r1;
	int r2;

	r0 = READ_ONCE(*y);
	WRITE_ONCE(*z, r0);
	r1 = smp_load_acquire(z);
	r2 = READ_ONCE(*x);
}

exists (1:r0=1 /\ 1:r2=0)

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
---
 tools/memory-model/Documentation/explanation.txt | 28 ------------------------
 tools/memory-model/linux-kernel.cat              |  2 +-
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0c..965e11744d090 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1019,34 +1019,6 @@ section for more details).  The kernel includes a workaround for this
 problem when the loads come from READ_ONCE(), and therefore the LKMM
 includes address dependencies to loads in the ppo relation.
 
-On the other hand, dependencies can indirectly affect the ordering of
-two loads.  This happens when there is a dependency from a load to a
-store and a second, po-later load reads from that store:
-
-	R ->dep W ->rfi R',
-
-where the dep link can be either an address or a data dependency.  In
-this situation we know it is possible for the CPU to execute R' before
-W, because it can forward the value that W will store to R'.  But it
-cannot execute R' before R, because it cannot forward the value before
-it knows what that value is, or that W and R' do access the same
-location.  However, if there is merely a control dependency between R
-and W then the CPU can speculatively forward W to R' before executing
-R; if the speculation turns out to be wrong then the CPU merely has to
-restart or abandon R'.
-
-(In theory, a CPU might forward a store to a load when it runs across
-an address dependency like this:
-
-	r1 = READ_ONCE(ptr);
-	WRITE_ONCE(*r1, 17);
-	r2 = READ_ONCE(*r1);
-
-because it could tell that the store and the second load access the
-same location even before it knows what the location's address is.
-However, none of the architectures supported by the Linux kernel do
-this.)
-
 Two memory accesses of the same location must always be executed in
 program order if the second access is a store.  Thus, if we have
 
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 8dcb37835b613..6b9e3bb4e397f 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -62,7 +62,7 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi)
+let to-r = addr ; [R]
 let fence = strong-fence | wmb | po-rel | rmb | acq-po
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
-- 
2.7.4
