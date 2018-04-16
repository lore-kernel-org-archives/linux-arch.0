From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 14/17] tools/memory-order: Improve key for SELF and SV
Date: Mon, 16 Apr 2018 09:12:42 -0700
Message-ID: <1523895165-17576-14-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

The key for "SELF" was missing completely and the key for "SV" was
a bit obtuse.  This commit therefore adds a key for "SELF" and improves
the one for "SV".

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/cheatsheet.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index c0eafdaddfa4..d502993ac7d2 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -26,4 +26,5 @@ Key:	C:	Ordering is cumulative
 	DR:	Dependent read (address dependency)
 	DW:	Dependent write (address, data, or control dependency)
 	RMW:	Atomic read-modify-write operation
-	SV	Same-variable access
+	SELF:	Orders self, as opposed to accesses both before and after
+	SV:	Orders later accesses to the same variable
-- 
2.5.2
