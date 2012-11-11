Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39976 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2KKKaZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 11 Nov 2012 05:30:25 -0500
MIME-Version: 1.0
In-Reply-To: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Date: Sun, 11 Nov 2012 11:30:25 +0100
Message-ID: <CAMuHMdXbwBLhryrcJ5Ln3uvBJL=_ZCYBErXyZzGznBirobU1kQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] m68k: use asm-generic headers when possible
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gerg@snapgear.com
Cc: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20121111103025.mF4zr08uVWiJKkO-91Gf5Pjj3fzfWI9eoTqDPQ2mKd0@z>

Hi Greg,

On Tue, Oct 30, 2012 at 7:24 AM,  <gerg@snapgear.com> wrote:
> Quite a few of the m68k asm headers are identical to the asm-generic
> versions. So switch to using them where ever we can.
>
> v2 is rebased on top of 3.7-rc3.
> v3 keep those in uapi/asm in uapi/asm (not moved to asm-generic)
>
> All defconfigs build. Run tested on ColdFire (with and without MMU) and on
> ArranyM.

Thanks!

Do you want me to queue these for 3.8, or take them yourselves?
In the latter case:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
>  arch/m68k/include/asm/Kbuild          |    4
>  arch/m68k/include/asm/hw_irq.h        |    6 -
>  arch/m68k/include/asm/shmparam.h      |    6 -
>  arch/m68k/include/asm/spinlock.h      |    6 -
>  arch/m68k/include/asm/termios.h       |   50 --------
>  arch/m68k/include/uapi/asm/Kbuild     |   17 +-
>  arch/m68k/include/uapi/asm/auxvec.h   |    4
>  arch/m68k/include/uapi/asm/msgbuf.h   |   31 -----
>  arch/m68k/include/uapi/asm/sembuf.h   |   25 ----
>  arch/m68k/include/uapi/asm/shmbuf.h   |   42 -------
>  arch/m68k/include/uapi/asm/socket.h   |   72 ------------
>  arch/m68k/include/uapi/asm/sockios.h  |   13 --
>  arch/m68k/include/uapi/asm/termbits.h |  201 ----------------------------------
>  arch/m68k/include/uapi/asm/termios.h  |   44 -------
>  14 files changed, 13 insertions(+), 508 deletions(-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
