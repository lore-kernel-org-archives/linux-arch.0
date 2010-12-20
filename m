From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [concept & "good taste" review] persistent store
Date: Mon, 20 Dec 2010 09:19:32 -0800
Message-ID: <AANLkTikULE_Jncjs=PkARjZyxb=f+t=4J8g8LQL+L=BZ@mail.gmail.com>
References: <4d0662e511688484b3@agluck-desktop.sc.intel.com>
	<AANLkTindPUkF7fCkdbqSstNHFjF3_7fEYh18nhQFx_AJ@mail.gmail.com>
	<AANLkTim3OpjPysjdCLDuFgFOipmcxyr2ay5cvUAu5PHi@mail.gmail.com>
	<AANLkTinpYJddhgbf7=Pw_TtGrnWaC8fwo2xv1XRsT1w7@mail.gmail.com>
	<AANLkTimA4x8oWyq71nOxB=Otp3Y0i3Kcu27DG0ajaXUG@mail.gmail.com>
	<AANLkTinCG+E6ZzpeRqsJP+-qvNDQXW4VZFgJ1c-sTryL@mail.gmail.com>
	<4D0BEE1F.7020008@zytor.com>
	<AANLkTinwFt+KDKNEYP9MWQ7wGb9qk=E2Xa3RJB3+MJnN@mail.gmail.com>
	<AANLkTinoV_pL=Ygqq4qt4f8c+wsdc9r9K7rcJ58aHjD1@mail.gmail.com>
	<AANLkTikhtWjFBQmA111Q+2JGRudrRNAmegGThMagr4vF@mail.gmail.com>
	<20101219091752.GA16150@liondog.tnic>
	<AANLkTi=9UZ5BYWo5xT=jh0upRP6PraH4S=t=tL49YRdr@mail.gmail.com>
	<1292813234.8743.66.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46427 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676Ab0LTRTd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2010 12:19:33 -0500
In-Reply-To: <1292813234.8743.66.camel@yhuang-dev>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Huang Ying <ying.huang@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "greg@kroah.com" <greg@kroah.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Sun, Dec 19, 2010 at 6:47 PM, Huang Ying <ying.huang@intel.com> wrot=
e:
> 8KB is about 100-200 lines message, sometimes it may be not enough fo=
r
> all necessary information. =A0But in fact, we can use multiple ERST
> records to save one kernel message dumping. So the real limitation is
> just total storage capacity.

We can - but it will be a bit messy within my pstore + platform driver
framework (I'd have to have erst tell pstore that it could handle some
larger size, 2x or 3x the actual record size and then break a write
into pieces. Presumably re-assemble on the read side too).

It would be good to get some data from real users to see
whether this is required, or whether ~8K actually is adequate
in enough situations to allow us to keep the code simple.

If anyone with a fairly new X86 server system (up to a
couple of years old ... check to see whether it has ERST
support in BIOS with: "dmesg | grep ERST") wants to test
this, the latest code is in today's linux-next tree, tagged
as "next-20101220". (I have some hope that we might get
this together for the 2.6.38 merge window ... but if not,
then 2.6.39 would be fine too).

-Tony
