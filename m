Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48662 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967000AbXHMLZB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Aug 2007 07:25:01 -0400
Date: Mon, 13 Aug 2007 07:24:52 -0400
From: Chris Snook <csnook@redhat.com>
Subject: [PATCH 11/23] make atomic_read() and atomic_set() behavior consistent on m32r
Message-ID: <20070813112452.GK24018@shell.boston.redhat.com>
References: <46C03885.7000109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46C03885.7000109@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, Segher Boessenkool <segher@kernel.crashing.org>, "Luck, Tony" <tony.luck@intel.com>, Chris Friesen <cfriesen@nortel.com>, "Robert P. J. Day" <rpjday@mindspring.com>
List-ID: <linux-arch.vger.kernel.org>

From: Chris Snook <csnook@redhat.com>

Use volatile consistently in atomic.h on m32r.

Signed-off-by: Chris Snook <csnook@redhat.com>

--- linux-2.6.23-rc3-orig/include/asm-m32r/atomic.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.23-rc3/include/asm-m32r/atomic.h	2007-08-13 05:42:09.000000000 -0400
@@ -22,7 +22,7 @@
  * on us. We need to use _exactly_ the address the user gave us,
  * not some alias that contains the same information.
  */
-typedef struct { volatile int counter; } atomic_t;
+typedef struct { int counter; } atomic_t;
 
 #define ATOMIC_INIT(i)	{ (i) }
 
@@ -32,7 +32,10 @@ typedef struct { volatile int counter; }
  *
  * Atomically reads the value of @v.
  */
-#define atomic_read(v)	((v)->counter)
+static __inline__ int atomic_read(atomic_t *v)
+{
+        return *(volatile int *)&v->counter;
+}
 
 /**
  * atomic_set - set atomic variable
@@ -41,7 +44,10 @@ typedef struct { volatile int counter; }
  *
  * Atomically sets the value of @v to @i.
  */
-#define atomic_set(v,i)	(((v)->counter) = (i))
+static __inline__ void atomic_set(atomic_t *v, int i)
+{
+        *(volatile int *)&v->counter = i;
+}
 
 /**
  * atomic_add_return - add integer to atomic variable and return it
