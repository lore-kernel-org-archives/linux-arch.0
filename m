From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/3] nospec: Allow index argument to have const-qualified
 type
Date: Fri, 16 Feb 2018 13:20:48 -0800
Message-ID: <151881604837.17395.10812767547837568328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-arch@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

The last expression in a statement expression need not be a bare
variable, quoting gcc docs

  The last thing in the compound statement should be an expression
  followed by a semicolon; the value of this subexpression serves as the
  value of the entire construct.

and we already use that in e.g. the min/max macros which end with a
ternary expression.

This way, we can allow index to have const-qualified type, which will in
some cases avoid the need for introducing a local copy of index of
non-const qualified type. That, in turn, can prevent readers not
familiar with the internals of array_index_nospec from wondering about
the seemingly redundant extra variable, and I think that's worthwhile
considering how confusing the whole _nospec business is.

The expression _i&_mask has type unsigned long (since that is the type
of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
that), so in order not to change the type of the whole expression, add
a cast back to typeof(_i).

Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/nospec.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index d6701e34424f..172a19dc35ab 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -52,7 +52,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &= _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
