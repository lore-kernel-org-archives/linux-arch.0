From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [patch 0/4] [RFC] mcount address adjustment
Date: Mon, 16 May 2011 13:57:17 +0100
Message-ID: <20110516125717.GB7715@arm.com>
References: <20110510081039.241831019@de.ibm.com>
 <BANLkTi=6FLtzXwg1yLAkLhP4GA4apSQ46g@mail.gmail.com>
 <20110512112454.2fa7e6d6@mschwide>
 <BANLkTinY+gDxoHk4378kXd8WH-hf9CN6ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41425 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab1EPM5X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 May 2011 08:57:23 -0400
Received: by wwa36 with SMTP id 36so5094911wwa.1
        for <linux-arch@vger.kernel.org>; Mon, 16 May 2011 05:57:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinY+gDxoHk4378kXd8WH-hf9CN6ZA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rabin Vincent <rabin@rab.in>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, May 12, 2011 at 07:00:13PM +0530, Rabin Vincent wrote:
> On Thu, May 12, 2011 at 14:54, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Wed, 11 May 2011 22:53:55 +0530 Rabin Vincent <rabin@rab.in> wro=
te:
> >> On Tue, May 10, 2011 at 13:40, Martin Schwidefsky <schwidefsky@de.=
ibm.com> wrote:
> >> Thumb-2 via recordmcount.pl needs the clearing of the lsb because =
the
> >> relocation (R_ARM_ABS32) that gets used for the assembly file
> >> that recordmcount.pl generates and assembles dictates that the lsb=
 be
> >> set if the target symbol is Thumb/Thumb-2 function. =A0mcount_adju=
st would
> >> not help here since the ORing is done later, when the relocation i=
s
> >> applied.
> >
> > Hmm, from what I can make out the C version of recordmcount uses R_=
ARM_ABS32
> > as well.
>=20
> Right.  It worked when I initially implemented ARM support there beca=
use
> recordmcount.c always found the STT_SECTION symbol as a base and not =
a
> STT_FUNC symbol.  However, I noticed yesterday that this does not hap=
pen
> in some cases, so I sent a patch to avoid STT_FUNC symbol as bases on
> ARM, not because of this relocation, but because of a slightly differ=
ent
> oddity of Thumb symbols:
>=20
> http://lkml.org/lkml/2011/5/11/304
>=20
> (The relocation problem alone could be solved by using R_ARM_ABS32_NO=
I
>  instead.)
>=20
> >
> >> Thumb-2 via recordmcount.c does not need the clearing of the lsb i=
n
> >> ftrace_call_adjust.
> >
> > So the clearing of the lsb is only required if the recordmcount.pl =
script
> > is used?
>=20
> Yes.
>=20
> >> Building with the ARM instruction set also does not need the clear=
ing
> >> of the lsb.
> >
> > Who does the ORing? I can't find anything in recordmount.pl/recordm=
count.c
> > which looks like doing an OR, does the assembler do that based on t=
he
> > symbol type?
>=20
> The lsb is set to 1 by the linker, when it applies the relocations as=
 it
> links vmlinux.
>=20
> >
> >> > Thumb-2 the offset is -1, correct? If there is a way to distingu=
ish
> >> > the two targets in recordmcount at compile time we could convert=
 arm
> >> > as well. Which would allow us to remove the ftrace_call_adjust f=
unction.
> >>
> >> To remove ftrace_call_adjust, we could either deprecate the
> >> recordmcount.pl usage for ARM (you already have to edit the Kconfi=
g to
> >> use it) or modify it to generate specific relocations explicitly i=
nstead
> >> of using the assembler data directives.
> >
> > Hmm, it would be a desirable property if the C version and the pear=
l
> > version of recordmcount would do the same. Or we could remove the a=
rm
> > support from the pearl script, the C version is faster anyway.
>=20
> I'm OK with removing the ARM support from recordmcount.pl; it doesn't
> seem needed to make significant modifications to it for ARM when we
> don't use it anyway.

Is there any reason why the recordmcount.pl would ever be used now that=
 the
C implementation exists?

I notice that arch/arm/Kconfig has:

config ARM
=2E..
        select HAVE_C_RECORDMCOUNT

so deprecating ARM support from recordmcount.pl seems unlikely to hurt
anyone.

The C implementation seems to have worked fine when I was testing dynam=
ic
ftrace with Thumb-2 recently.

Cheers
---Dave
