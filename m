Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41968 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfBSWzn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 17:55:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so11616301wrw.8
        for <linux-arch@vger.kernel.org>; Tue, 19 Feb 2019 14:55:41 -0800 (PST)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 1/2] tools/memory-model: Fix comment in MP+poonceonces.litmus
Date: Tue, 19 Feb 2019 23:55:22 +0100
Message-ID: <1550616923-4795-2-git-send-email-andrea.parri@amarulasolutions.com>
In-Reply-To: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190219225522.fVDyB5xfjwpFtDKWar6Wj0QNYcMyOugI3DnNR5l3VlM@z>

The comment should say "Sometimes" for the result.

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
 tools/memory-model/litmus-tests/MP+poonceonces.litmus | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index b2b60b84fb9dc..172f0145301c5 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -1,7 +1,7 @@
 C MP+poonceonces
 
 (*
- * Result: Maybe
+ * Result: Sometimes
  *
  * Can the counter-intuitive message-passing outcome be prevented with
  * no ordering at all?
-- 
2.7.4
