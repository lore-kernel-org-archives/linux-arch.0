From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -tip -v4] irq_work: generic hard-irq context callbacks
Date: Wed, 15 Sep 2010 21:30:56 +0200
Message-ID: <AANLkTik=rm-Y1BMAP6qOM-ppLrptP_hP-6jMeNV1uVkx@mail.gmail.com>
References: <37141.91.60.150.116.1284563403.squirrel@www.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60440 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab0IOTbB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Sep 2010 15:31:01 -0400
In-Reply-To: <37141.91.60.150.116.1284563403.squirrel@www.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Huang Ying <ying.huang@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, paulus <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dhowells <dhowells@redhat.com>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

On Wed, Sep 15, 2010 at 17:10, Andi Kleen <andi@firstfloor.org> wrote:
>> On Wed, 2010-09-15 at 13:29 +0800, Huang Ying wrote:
>>> I uses the cross build tool from:
>>>
>>> http://www.kernel.org/pub/tools/crosstool/
>>
>> I'm not familiar with those, I build my own gcc-4.5.1 toolchains for=
 all
>> targets that would actually build a gcc toolchains, for those that d=
on't
>> I simply don't care about.
>
> I don't think it's a reasonable requirement to have every contributor
> compile on all architectures. If that was a general requirement
> soon nobody would send patches anymore.
>
> Cross arch breakages happen rarely and can be usually repaired after
> the fact.

As long as "the fact" is linux-next and not Linus' tree, we can live
with that ;-)

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
