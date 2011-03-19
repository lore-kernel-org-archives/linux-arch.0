From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Support for ARM940T core Samsung S3C2510A MCU under Linux
Date: Sat, 19 Mar 2011 11:46:55 +0100
Message-ID: <AANLkTimPoEi+XLUJgza-b_gXbd4kCGpF93MySAR0ZRvT@mail.gmail.com>
References: <AANLkTi=T=QM_GmYYnd8yXJz37LOKqt+AFWk7EEw-7uaN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57004 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab1CSKq4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2011 06:46:56 -0400
Received: by fxm17 with SMTP id 17so4367811fxm.19
        for <linux-arch@vger.kernel.org>; Sat, 19 Mar 2011 03:46:55 -0700 (PDT)
In-Reply-To: <AANLkTi=T=QM_GmYYnd8yXJz37LOKqt+AFWk7EEw-7uaN@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Madhavi Manchala <madhavi.linux@gmail.com>
Cc: linux-arch@vger.kernel.org, gregkh@suse.de, arnd@arndb.de, prasadjoshi124@gmail.com, uClinux development list <uclinux-dev@uclinux.org>

On Sat, Mar 19, 2011 at 10:53, Madhavi Manchala <madhavi.linux@gmail.co=
m> wrote:
> I have one basic question about the architecture files in Linux
> kernels. We have a board with Samsung S3C2510A MCU (ARM940T core)
> which is a no-mmu based CPU. I heard that "there was not a lot of ARM
> no-mmu support at the moment" from Ben Dooks.
>
> So, I started developing the architecture files for my Samsung
> S3C2510A MCU (ARM940T core) by looking at the existing S3C2410A
> (ARM920 core) architecture files. Is this my porting (developing the
> architecture files) correct?
>
> How can I port the Linux on to my board which has a Samsung S3C2510A
> MCU (ARM940T core) which is a NO-MMU based CPU?
>
> Please suggest me. It would be appreciated your help / suggestions.

I think the uClinux mailing list (CCed) is a more appropriate mailing l=
ist for
your questions.

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
