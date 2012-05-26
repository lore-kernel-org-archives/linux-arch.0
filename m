From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 20:41:35 -0400 (EDT)
Message-ID: <20120525.204135.1619066165157180427.davem@davemloft.net>
References: <20120525.191407.1171512018515372695.davem@davemloft.net>
	<CA+55aFxyno-mCNsJZzpW+5HAc0KA477ZeHGZ6=ONLcnHWiHaEA@mail.gmail.com>
	<20120525.194125.1593753424815090718.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:54247 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab2EZAlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 20:41:49 -0400
In-Reply-To: <20120525.194125.1593753424815090718.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

=46rom: David Miller <davem@davemloft.net>
Date: Fri, 25 May 2012 19:41:25 -0400 (EDT)

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, 25 May 2012 16:37:40 -0700
>=20
>> On Fri, May 25, 2012 at 4:14 PM, David Miller <davem@davemloft.net> =
wrote:
>>>
>>> I suppose then I'd need to make BE's has_zero() a macro instead of =
a
>>> function. =A0Either that or we pass a pointer to this opaque typede=
f
>>> thing.
>>=20
>> Gcc is *usually* pretty good about optimizing small structures on th=
e
>> stack, even if you pass a pointer (if the pointer then always gets
>> dereferenced within that function). So I think you could try the
>> "pointer to opaque thing" approach and see.
>>=20
>> But yeah, the macro approach obviously puts much less reliance on th=
e
>> optimizer getting things right, so it might be the way to go if it
>> turns out that gcc screws up code generation.
>=20
> I'm playing around with this now, I should have something for you
> to look at in the next few hours.

Ok, something like the following, just to give you an idea.  Just the
sparc word-at-a-time.h header addition and the lib/strnlen_user.c
changes.

Probably I should add little-endian code to the header and put it
under asm-generic instead since there isn't really anything sparc
specific about it and this will make it easier for other ports to use
this stuff.

This is untested and of course we'd need to tweak the x86
word-at-a-time header and adjust the other call sites in
the DCACHE and elsewhere.

In fact, one thing I need to do next is see how suitable these
interface adjustments are for those uses.  I've only really made sure
that they work out for the new generic lib/str*.c routines.

Looking at the assembler, gcc does a reasonable job with the
aggregates, optimizing them just as if they were scalar local
variables.

diff --git a/arch/sparc/include/asm/word-at-a-time.h b/arch/sparc/inclu=
de/asm/word-at-a-time.h
new file mode 100644
index 0000000..7fb32e1
--- /dev/null
+++ b/arch/sparc/include/asm/word-at-a-time.h
@@ -0,0 +1,49 @@
+#ifndef _ASM_WORD_AT_A_TIME_H
+#define _ASM_WORD_AT_A_TIME_H
+
+#include <linux/kernel.h>
+
+struct word_op_data {
+	const unsigned long high_bits;
+	const unsigned long low_bits;
+	unsigned long rhs;
+};
+
+typedef struct word_op_data word_op_data_t;
+
+#define INIT_WORD_OP_DATA			\
+{	.high_bits =3D REPEAT_BYTE(0xfe) + 1,	\
+	.low_bits  =3D REPEAT_BYTE(0x7f),		\
+}
+
+#define DEFINE_WORD_OP_DATA(X)	\
+	word_op_data_t X =3D INIT_WORD_OP_DATA
+
+static inline long find_zero(unsigned long c, word_op_data_t *p)
+{
+	unsigned long mask =3D (c & p->low_bits) + p->low_bits;
+	long byte;
+
+	mask =3D ~(mask | p->rhs);
+
+	byte =3D 0;
+#ifdef CONFIG_64BIT
+	if (mask >> 32)
+		mask >>=3D 32;
+	else
+		byte =3D 4;
+#endif
+	if (mask >> 16)
+		mask >>=3D 16;
+	else
+		byte +=3D 2;
+	return (mask >> 8) ? byte : byte + 1;
+}
+
+static inline bool has_zero(unsigned long c, word_op_data_t *p)
+{
+	p->rhs =3D c | p->low_bits;
+	return (c + p->high_bits) & ~p->rhs;
+}
+
+#endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 3dc78a8..d5fdd26 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -30,6 +30,7 @@
  */
 static inline long do_strnlen_user(const char __user *src, unsigned lo=
ng count, unsigned long max)
 {
+	DEFINE_WORD_OP_DATA(wd);
 	long align, res =3D 0;
 	unsigned long c;
=20
@@ -53,14 +54,8 @@ static inline long do_strnlen_user(const char __user=
 *src, unsigned long count,
 	c |=3D aligned_byte_mask(align);
=20
 	for (;;) {
-		unsigned long mask;
-
-		mask =3D has_zero(c);
-		if (mask) {
-			mask =3D (mask - 1) & ~mask;
-			mask >>=3D 7;
-			return res + count_masked_bytes(mask) + 1 - align;
-		}
+		if (has_zero(c, &wd))
+			return res + find_zero(c, &wd) + 1 - align;
 		res +=3D sizeof(unsigned long);
 		if (unlikely(max < sizeof(unsigned long)))
 			break;
