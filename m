Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbfDJJ4i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2019 05:56:38 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 2/8] docs: atomic_bitops.txt: add a title for this document
Date: Wed, 10 Apr 2019 06:56:21 -0300
Message-ID: <b71822db8abbb22175042fce7712e2c9108c7353.1554889999.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org
Message-ID: <20190410095621.27lUR6jrAST_qqj4OkDfpwaly_n_FNsBKI33rAGA5ng@z>

This document misses a title. Add it, in order to follow
the documentation standard.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/atomic_bitops.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/atomic_bitops.txt b/Documentation/atomic_bitops.txt
index be70b32c95d9..093cdaefdb37 100644
--- a/Documentation/atomic_bitops.txt
+++ b/Documentation/atomic_bitops.txt
@@ -1,6 +1,6 @@
-
-On atomic bitops.
-
+=============
+Atomic bitops
+=============
 
 While our bitmap_{}() functions are non-atomic, we have a number of operations
 operating on single bits in a bitmap that are atomic.
-- 
2.20.1
