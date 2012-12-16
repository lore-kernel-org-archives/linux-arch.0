From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: possible breakage with the >= 020 bfset et al bitops
Date: Sun, 16 Dec 2012 16:21:37 +0100
Message-ID: <CAMuHMdUsu-=K1rjPVAtZmj154KEjfQE1zHtO6FjVGLXii8zL+g@mail.gmail.com>
References: <20685.58177.575315.650990@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33766 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab2LPPVi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Dec 2012 10:21:38 -0500
In-Reply-To: <20685.58177.575315.650990@pilspetsen.it.uu.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-m68k@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>

On Sun, Dec 16, 2012 at 4:05 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> Side note: in arch/m68k/include/asm/bitops.h, shouldn't the bit
> number parameter 'nr' be 'unsigned int' for consistency with
> Documentation/atomic_ops.txt?  Surely nothing expects to be able
> to use negative bit numbers...?

Haven't check all archs, but:

m68k: int
x86: mix of signed and unsigned int
Documentation/atomic_ops.txt: unsigned long
asm-generic: int

So at least we're consistent with asm-generic...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
