From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Fri, 11 Mar 2016 15:36:47 -0700
Message-ID: <1457735807.6393.206.camel@hpe.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
	 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
	 <20160305114012.GA7259@gmail.com> <1457370228.15454.311.camel@hpe.com>
	 <CALCETrUQsf7S-b+zDrof0g61NnSB3XuqdAxjsHyJfjT3D39D3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:54874 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbcCKVoQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 16:44:16 -0500
In-Reply-To: <CALCETrUQsf7S-b+zDrof0g61NnSB3XuqdAxjsHyJfjT3D39D3Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Thu, 2016-03-10 at 22:47 -0800, Andy Lutomirski wrote:
> On Mon, Mar 7, 2016 at 9:03 AM, Toshi Kani <toshi.kani@hpe.com> wrote=
:
> > Let me try to summarize...
> >=20
> > The original issue Luis brought up was that drivers written to work
> > with MTRR may create a single ioremap range covering multiple cache
> > attributes since MTRR can overwrite cache attribute of a certain
> > range.=C2=A0=C2=A0Converting such drivers with PAT-based ioremap in=
terfaces, i.e.
> > ioremap_wc() and ioremap_nocache(), requires a separate ioremap map=
 for
> > each cache attribute, which can be challenging as it may result in
> > overlapping ioremap ranges (in his term) with different cache
> > attributes.
> >=20
> > So, Luis asked about 'sematics of overlapping ioremap()' calls.=C2=A0=
=C2=A0Hence,
> > I responded that aliasing mapping itself is supported, but alias wi=
th
> > different cache attribute is not.=C2=A0=C2=A0We have checks in plac=
e to detect
> > such condition.=C2=A0=C2=A0Overlapping ioremap calls with a differe=
nt cache
> > attribute either fails or gets redirected to the existing cache
> > attribute on x86.
>=20
> A little off-topic, but someone reminded me recently: most recent CPU=
s
> have self-snoop.=C2=A0=C2=A0It's poorly documented, but on self-snoop=
ing CPUs, I
> think that a lot of the aliasing issues go away.=C2=A0=C2=A0We may be=
 able to
> optimize the code quite a bit on these CPUs.

Interesting. =C2=A0I wonder how much we can rely on this feature. =C2=A0=
Yes, by
looking at Intel SDM, it is indeed poorly documented. :-(=C2=A0

> I also wonder whether we can drop a bunch of the memtype tracking.
> After all, if we have aliases of different types on a self-snooping
> CPU and /dev/mem is locked down hard enough, we could maybe get away
> with letting self-snoop handle all the conflicts.
>=20
> (We could also make /dev/mem always do UC if it would help.)

It'd be interesting to know how it performs on an aliased map when it w=
orks
correctly...=C2=A0

Thanks,
-Toshi
