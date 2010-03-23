From: akpm@linux-foundation.org
Subject: [patch 07/36] Documentation/volatile-considered-harmful.txt: correct cpu_relax() documentation
Date: Tue, 23 Mar 2010 13:35:16 -0700
Message-ID: <201003232035.o2NKZGtj024443@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41224 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753102Ab0CWUfa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2010 16:35:30 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, rmk+kernel@arm.linux.org.uk

From: Russell King <rmk@arm.linux.org.uk>

cpu_relax() is documented in volatile-considered-harmful.txt to be a
memory barrier.  However, everyone with the exception of Blackfin and
possibly ia64 defines cpu_relax() to be a compiler barrier.

Make the documentation reflect the general concensus.

Linus sayeth:

: I don't think it was ever the intention that it would be seen as anything
: but a compiler barrier, although it is obviously implied that it might
: well perform some per-architecture actions that have "memory barrier-like"
: semantics.
: 
: After all, the whole and only point of the "cpu_relax()" thing is to tell
: the CPU that we're busy-looping on some event.
: 
: And that "event" might be (and often is) about reading the same memory
: location over and over until it changes to what we want it to be.  So it's
: quite possible that on various architectures the "cpu_relax()" could be
: about making sure that such a tight loop on loads doesn't starve cache
: transactions, for example - and as such look a bit like a memory barrier
: from a CPU standpoint.
: 
: But it's not meant to have any kind of architectural memory ordering
: semantics as far as the kernel is concerned - those must come from other
: sources.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: <linux-arch@vger.kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/volatile-considered-harmful.txt |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN Documentation/volatile-considered-harmful.txt~documentation-volatile-considered-harmfultxt-correct-cpu_relax-documentation Documentation/volatile-considered-harmful.txt
--- a/Documentation/volatile-considered-harmful.txt~documentation-volatile-considered-harmfultxt-correct-cpu_relax-documentation
+++ a/Documentation/volatile-considered-harmful.txt
@@ -63,9 +63,9 @@ way to perform a busy wait is:
         cpu_relax();
 
 The cpu_relax() call can lower CPU power consumption or yield to a
-hyperthreaded twin processor; it also happens to serve as a memory barrier,
-so, once again, volatile is unnecessary.  Of course, busy-waiting is
-generally an anti-social act to begin with.
+hyperthreaded twin processor; it also happens to serve as a compiler
+barrier, so, once again, volatile is unnecessary.  Of course, busy-
+waiting is generally an anti-social act to begin with.
 
 There are still a few rare situations where volatile makes sense in the
 kernel:
_
