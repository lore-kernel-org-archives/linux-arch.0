From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [concept & "good taste" review] persistent store
Date: Mon, 20 Dec 2010 08:52:59 -0800
Message-ID: <AANLkTikZm6Rm4nWxjrnNh4yY8T+b3xDqB3jXOwvUsRig@mail.gmail.com>
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
	<17090.1292842179@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47798 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292Ab0LTQxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2010 11:53:00 -0500
In-Reply-To: <17090.1292842179@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, greg@kroah.com, akpm@linux-foundation.org, ying.huang@intel.com, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, Dec 20, 2010 at 2:49 AM, David Howells <dhowells@redhat.com> wr=
ote:
> How are things written to the store? =A0Is it a record-based affair?

Yes, the ERST store is record based ... record format is defined in UEF=
I.
To save blobs of console logs I just defined a new uuid for a section t=
ype
that holds a bunch of bytes for me.

-Tony
