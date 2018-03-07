From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 3/4] tools/memory-order: Add documentation of new litmus test
Date: Wed,  7 Mar 2018 09:27:39 -0800
Message-ID: <1520443660-16858-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180307172627.GA15805@linux.vnet.ibm.com>
 <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

The litmus-tests/README file lacks any mention of the new litmus test
ISA2+pooncelock+pooncelock+pombonce.litmus.  This commit therefore
adds a description of this test.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/litmus-tests/README | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index dca7d823ad57..04096fb8b8d9 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -32,6 +32,12 @@ IRIW+poonceonces+OnceOnce.litmus
 	order of a pair of writes, where each write is to a different
 	variable by a different process?
 
+ISA2+pooncelock+pooncelock+pombonce.litmus
+	Tests whether the ordering provided by a lock-protected S
+	litmus test is visible to an external process whose accesses are
+	separated by smp_mb().	This addition of an external process to
+	S is otherwise known as ISA2.
+
 ISA2+poonceonces.litmus
 	As below, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
-- 
2.5.2
