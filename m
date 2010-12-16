From: Nick Piggin <npiggin@gmail.com>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Fri, 17 Dec 2010 01:15:44 +1100
Message-ID: <AANLkTiksAkqrMtVDgxhm5s+jqMaKoUhbTaWsXfKJ9QOy@mail.gmail.com>
References: <12853.1292353313@jrobl>
	<AANLkTinjkcciZhJM5FmUkh_YCJ6bc9aTq8zV=SACDb1O@mail.gmail.com>
	<4D08BF5D.1060509@panasas.com>
	<20101215.100055.226772943.davem@davemloft.net>
	<4D09E185.2040600@panasas.com>
	<AANLkTin3v0BLYAuuqTgEzKgSOpVg4GJaJCEds=2ePrBH@mail.gmail.com>
	<4D0A1C40.7060502@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49978 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab0LPOPq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Dec 2010 09:15:46 -0500
In-Reply-To: <4D0A1C40.7060502@panasas.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: David Miller <davem@davemloft.net>, hooanon05@yahoo.co.jp, npiggin@kernel.dk, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2010 at 1:03 AM, Boaz Harrosh <bharrosh@panasas.com> wr=
ote:
> On 12/16/2010 03:13 PM, Nick Piggin wrote:
> static inline int dentry_memcmp_long(const unsigned char *cs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const =
unsigned char *ct, ssize_t count)
> {
> =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0const unsigned long *ls =3D (const unsigned long *)cs;
> =A0 =A0 =A0 =A0const unsigned long *lt =3D (const unsigned long *)ct;
>
> =A0 =A0 =A0 =A0while (count > 8) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D (*cs !=3D *ct);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ct++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count-=3D8;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (count) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long t =3D *ct & ((0xffffffff=
ffffffff >> ((8 - count) * 8))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D (*cs !=3D t)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return ret;
> }
>
> Same as yours but just to avoid the branch inside the loop
> and slightly smaller code.

That's true, it should make the branch more predictable too. Well,
maybe. I'm going to leave it as-is for now, but I would welcome any
test results or ideas for improvements.


> BTW: On some ARCHs ++foo is faster than foo++
> =A0 =A0 and Also, is there a reason not to write the above loop as:
>
> =A0 =A0 while(c-- && (ret =3D (*cs++ !=3D *ct++)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;

gcc should turn it into the same thing these days. I prefer avoiding
expressions with side effects in control statements (other than a
simple counter).

Thanks,
Nick
