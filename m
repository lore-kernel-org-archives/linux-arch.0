From: "Alexander van Heukelum" <heukelum@fastmail.fm>
Subject: Re: [PATCH] Partially revert patch that encloses asm-offset.h numbers
 in brackets
Date: Tue, 02 Nov 2010 11:19:13 +0100
Message-ID: <1288693153.10585.1403155585@webmail.messagingengine.com>
References: <4CC5B1A1020000780001EF7C@vpn.id2.novell.com><20101025140218.5092.74117.stgit@warthog.procyon.org.uk><28707.1288018465@redhat.com><4CC5B8D3020000780001EFB4@vpn.id2.novell.com><1288538943.19875.1402847217@webmail.messagingengine.com>
 <AANLkTimO5bkya9-ucz0kxsW=cNX5FjJi0zQPsRVAycQ8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49647 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750851Ab0KBKTO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Nov 2010 06:19:14 -0400
In-Reply-To: <AANLkTimO5bkya9-ucz0kxsW=cNX5FjJi0zQPsRVAycQ8@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jan Beulich <JBeulich@novell.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@linux.intel.com>, torvalds@osdl.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>

On Tue, 02 Nov 2010 16:30 +0800, "Ming Lei" <tom.leiming@gmail.com> wro=
te:
> 2010/10/31 Alexander van Heukelum <heukelum@fastmail.fm>:
> > In file included from /home/src/linux/linux-2.6/arch/x86/include/as=
m/suspend_32.h:10,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from /home/=
src/linux/linux-2.6/arch/x86/include/asm/suspend.h:2,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from /home/=
src/linux/linux-2.6/arch/x86/kernel/asm-offsets_32.c:21,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from /home/=
src/linux/linux-2.6/arch/x86/kernel/asm-offsets.c:2:
> > /home/src/linux/linux-2.6/arch/x86/include/asm/i387.h: In function =
=E2=80=98irq_ts_save=E2=80=99:
> > /home/src/linux/linux-2.6/arch/x86/include/asm/i387.h:325: error: i=
mplicit declaration of function =E2=80=98kernel_locked=E2=80=99
> > make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
>=20
> This also touches me too on .37-rc1, any patch for the compile failur=
e?

I think this one fixes it:

http://lkml.org/lkml/2010/10/28/151

Greetings,
    Alexander

> thanks,
> --=20
> Lei Ming
>=20
