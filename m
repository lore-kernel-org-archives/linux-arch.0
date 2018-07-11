Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33800 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732903AbeGKNN2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jul 2018 09:13:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id s13-v6so15168416wmc.1
        for <linux-arch@vger.kernel.org>; Wed, 11 Jul 2018 06:09:11 -0700 (PDT)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
Date: Wed, 11 Jul 2018 15:08:50 +0200
Message-ID: <1531314530-11624-1-git-send-email-andrea.parri@amarulasolutions.com>
In-Reply-To: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>
Message-ID: <20180711130850.Pci_JxZh9gNXMM3MKQmPTEKgP3D25p1uw1hWb2EL550@z>

Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
with smp_cond_load_acquire()") by updating the documentation accordingly.
Also remove some obsolete information related to the implementation.

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
 Documentation/memory-barriers.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 0d8d7ef131e9a..c1d913944ad8b 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -471,8 +471,7 @@ And a couple of implicit varieties:
      operations after the ACQUIRE operation will appear to happen after the
      ACQUIRE operation with respect to the other components of the system.
      ACQUIRE operations include LOCK operations and both smp_load_acquire()
-     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
-     semantics from relying on a control dependency and smp_rmb().
+     and smp_cond_load_acquire() operations.
 
      Memory operations that occur before an ACQUIRE operation may appear to
      happen after it completes.
-- 
2.7.4
