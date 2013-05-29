From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: blackfin: kernel: memory overflow, 'namebuf' length
 need be more than 256
Date: Wed, 29 May 2013 13:30:05 +0200
Message-ID: <CAMuHMdV17ZuCAdZq4vc+Av=r4b02OvjiEeRPxkq=7VrO3C7MSA@mail.gmail.com>
References: <51A5CDB4.9000204@asianux.com>
	<51A5D346.4010007@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:57442 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965500Ab3E2LaG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 07:30:06 -0400
In-Reply-To: <51A5D346.4010007@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Richard Kuo <rkuo@codeaurora.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Wed, May 29, 2013 at 12:07 PM, Chen Gang <gang.chen@asianux.com> wrote:
> The 'name' length in decode_address() may be 255, after call d_path()
> successfully.
>
> So for decode_address(), the input 'buf' need be more than 256, or may
> memory overflow.
>
> For simply thinking of, use 'namebuf[512]' instead of 'namebuf[150]'
> which will pass to decode_address() as input 'buf'.
>
> Also better use macro instead of hard code number when processing
> symbols work.
>
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/blackfin/kernel/trace.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/blackfin/kernel/trace.c b/arch/blackfin/kernel/trace.c
> index c36efa0..4fecd3e 100644
> --- a/arch/blackfin/kernel/trace.c
> +++ b/arch/blackfin/kernel/trace.c
> @@ -37,7 +37,7 @@ void decode_address(char *buf, unsigned long address)
>         const char *symname;
>         char *modname;
>         char *delim = ":";
> -       char namebuf[128];
> +       char namebuf[KSYM_NAME_LEN];
>  #endif
>
>         buf += sprintf(buf, "<0x%08lx> ", address);
> @@ -845,7 +845,7 @@ void dump_bfin_mem(struct pt_regs *fp)
>
>  void show_regs(struct pt_regs *fp)
>  {
> -       char buf[150];
> +       char buf[512];

This will increase stack usage a lot. And this function calls decode_address(),
which allocates another buffer on the stack.

However, as this is in debug code which is (never?) called concurrently, both
buffers can be made static?

>         struct irqaction *action;
>         unsigned int i;
>         unsigned long flags = 0;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
