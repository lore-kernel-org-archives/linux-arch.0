From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Date: Thu, 25 Nov 2010 15:01:27 +0100
Message-ID: <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
References: <1290607413.12457.44.camel@concordia>
	<1290692075.689.20.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0KYOB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Nov 2010 09:01:29 -0500
In-Reply-To: <1290692075.689.20.camel@concordia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michael@ellerman.id.au
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>

On Thu, Nov 25, 2010 at 14:34, Michael Ellerman <michael@ellerman.id.au=
> wrote:
> I've left for_each_child_of_node(), because I read it as "of", but ma=
ybe
> it's "OF"?

I always read it as "for each child-OF-node", so I would rename it to
"dt_for_each_child_node".

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
