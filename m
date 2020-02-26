Return-Path: <SRS0=hCVk=4O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36793 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgBZDV7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 22:21:59 -0500
From: Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] tools/memory-model: Remove lock-final checking in lock.cat
Date: Wed, 26 Feb 2020 11:21:40 +0800
Message-ID: <20200226032142.89424-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org
Message-ID: <20200226032140.VVXYYoi9VjZkU9Ba-S1vUNbD7MFLlkYo80eE8XMAKbg@z>

In commit 30b795df11a1 ("tools/memory-model: Improve mixed-access
checking in lock.cat"), we have added the checking to disallow any
normal memory access to lock variables, and this checking is stronger
than lock-final. So remove the lock-final checking as it's unnecessary
now.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/memory-model/lock.cat | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 6b52f365d73a..827a3646607c 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -54,9 +54,6 @@ flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
  *)
 empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
 
-(* The final value of a spinlock should not be tested *)
-flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
-
 (*
  * Put lock operations in their appropriate classes, but leave UL out of W
  * until after the co relation has been generated.
-- 
2.25.0
