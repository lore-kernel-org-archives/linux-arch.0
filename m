From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 5/7] docs/memory-barriers.txt: Enforce heavy ordering for port I/O accesses
Date: Wed,  9 Jan 2019 13:07:46 -0800
Message-ID: <20190109210748.29074-5-paulmck@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, David Laight <David.Laight@ACULAB.COM>, linux-doc@vger.kernel.org, "Paul E . McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

David Laight explains:

  | A long time ago there was a document from Intel that said that
  | inb/outb weren't necessarily synchronised wrt memory accesses.
  | (Might be P-pro era). However no processors actually behaved that
  | way and more recent docs say that inb/outb are fully ordered.

This also reflects the situation on other architectures, the the port
accessor macros tend to be implemented in terms of readX/writeX.

Update Documentation/memory-barriers.txt to reflect reality.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <linux-arch@vger.kernel.org>
Cc: <linux-doc@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/memory-barriers.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1c22b21ae922..a70104e2a087 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2619,10 +2619,8 @@ functions:
      intermediary bridges (such as the PCI host bridge) may not fully honour
      that.
 
-     They are guaranteed to be fully ordered with respect to each other.
-
-     They are not guaranteed to be fully ordered with respect to other types of
-     memory and I/O operation.
+     They are guaranteed to be fully ordered with respect to each other and
+     also with respect to other types of memory and I/O operation.
 
  (*) readX(), writeX():
 
-- 
2.17.1
