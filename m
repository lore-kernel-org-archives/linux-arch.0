From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: x86: faster strncpy_from_user()
Date: Wed, 11 Apr 2012 10:22:38 +0200
Message-ID: <CAMuHMdXqiydN5GmnksyJ3ThSUtq9CSeop_BQhyVqcTVAugBJAA@mail.gmail.com>
References: <1334097321.3040.62.camel@pasglop>
	<20120410.192550.1904257005034151185.davem@davemloft.net>
	<CA+55aFwAQ13t6HwPVmvntwPvDq_kK6=W9e8KLahtfGwKr=2YCQ@mail.gmail.com>
	<20120410.204322.1625218582933057448.davem@davemloft.net>
	<CA+55aFwVbGzk1Nwj1uk=R_XPPEkF2wZ_K8zhbmPZjy39r4rYDQ@mail.gmail.com>
	<CA+55aFw9-cVKP4MUpO6pCLbpHavrB1qbJ1NeiXEBbNupZ0iYKA@mail.gmail.com>
	<1334107501.2984.19.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55844 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab2DKIWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Apr 2012 04:22:38 -0400
Received: by iagz16 with SMTP id z16so957518iag.19
        for <linux-arch@vger.kernel.org>; Wed, 11 Apr 2012 01:22:38 -0700 (PDT)
In-Reply-To: <1334107501.2984.19.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, mingo@kernel.org, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org

On Wed, Apr 11, 2012 at 03:25, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>> Of course, RISC people tended to throw out rotate too, so maybe you
>> don't have even that.
>
> Well, we do have a very nice & flexible rotate & mask on ppc at
> least :-)

PPC is not RISC. It's LSWNOWCITCSCIOC.

(let-see-which-new-operations-we-can-invent-that-can-still-complete-in-=
one-cycle
;-)

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
