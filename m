From: Rabin Vincent <rabin@rab.in>
Subject: Re: [patch 0/4] [RFC] mcount address adjustment
Date: Thu, 12 May 2011 19:00:13 +0530
Message-ID: <BANLkTinY+gDxoHk4378kXd8WH-hf9CN6ZA@mail.gmail.com>
References: <20110510081039.241831019@de.ibm.com> <BANLkTi=6FLtzXwg1yLAkLhP4GA4apSQ46g@mail.gmail.com>
 <20110512112454.2fa7e6d6@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64111 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab1ELNay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 May 2011 09:30:54 -0400
Received: by bwz15 with SMTP id 15so1291163bwz.19
        for <linux-arch@vger.kernel.org>; Thu, 12 May 2011 06:30:53 -0700 (PDT)
In-Reply-To: <20110512112454.2fa7e6d6@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, May 12, 2011 at 14:54, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Wed, 11 May 2011 22:53:55 +0530 Rabin Vincent <rabin@rab.in> wrote=
:
>> On Tue, May 10, 2011 at 13:40, Martin Schwidefsky <schwidefsky@de.ib=
m.com> wrote:
>> Thumb-2 via recordmcount.pl needs the clearing of the lsb because th=
e
>> relocation (R_ARM_ABS32) that gets used for the assembly file
>> that recordmcount.pl generates and assembles dictates that the lsb b=
e
>> set if the target symbol is Thumb/Thumb-2 function. =A0mcount_adjust=
 would
>> not help here since the ORing is done later, when the relocation is
>> applied.
>
> Hmm, from what I can make out the C version of recordmcount uses R_AR=
M_ABS32
> as well.

Right.  It worked when I initially implemented ARM support there becaus=
e
recordmcount.c always found the STT_SECTION symbol as a base and not a
STT_FUNC symbol.  However, I noticed yesterday that this does not happe=
n
in some cases, so I sent a patch to avoid STT_FUNC symbol as bases on
ARM, not because of this relocation, but because of a slightly differen=
t
oddity of Thumb symbols:

http://lkml.org/lkml/2011/5/11/304

(The relocation problem alone could be solved by using R_ARM_ABS32_NOI
 instead.)

>
>> Thumb-2 via recordmcount.c does not need the clearing of the lsb in
>> ftrace_call_adjust.
>
> So the clearing of the lsb is only required if the recordmcount.pl sc=
ript
> is used?

Yes.

>> Building with the ARM instruction set also does not need the clearin=
g
>> of the lsb.
>
> Who does the ORing? I can't find anything in recordmount.pl/recordmco=
unt.c
> which looks like doing an OR, does the assembler do that based on the
> symbol type?

The lsb is set to 1 by the linker, when it applies the relocations as i=
t
links vmlinux.

>
>> > Thumb-2 the offset is -1, correct? If there is a way to distinguis=
h
>> > the two targets in recordmcount at compile time we could convert a=
rm
>> > as well. Which would allow us to remove the ftrace_call_adjust fun=
ction.
>>
>> To remove ftrace_call_adjust, we could either deprecate the
>> recordmcount.pl usage for ARM (you already have to edit the Kconfig =
to
>> use it) or modify it to generate specific relocations explicitly ins=
tead
>> of using the assembler data directives.
>
> Hmm, it would be a desirable property if the C version and the pearl
> version of recordmcount would do the same. Or we could remove the arm
> support from the pearl script, the C version is faster anyway.

I'm OK with removing the ARM support from recordmcount.pl; it doesn't
seem needed to make significant modifications to it for ARM when we
don't use it anyway.
