Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34517 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933169AbeGJKCm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2018 06:02:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id s13-v6so12193678wmc.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Jul 2018 03:02:41 -0700 (PDT)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
Date: Tue, 10 Jul 2018 12:02:23 +0200
Message-ID: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>
Message-ID: <20180710100223.H-ZHC8SSGejf1Tdav6xmuwQqh9pJItozbCIGdiWdZ5I@z>

Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
with smp_cond_load_acquire()") by updating the documentation accordingly.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/memory-barriers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 0d8d7ef131e9a..987a4e6cc0cd8 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -471,8 +471,8 @@ And a couple of implicit varieties:
      operations after the ACQUIRE operation will appear to happen after the
      ACQUIRE operation with respect to the other components of the system.
      ACQUIRE operations include LOCK operations and both smp_load_acquire()
-     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
-     semantics from relying on a control dependency and smp_rmb().
+     and smp_cond_load_acquire() operations. The later builds the necessary
+     ACQUIRE semantics from relying on a control dependency and smp_rmb().
 
      Memory operations that occur before an ACQUIRE operation may appear to
      happen after it completes.
-- 
2.7.4
