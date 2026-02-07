Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C279430F930;
	Sat,  7 Feb 2026 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770504046; cv=none; b=eK4WiwvNZGgkTdwc2N0WxP2/O8xKp1x1W0XUQxXdokHA6wWei8N19l6XLqTTtgBYij9jut6CFGOWwIR3zc60aGna7go5G/hLNt97G0HLHqltFpxvUPecaYvGieP7+a6BUsraIvCPrNcNa+1pQjAxeDepV7uYAcE6JTBY9lGMhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770504046; c=relaxed/simple;
	bh=SXoaglSV4NEHhID4PsRIxokDHi/rawIRGOnEFp1vsG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvWZ4/DSfc6coxZIooj2peC2NRVa3v6xQ+3vRGjHwmMVYE3BgCvMiDRmFR28wbx+ELQdtWQ1M4Gl5wuc7OX3jymWxbiVMLBNe0Pcb4ry0L1riathi97qaBzlThTNpg01gwILctxN8H4nDex3qKxJrNlh47uKps9+46GEhsexBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dA7cEzoT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GefQAsrG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dA7cEzoT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GefQAsrG"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770504043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26zukAnyaZ7+GEOYV49xEESgd7uXEfmA9qbLmnd6rDg=;
	b=dA7cEzoTgwdKKV/muUajapRw863cCms5sJnj1oZS+bi0ULe6ir18x/IZKeMtk8oDPxLK2q
	Q1Xokl19E9eQ2Jo/D8zO2YH+mZLwYRy9h1h7Z781VW9m/ocKhWXBjYwc3lIPQo4eOqF3io
	5zJkY7Q7GqsUsD6BKcy3qjF2xPrYsYYcF9Dc+fGV5KGKDuDrwoIQH/xZzVCakr/AwIlx1q
	RHpz/uuVxn+B+wL1Npr/fJ+5B/HHVTh+ZKPJXfHtC4nVjnH9BW5bD16vodYomGbBXzqLMy
	oWjUgBSyS22xEPvOMe2LzBLds0CrP7Wx7VO1/pXTydZ7k4Ijfkd5UolNNKW/0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770504043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26zukAnyaZ7+GEOYV49xEESgd7uXEfmA9qbLmnd6rDg=;
	b=GefQAsrGKRbeCGLHJaaoQcXdLzUewzzp8kLDvq23on3zyhIL/iXRe/0MNhyIbDDlvtKOaS
	FU1E17zn+BsImcBA==
To: david.laight.linux@gmail.com, Nathan Chancellor <nathan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Jani
 Nikula <jani.nikula@intel.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH next 12/14] bits: move the defitions of BIT() and
 BIT_ULL() back to linux/bits.h
In-Reply-To: <20260121145731.3623-13-david.laight.linux@gmail.com>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-13-david.laight.linux@gmail.com>
Date: Sat, 07 Feb 2026 23:40:41 +0100
Message-ID: <87cy2gb2ja.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 21 2026 at 14:57, david laight linux wrote:

TLDR: Not going to happen. Period.

> Move BIT_ULL() and make code that include both headers use the definition
> of BIT() from linux/bits.h
> Add BIT_U128() for completness.

1) How is that related to $Subject?

2) It's clearly documented that patches should not do different things
   at once.

3) It's also documented that stuff is only added when there is a use
   case. I can't find one.

> Note that nothing the the x86-64 build relies on the definition in
> vdso/bits.h, linux/bits.h is always included.

Wrong. The x86-64 build includes vdso/bits.h for the VDSO build.

> @@ -2,7 +2,6 @@
>  #ifndef __LINUX_BITS_H
>  #define __LINUX_BITS_H
>  
> -#include <vdso/bits.h>
>  #include <uapi/linux/bits.h>
>  
>  #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
> @@ -89,10 +88,16 @@ int BIT_INPUT_CHECK_FAIL(void) __compiletime_error("Bit number out of range");
>  	((unsigned int)BIT_INPUT_CHECK(+(nr), BITS_PER_TYPE(type)) + ((type)1 << (nr)))
>  #endif /* defined(__ASSEMBLY__) */
>  
> +/* Prefer this definition of BIT() to the one in vdso/bits.h */
> +#undef BIT

That's a horrible sloppy hack.

> +#define __VDSO_BITS_H

And this even more so.

> +#define BIT(nr)		BIT_TYPE(unsigned long, nr)
> +#define BIT_ULL(nr)	BIT_TYPE(unsigned long long, nr)

Aside of that you sloppily kept the comment above all of this intact,
which does not make any sense at all after this change. It says:

/*
 * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
 * following examples generate compiler warnings due to -Wshift-count-overflow:
 *
 * - BIT_U8(8)
 * - BIT_U32(-1)
 * - BIT_U32(40)
 */

I have to admit that you are at least consistently sloppy.

>  #define BIT_U8(nr)	BIT_TYPE(u8, nr)
>  #define BIT_U16(nr)	BIT_TYPE(u16, nr)
>  #define BIT_U32(nr)	BIT_TYPE(u32, nr)
>  #define BIT_U64(nr)	BIT_TYPE(u64, nr)
> +#define BIT_U128(nr)	BIT_TYPE(u128, nr)

