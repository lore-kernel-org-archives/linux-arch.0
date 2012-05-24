From: David Miller <davem@davemloft.net>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 22:11:50 -0400 (EDT)
Message-ID: <20120523.221150.620846999543569983.davem@davemloft.net>
References: <CA+55aFy78h5z1fnW+TovTQ4wUBauUW4i7=Z583tbQVMhsWvTAQ@mail.gmail.com>
	<20120523.163644.875474822428763332.davem@davemloft.net>
	<CA+55aFx1HNC5rd5dzuKpNiHKWvkhoc=-y6hsAW-L_X7sz5Taog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:35610 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327Ab2EXCND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 22:13:03 -0400
In-Reply-To: <CA+55aFx1HNC5rd5dzuKpNiHKWvkhoc=-y6hsAW-L_X7sz5Taog@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2012 14:01:26 -0700

> On Wed, May 23, 2012 at 1:36 PM, David Miller <davem@davemloft.net> w=
rote:
>> 1) In the loop, use the test:
>>
>> =A0 =A0 =A0(x + 0xfefefeff) & ~(x | 0x7f7f7f7f)
>>
>> =A0 It's the same effective cost as the current test (on sparc
>> =A0 it would be ADD, OR, ANDNCC).
>>
>> =A0 We make sure to calculate the "x | 0x7f7f7f7f" part into
>> =A0 a variable which is not clobbered by the rest of the test.
>>
>> =A0 This is so we can reuse it in #2.
>>
>> 2) Once we find a word containing the zero byte, do a:
>>
>> =A0 =A0 =A0 =A0~(((x & 0x7f7f7f7f) + 0x7f7f7f7f) | x | 0x7f7f7f7f)
>>
>> =A0 and that "x | 0x7f7f7f7f" part is already calculated and thus
>> =A0 can be cribbed the place we left it in #1 above.
>>
>> =A0 And now we'll have exactly a 0x80 where there is a zero byte,
>> =A0 and no bleeding of 0x80 values into adjacent byte positions.
>>
>> Once we have that we can just test that mask directly for the
>> zero byte location search code.
>=20
> Sounds likely, and you only have two different constants to worry abo=
ut.

Ok, now confirmed, the following patch generates the best code I've
been able to get out of GCC thus far, and it's tested too.

Therefore, I'll push this out to my sparc tree.

Next, I'll try to add the abstractions et al. necessary to put this
under the top-level lib/ so others can use it too.

diff --git a/arch/sparc/lib/usercopy.c b/arch/sparc/lib/usercopy.c
index 851cb75..78c363f 100644
--- a/arch/sparc/lib/usercopy.c
+++ b/arch/sparc/lib/usercopy.c
@@ -17,29 +17,20 @@ static inline unsigned long has_zero(unsigned long =
a)
 	return ((a - REPEAT_BYTE(0x01)) & ~a) & REPEAT_BYTE(0x80);
 }
=20
-static inline long find_zero(unsigned long c)
+static inline long find_zero(unsigned long mask)
 {
+	long byte =3D 0;
 #ifdef CONFIG_64BIT
-	if (!(c & 0xff00000000000000UL))
-		return 0;
-	if (!(c & 0x00ff000000000000UL))
-		return 1;
-	if (!(c & 0x0000ff0000000000UL))
-		return 2;
-	if (!(c & 0x000000ff00000000UL))
-		return 3;
-#define __OFF 4
-#else
-#define __OFF 0
+	if (mask >> 32)
+		mask >>=3D 32;
+	else
+		byte =3D 4;
 #endif
-	if (!(c & 0xff000000))
-		return __OFF + 0;
-	if (!(c & 0x00ff0000))
-		return __OFF + 1;
-	if (!(c & 0x0000ff00))
-		return __OFF + 2;
-	return __OFF + 3;
-#undef __OFF
+	if (mask >> 16)
+		mask >>=3D 16;
+	else
+		byte +=3D 2;
+	return (mask >> 8) ? byte : byte + 1;
 }
=20
 /*
@@ -50,6 +41,8 @@ static inline long find_zero(unsigned long c)
  */
 static inline long do_strncpy_from_user(char *dst, const char __user *=
src, long count, unsigned long max)
 {
+	const unsigned long high_bits =3D REPEAT_BYTE(0xfe) + 1;
+	const unsigned long low_bits =3D REPEAT_BYTE(0x7f);
 	long res =3D 0;
=20
 	/*
@@ -63,14 +56,19 @@ static inline long do_strncpy_from_user(char *dst, =
const char __user *src, long
 		goto byte_at_a_time;
=20
 	while (max >=3D sizeof(unsigned long)) {
-		unsigned long c;
+		unsigned long c, v, rhs;
=20
 		/* Fall back to byte-at-a-time if we get a page fault */
 		if (unlikely(__get_user(c,(unsigned long __user *)(src+res))))
 			break;
+		rhs =3D c | low_bits;
+		v =3D (c + high_bits) & ~rhs;
 		*(unsigned long *)(dst+res) =3D c;
-		if (has_zero(c))
-			return res + find_zero(c);
+		if (v) {
+			v =3D (c & low_bits) + low_bits;;
+			v =3D ~(v | rhs);
+			return res + find_zero(v);
+		}
 		res +=3D sizeof(unsigned long);
 		max -=3D sizeof(unsigned long);
 	}
