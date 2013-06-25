From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: c6x: kernel: include "linux/console.h" when 'VT'
 and 'DUMMY_CONSOLE' enabled.
Date: Tue, 25 Jun 2013 09:06:17 +0200
Message-ID: <CAMuHMdXngNACn+Qfw1ytJkWWLm_BC+g_PTDpHHbUQyeeyVu8Fg@mail.gmail.com>
References: <51C8F948.2040204@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:44587 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3FYHGR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 03:06:17 -0400
In-Reply-To: <51C8F948.2040204@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>, Tony Breeds <tony@bakeyournoodle.com>
Cc: Mark Salter <msalter@redhat.com>, "a-jacquiot@ti.com" <a-jacquiot@ti.com>, jkc@redhat.com, linux-c6x-dev@linux-c6x.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Tue, Jun 25, 2013 at 3:58 AM, Chen Gang <gang.chen@asianux.com> wrot=
e:
> Need include "linux/console.h" when 'VT' and 'DUMMY_CONSOLE' enabled
> (e.g allmodconfig).
>
> The related error:
>   arch/c6x/kernel/setup.c: In function =E2=80=98setup_arch=E2=80=99:
>   arch/c6x/kernel/setup.c:442:2: error: =E2=80=98conswitchp=E2=80=99 =
undeclared (first use in this function)
>   arch/c6x/kernel/setup.c:442:2: note: each undeclared identifier is =
reported only once for each function it appears in
>   arch/c6x/kernel/setup.c:442:16: error: =E2=80=98dummy_con=E2=80=99 =
undeclared (first use in this function)

Ah, so you managed to obtain a c6x toolchain. There's none at
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/ yet :-(

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
