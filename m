From: Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v3 1/5] tools/memory-model: Add an exception for limitations on _unless() family
Date: Thu, 27 Feb 2020 08:40:45 +0800
Message-ID: <20200227004049.6853-2-boqun.feng@gmail.com>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39473 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AlF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 19:41:05 -0500
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org

According to Luc, atomic_add_unless() is directly provided by herd7,
therefore it can be used in litmus tests. So change the limitation
section in README to unlimit the use of atomic_add_unless().

Cc: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/memory-model/README | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index fc07b52f2028..409211b1c544 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -207,11 +207,15 @@ The Linux-kernel memory model (LKMM) has the following limitations:
 		case as a store release.
 
 	b.	The "unless" RMW operations are not currently modeled:
-		atomic_long_add_unless(), atomic_add_unless(),
-		atomic_inc_unless_negative(), and
-		atomic_dec_unless_positive().  These can be emulated
+		atomic_long_add_unless(), atomic_inc_unless_negative(),
+		and atomic_dec_unless_positive().  These can be emulated
 		in litmus tests, for example, by using atomic_cmpxchg().
 
+		One exception of this limitation is atomic_add_unless(),
+		which is provided directly by herd7 (so no corresponding
+		definition in linux-kernel.def). atomic_add_unless() is
+		modeled by herd7 therefore it can be used in litmus tests.
+
 	c.	The call_rcu() function is not modeled.  It can be
 		emulated in litmus tests by adding another process that
 		invokes synchronize_rcu() and the body of the callback
-- 
2.25.0
