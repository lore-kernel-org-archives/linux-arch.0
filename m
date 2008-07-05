From: "Ricardo M. Correia" <Ricardo.M.Correia@Sun.COM>
Subject: Re: [3/3] Use __fls for fls64 on 64-bit archs
Date: Sat, 05 Jul 2008 17:56:37 +0100
Message-ID: <1215276997.7167.12.camel@localhost>
References: <20080315172913.GA21648@mailshack.com>
 <20080315173236.GC21659@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gmp-eb-inf-2.sun.com ([192.18.6.24]:53970 "EHLO
	gmp-eb-inf-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbYGEQ4k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Jul 2008 12:56:40 -0400
In-reply-to: <20080315173236.GC21659@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, heukelum@fastmail.fm

(Sorry, sending this again as I screwed up the previous mail).

Hi,

I have a question about fls64() which I hope you or someone else could
clarify, please see below.

=EF=BB=BFOn S=C3=A1b, 2008-03-15 at 18:32 +0100, Alexander van Heukelum=
 wrote:=20
> +#elif BITS_PER_LONG =3D=3D 64
> +static inline int fls64(__u64 x)
> +{
> +	if (x =3D=3D 0)
> +		return 0;
> +	return __fls(x) + 1;
> +}

It seems fls64() is implemented on top of __fls(), however the __fls()
implementation on the x86-64 architecture states that the result is
undefined if the argument does not have any zero bits.
So if I understand correctly, the statement "fls64(~0ULL)" would return
an undefined result on x64-64 instead of 64 as one would expect.

Wouldn't it make sense to check for ~0ULL in fls64()?

Thanks,
Ricardo
