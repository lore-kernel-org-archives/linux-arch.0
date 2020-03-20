From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 3/3] LKMM: Rename MP+onceassign+derefonce for better clarity
Date: Fri, 20 Mar 2020 02:55:52 -0400
Message-ID: <20200320065552.253696-3-joel@joelfernandes.org>
References: <20200320065552.253696-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42428 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgCTG4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 02:56:04 -0400
Received: by mail-qv1-f66.google.com with SMTP id ca9so2427681qvb.9
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2020 23:56:03 -0700 (PDT)
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

For better consistency with RCU examples, rename MP+onceassign+derefonce
to RCU+MP+onceassign+derefonce.

I plan to add more RCU related litmus tests, so we could use this
convention if that's Ok.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 ...sign+derefonce.litmus => RCU+MP+onceassign+derefonce.litmus} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename tools/memory-model/litmus-tests/{MP+onceassign+derefonce.litmus => RCU+MP+onceassign+derefonce.litmus} (94%)

diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
similarity index 94%
rename from tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
rename to tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
index 97731b4bbdd8e..f9bfe0fd42e4d 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
@@ -1,4 +1,4 @@
-C MP+onceassign+derefonce
+C RCU+MP+onceassign+derefonce
 
 (*
  * Result: Never
-- 
2.25.1.696.g5e7596f4ac-goog