What's wrong with the obvious solution of moving all this BIT_XX() muck
into vdso/bit.h?

Especially as you say in your changelog word salad:

> This lets BIT() pick up the extra compile time checks for W=[1c] builds
> that detect errors like:
> 	long foo(void) { int x = 64; return BIT(x); }
> For which clang (silently) just generates a 'return' instruction.

Letting the VDSO build have the same checks with a W=1 build would be
too sensible, right?

It's not rocket science to achieve that. See below.

That's admittedly a hack too, but a more palatable hack and I'm just
including it for illustration.

Just for the record: I definitely spent less time hacking that up than I
wasted reviewing and replying to your slop.

The proper thing to do is to move all the stuff which is neither vdso
nor kernel specific into a separate include/$BIKESHEDTHENAME/ directory
and sort out that ever recurring problem of VDSO vs. kernel builds once
and forever. That's not rocket science either.

That'd be too reasonable and tasteful, but not convoluted and sloppy
enough, right?

Thanks,

        tglx
---
 include/vdso/compiler.h   |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/bits.h      |   20 ------------
 include/linux/compiler.h  |   71 ------------------------------------------
 include/vdso/bits.h       |   23 ++++++++++++-
 4 files changed, 97 insertions(+), 93 deletions(-)

---
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -9,8 +9,6 @@
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
-#define BITS_PER_BYTE		8
-#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 
 /*
  * Create a contiguous bitmask starting at bit position @l and ending at
@@ -57,24 +55,6 @@
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
 #define GENMASK_U128(h, l)	GENMASK_TYPE(u128, h, l)
 
-/*
- * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
- * following examples generate compiler warnings due to -Wshift-count-overflow:
- *
- * - BIT_U8(8)
- * - BIT_U32(-1)
- * - BIT_U32(40)
- */
-#define BIT_INPUT_CHECK(type, nr) \
-	BUILD_BUG_ON_ZERO(const_true((nr) >= BITS_PER_TYPE(type)))
-
-#define BIT_TYPE(type, nr) ((type)(BIT_INPUT_CHECK(type, nr) + BIT_ULL(nr)))
-
-#define BIT_U8(nr)	BIT_TYPE(u8, nr)
-#define BIT_U16(nr)	BIT_TYPE(u16, nr)
-#define BIT_U32(nr)	BIT_TYPE(u32, nr)
-#define BIT_U64(nr)	BIT_TYPE(u64, nr)
-
 #else /* defined(__ASSEMBLY__) */
 
 /*
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -279,53 +279,6 @@ static inline void *offset_to_ptr(const
 	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
 /*
- * This returns a constant expression while determining if an argument is
- * a constant expression, most importantly without evaluating the argument.
- * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
- *
- * Details:
- * - sizeof() return an integer constant expression, and does not evaluate
- *   the value of its operand; it only examines the type of its operand.
- * - The results of comparing two integer constant expressions is also
- *   an integer constant expression.
- * - The first literal "8" isn't important. It could be any literal value.
- * - The second literal "8" is to avoid warnings about unaligned pointers;
- *   this could otherwise just be "1".
- * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
- *   architectures.
- * - The C Standard defines "null pointer constant", "(void *)0", as
- *   distinct from other void pointers.
- * - If (x) is an integer constant expression, then the "* 0l" resolves
- *   it into an integer constant expression of value 0. Since it is cast to
- *   "void *", this makes the second operand a null pointer constant.
- * - If (x) is not an integer constant expression, then the second operand
- *   resolves to a void pointer (but not a null pointer constant: the value
- *   is not an integer constant 0).
- * - The conditional operator's third operand, "(int *)8", is an object
- *   pointer (to type "int").
- * - The behavior (including the return type) of the conditional operator
- *   ("operand1 ? operand2 : operand3") depends on the kind of expressions
- *   given for the second and third operands. This is the central mechanism
- *   of the macro:
- *   - When one operand is a null pointer constant (i.e. when x is an integer
- *     constant expression) and the other is an object pointer (i.e. our
- *     third operand), the conditional operator returns the type of the
- *     object pointer operand (i.e. "int *"). Here, within the sizeof(), we
- *     would then get:
- *       sizeof(*((int *)(...))  == sizeof(int)  == 4
- *   - When one operand is a void pointer (i.e. when x is not an integer
- *     constant expression) and the other is an object pointer (i.e. our
- *     third operand), the conditional operator returns a "void *" type.
- *     Here, within the sizeof(), we would then get:
- *       sizeof(*((void *)(...)) == sizeof(void) == 1
- * - The equality comparison to "sizeof(int)" therefore depends on (x):
- *     sizeof(int) == sizeof(int)     (x) was a constant expression
- *     sizeof(int) != sizeof(void)    (x) was not a constant expression
- */
-#define __is_constexpr(x) \
-	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
-
-/*
  * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
  * bool and also pointer types.
  */
