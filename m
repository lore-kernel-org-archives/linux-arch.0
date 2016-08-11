From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt 3/4] Doc/memory-barriers: Fix a typo of example result
Date: Thu, 11 Aug 2016 11:17:42 -0700
Message-ID: <1470939463-31950-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160811181602.GA31464@linux.vnet.ibm.com>
 <1470939463-31950-1-git-send-email-paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470939463-31950-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org, sj38.park@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: SeongJae Park <sj38.park@gmail.com>

An example result for data dependent write has a typo.  This commit
fixes the wrong typo.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 19c8eb6f246e..ba818ecce6f9 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -609,7 +609,7 @@ A data-dependency barrier must also order against dependent writes:
 The data-dependency barrier must order the read into Q with the store
 into *Q.  This prohibits this outcome:
 
-	(Q == B) && (B == 4)
+	(Q == &B) && (B == 4)
 
 Please note that this pattern should be rare.  After all, the whole point
 of dependency ordering is to -prevent- writes to the data structure, along
-- 
2.5.2
