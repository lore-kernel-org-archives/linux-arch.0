Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbfJCA04 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:56 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 13/32] tools/memory-model: Fix checkalllitmus.sh comment
Date: Wed,  2 Oct 2019 17:26:31 -0700
Message-ID: <20191003002650.11249-13-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002631.N4yZSVoLw9M-WRNIUzr7pW6iDw4o1Ez6lquHn8FxhQ4@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The checkalllitmus.sh runs litmus tests in the litmus-tests directory,
not those in the github archive, so this commit updates the comment to
reflect this reality.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkalllitmus.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 10e14d9..54d8da8 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -30,8 +30,8 @@ else
 	exit 255
 fi
 
-# Create any new directories that have appeared in the github litmus
-# repo since the last run.
+# Create any new directories that have appeared in the litmus-tests
+# directory since the last run.
 if test "$LKMM_DESTDIR" != "."
 then
 	find $litmusdir -type d -print |
-- 
2.9.5
