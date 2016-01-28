From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 27/31] Add debugger entry points for M68K
Date: Thu, 28 Jan 2016 21:40:03 +0100
Message-ID: <CAMuHMdWQ9Ja+yDS6DRqQ7D-tHYRgAr-VXw-ERxpJw-Gi9dPjoA@mail.gmail.com>
References: <1454010458-29525-1-git-send-email-jeffmerkey@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1454010458-29525-1-git-send-email-jeffmerkey@gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Jeffrey Merkey <jeffmerkey@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux.mdb@gmail.com, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Jeffrey,

CC linux-arch

On Thu, Jan 28, 2016 at 8:47 PM, Jeffrey Merkey <jeffmerkey@gmail.com> wrote:
> This patch series adds an export which can be set by system debuggers to
> direct the hard lockup and soft lockup detector to trigger a breakpoint
> exception and enter a debugger if one is active.  It is assumed that if
> someone sets this variable, then an breakpoint handler of some sort will
> be actively loaded or registered via the notify die handler chain.
>
> This addition is extremely useful for debugging hard and soft lockups
> real time and quickly from a console debugger.

As there's no cover letter, I'm giving my (mostly general) comments in a
reply to this patch.

> Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
> ---
>  arch/m68k/include/asm/kdebug.h | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 arch/m68k/include/asm/kdebug.h
>
> diff --git a/arch/m68k/include/asm/kdebug.h b/arch/m68k/include/asm/kdebug.h
> new file mode 100644
> index 0000000..5d09de1
> --- /dev/null
> +++ b/arch/m68k/include/asm/kdebug.h
> @@ -0,0 +1,4 @@
> +
> +static inline void arch_breakpoint(void)
> +{
> +}

No include guards in the newly added header files?

This new file will conflict with arch/m68k/include/asm/Kbuild, which has:

    generic-y += kdebug.h

What about putting the dummy arch_breakpoint() in include/asm-generic/kdebug.h
instead, like

    #ifndef arch_breakpoint
    static inline void arch_breakpoint(void)
    {
    }
    #endif

Architectures providing their own version have to #define arch_breakpoint.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
