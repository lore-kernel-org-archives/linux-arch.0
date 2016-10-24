Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33637 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757230AbcJXJ33 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2016 05:29:29 -0400
MIME-Version: 1.0
In-Reply-To: <3851270.xZRcP9hae0@wuerfel>
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk> <13702107.LdHY4HTXyY@wuerfel>
 <20161019155325.GR1041@n2100.armlinux.org.uk> <3851270.xZRcP9hae0@wuerfel>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Oct 2016 11:29:28 +0200
Message-ID: <CAMuHMdWjBFRm2rvCC8LBVG0CLk7MtmMLZJ7Ca72v6Nm=b5aD9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: convert to generated system call tables
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>
Message-ID: <20161024092928.69ZiaKpA41knxuz-AgUT0ZgI84ux8lqrctdUtTDg5gM@z>

Hi Arnd,

On Fri, Oct 21, 2016 at 3:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> - a lot of the less common architectures just don't get updated
>   in time, out of 22 architectures that don't use asm-generic/unistd.h,
>   only 12 have pwritev2 in linux-next, and only three have pkey_mprotect

Should everybody implement pkey_mprotect?

"x86, pkeys: remove cruft from never-merged syscalls" and

arch/powerpc/include/asm/unistd.h:#define __IGNORE_pkey_mprotect

aren't that reassuring...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
