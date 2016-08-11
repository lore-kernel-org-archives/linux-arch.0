From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt 1/4] memory-barriers.txt: Maintain consistent blank line
Date: Thu, 11 Aug 2016 11:17:40 -0700
Message-ID: <1470939463-31950-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160811181602.GA31464@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160811181602.GA31464@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org, sj38.park@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: SeongJae Park <sj38.park@gmail.com>

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a4d0a99de04d..e1926a096818 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1928,6 +1928,7 @@ There are some more advanced barrier functions:
 
      See Documentation/DMA-API.txt for more information on consistent memory.
 
+
 MMIO WRITE BARRIER
 ------------------
 
-- 
2.5.2
