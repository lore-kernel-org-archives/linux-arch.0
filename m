From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 1/4] memory-barriers: More text to de-emphasize smp_read_barrier_depends()
Date: Wed,  7 Mar 2018 09:27:37 -0800
Message-ID: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180307172627.GA15805@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307172627.GA15805@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

This commit makes further changes to memory-barrier.txt to further
de-emphasize smp_read_barrier_depends(), but leaving some discussion
for historical purposes.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index da6525bdc3f5..6dafc8085acc 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -52,7 +52,7 @@ CONTENTS
 
      - Varieties of memory barrier.
      - What may not be assumed about memory barriers?
-     - Data dependency barriers.
+     - Data dependency barriers (historical).
      - Control dependencies.
      - SMP barrier pairing.
      - Examples of memory barrier sequences.
@@ -554,8 +554,15 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	    Documentation/DMA-API.txt
 
 
-DATA DEPENDENCY BARRIERS
-------------------------
+DATA DEPENDENCY BARRIERS (HISTORICAL)
+-------------------------------------
+
+As of v4.15 of the Linux kernel, an smp_read_barrier_depends() was
+added to READ_ONCE(), which means that about the only people who
+need to pay attention to this section are those working on DEC Alpha
+architecture-specific code and those working on READ_ONCE() itself.
+For those who need it, and for those who are interested in the history,
+here is the story of data-dependency barriers.
 
 The usage requirements of data dependency barriers are a little subtle, and
 it's not always obvious that they're needed.  To illustrate, consider the
@@ -2843,8 +2850,9 @@ as that committed on CPU 1.
 
 
 To intervene, we need to interpolate a data dependency barrier or a read
-barrier between the loads.  This will force the cache to commit its coherency
-queue before processing any further requests:
+barrier between the loads (which as of v4.15 is supplied unconditionally
+by the READ_ONCE() macro).  This will force the cache to commit its
+coherency queue before processing any further requests:
 
 	CPU 1		CPU 2		COMMENT
 	===============	===============	=======================================
@@ -2873,8 +2881,8 @@ Other CPUs may also have split caches, but must coordinate between the various
 cachelets for normal memory accesses.  The semantics of the Alpha removes the
 need for hardware coordination in the absence of memory barriers, which
 permitted Alpha to sport higher CPU clock rates back in the day.  However,
-please note that smp_read_barrier_depends() should not be used except in
-Alpha arch-specific code and within the READ_ONCE() macro.
+please note that (again, as of v4.15) smp_read_barrier_depends() should not
+be used except in Alpha arch-specific code and within the READ_ONCE() macro.
 
 
 CACHE COHERENCY VS DMA
@@ -3039,7 +3047,9 @@ the data dependency barrier really becomes necessary as this synchronises both
 caches with the memory coherence system, thus making it seem like pointer
 changes vs new data occur in the right order.
 
-The Alpha defines the Linux kernel's memory barrier model.
+The Alpha defines the Linux kernel's memory model, although as of v4.15
+the Linux kernel's addition of smp_read_barrier_depends() to READ_ONCE()
+greatly reduced Alpha's impact on the memory model.
 
 See the subsection on "Cache Coherency" above.
 
-- 
2.5.2
