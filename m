Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38698 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbeBPV3t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Feb 2018 16:29:49 -0500
Subject: [PATCH 1/3] nospec: Kill array_index_nospec_mask_check()
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Feb 2018 13:20:42 -0800
Message-ID: <151881604278.17395.6605847763178076520.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-ID: <20180216212042.pgXedjtAD42pHtlZxkWBd0HrRgE3zkQ30cwiDpwJM5U@z>

There are multiple problems with the dynamic sanity checking in
array_index_nospec_mask_check():

* It causes unnecessary overhead in the 32-bit case since integer sized
  @index values will no longer cause the check to be compiled away like
  in the 64-bit case.

* In the 32-bit case it may trigger with user controllable input when
  the expectation is that should only trigger during development of new
  kernel enabling.

* The macro reuses the input parameter in multiple locations which is
  broken if someone passes an expression like 'index++' to
  array_index_nospec().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/nospec.h |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index fbc98e2c8228..d6701e34424f 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -30,26 +30,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #endif
 
 /*
- * Warn developers about inappropriate array_index_nospec() usage.
- *
- * Even if the CPU speculates past the WARN_ONCE branch, the
- * sign bit of @index is taken into account when generating the
- * mask.
- *
- * This warning is compiled out when the compiler can infer that
- * @index and @size are less than LONG_MAX.
- */
-#define array_index_mask_nospec_check(index, size)				\
-({										\
-	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,			\
-	    "array_index_nospec() limited to range of [0, LONG_MAX]\n"))	\
-		_mask = 0;							\
-	else									\
-		_mask = array_index_mask_nospec(index, size);			\
-	_mask;									\
-})
-
-/*
  * array_index_nospec - sanitize an array index after a bounds check
  *
  * For a code sequence like:
@@ -67,7 +47,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
+	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
