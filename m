From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 00/11] m68k: use asm-generic headers when possible
Date: Sun, 11 Nov 2012 11:30:25 +0100
Message-ID: <CAMuHMdXbwBLhryrcJ5Ln3uvBJL=_ZCYBErXyZzGznBirobU1kQ@mail.gmail.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Sender: linux-m68k-owner@vger.kernel.org
To: gerg@snapgear.com
Cc: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
