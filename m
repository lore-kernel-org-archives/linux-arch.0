From: tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Subject: [tip:locking/core] locking/barriers, arch:
  Remove ambiguous statement in the smp_store_mb() documentation
Date: Fri, 4 Dec 2015 04:01:56 -0800
Message-ID: <tip-2d142e599bf73ab70a3457e6947f86935245415e@git.kernel.org>
References: <1445975631-17047-5-git-send-email-dave@stgolabs.net>
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, corbet@lwn.net,
	  tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
	  linux-arch@vger.kernel.org, dave@stgolabs.net,
	  torvalds@linux-foundation.org, mingo@kernel.org,
	  akpm@linux-foundation.org, peterz@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445975631-17047-5-git-send-email-dave@stgolabs.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: corbet@lwn.net, tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org, dave@stgolabs.net, peterz@infradead.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Commit-ID:  2d142e599bf73ab70a3457e6947f86935245415e
Gitweb:     http://git.kernel.org/tip/2d142e599bf73ab70a3457e6947f86935245415e
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Tue, 27 Oct 2015 12:53:51 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 4 Dec 2015 11:39:51 +0100

locking/barriers, arch: Remove ambiguous statement in the smp_store_mb() documentation

It serves no purpose but to confuse readers, and is most
likely a left over from constant memory-barriers.txt
updates. I.e.:

  http://lists.openwall.net/linux-kernel/2006/07/15/27

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1445975631-17047-5-git-send-email-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/memory-barriers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index aef9487..c85054d 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1673,8 +1673,8 @@ There are some more advanced barrier functions:
  (*) smp_store_mb(var, value)
 
      This assigns the value to the variable and then inserts a full memory
-     barrier after it, depending on the function.  It isn't guaranteed to
-     insert anything more than a compiler barrier in a UP compilation.
+     barrier after it.  It isn't guaranteed to insert anything more than a
+     compiler barrier in a UP compilation.
 
 
  (*) smp_mb__before_atomic();