@@ -342,28 +295,6 @@ static inline void *offset_to_ptr(const
 #define statically_true(x) (__builtin_constant_p(x) && (x))
 
 /*
- * Similar to statically_true() but produces a constant expression
- *
- * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
- * which require their input to be a constant expression and for which
- * statically_true() would otherwise fail.
- *
- * This is a trade-off: const_true() requires all its operands to be
- * compile time constants. Else, it would always returns false even on
- * the most trivial cases like:
- *
- *   true || non_const_var
- *
- * On the opposite, statically_true() is able to fold more complex
- * tautologies and will return true on expressions such as:
- *
- *   !(non_const_var * 8 % 4)
- *
- * For the general case, statically_true() is better.
- */
-#define const_true(x) __builtin_choose_expr(__is_constexpr(x), x, false)
-
-/*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
  */
--- a/include/vdso/bits.h
+++ b/include/vdso/bits.h
@@ -2,9 +2,26 @@
 #ifndef __VDSO_BITS_H
 #define __VDSO_BITS_H
 
+#include <vdso/compiler.h>
 #include <vdso/const.h>
 
-#define BIT(nr)			(UL(1) << (nr))
-#define BIT_ULL(nr)		(ULL(1) << (nr))
+#if !defined(__ASSEMBLY__)
 
-#endif	/* __VDSO_BITS_H */
+#define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
+
+/* Check for BIT() similar to GENMASK_TYPE() to catch shift count overflow at compile time */
+#define BIT_INPUT_CHECK(type, nr) \
+	BUILD_BUG_ON_ZERO(const_true((nr) >= BITS_PER_TYPE(type)))
+
+#define BIT_TYPE(type, nr) ((type)(BIT_INPUT_CHECK(type, nr) + (ULL(1) << (nr))))
+
+#define BIT(nr)		BIT_TYPE(unsigned long, nr)
+#define BIT_ULL(nr)	BIT_TYPE(unsigned long long, nr)
+#define BIT_U8(nr)	BIT_TYPE(u8, nr)
+#define BIT_U16(nr)	BIT_TYPE(u16, nr)
+#define BIT_U32(nr)	BIT_TYPE(u32, nr)
+#define BIT_U64(nr)	BIT_TYPE(u64, nr)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __VDSO_BITS_H */
--- /dev/null
+++ b/include/vdso/compiler.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_COMPILER_H
+#define __VDSO_COMPILER_H
+
+#include <linux/compiler_types.h>
+
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ *
+ * Details:
+ * - sizeof() return an integer constant expression, and does not evaluate
+ *   the value of its operand; it only examines the type of its operand.
+ * - The results of comparing two integer constant expressions is also
+ *   an integer constant expression.
+ * - The first literal "8" isn't important. It could be any literal value.
+ * - The second literal "8" is to avoid warnings about unaligned pointers;
+ *   this could otherwise just be "1".
+ * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
+ *   architectures.
+ * - The C Standard defines "null pointer constant", "(void *)0", as
+ *   distinct from other void pointers.
+ * - If (x) is an integer constant expression, then the "* 0l" resolves
+ *   it into an integer constant expression of value 0. Since it is cast to
+ *   "void *", this makes the second operand a null pointer constant.
+ * - If (x) is not an integer constant expression, then the second operand
+ *   resolves to a void pointer (but not a null pointer constant: the value
+ *   is not an integer constant 0).
+ * - The conditional operator's third operand, "(int *)8", is an object
+ *   pointer (to type "int").
+ * - The behavior (including the return type) of the conditional operator
+ *   ("operand1 ? operand2 : operand3") depends on the kind of expressions
+ *   given for the second and third operands. This is the central mechanism
+ *   of the macro:
+ *   - When one operand is a null pointer constant (i.e. when x is an integer
+ *     constant expression) and the other is an object pointer (i.e. our
+ *     third operand), the conditional operator returns the type of the
+ *     object pointer operand (i.e. "int *"). Here, within the sizeof(), we
+ *     would then get:
+ *       sizeof(*((int *)(...))  == sizeof(int)  == 4
+ *   - When one operand is a void pointer (i.e. when x is not an integer
+ *     constant expression) and the other is an object pointer (i.e. our
+ *     third operand), the conditional operator returns a "void *" type.
+ *     Here, within the sizeof(), we would then get:
+ *       sizeof(*((void *)(...)) == sizeof(void) == 1
+ * - The equality comparison to "sizeof(int)" therefore depends on (x):
+ *     sizeof(int) == sizeof(int)     (x) was a constant expression
+ *     sizeof(int) != sizeof(void)    (x) was not a constant expression
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+/*
+ * Similar to statically_true() but produces a constant expression
+ *
+ * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
+ * which require their input to be a constant expression and for which
+ * statically_true() would otherwise fail.
+ *
+ * This is a trade-off: const_true() requires all its operands to be
+ * compile time constants. Else, it would always returns false even on
+ * the most trivial cases like:
+ *
+ *   true || non_const_var
+ *
+ * On the opposite, statically_true() is able to fold more complex
+ * tautologies and will return true on expressions such as:
+ *
+ *   !(non_const_var * 8 % 4)
+ *
+ * For the general case, statically_true() is better.
+ */
+#define const_true(x) __builtin_choose_expr(__is_constexpr(x), x, false)
+
+#endif
