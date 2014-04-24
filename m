From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 08/28] nios2: MMU Fault handling
Date: Thu, 24 Apr 2014 09:18:25 +0200
Message-ID: <CAMuHMdXMbGS6xFyW80Cv1xOSF=e76G16vVrboQUkgC7Q_mgZtw@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-6-git-send-email-lftan@altera.com>
	<20140422143036.GD15745@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140422143036.GD15745@arch.cereza>
Sender: linux-doc-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, LeyFoon Tan <lftan.linux@gmail.com>, cltang@codesourcery.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 22, 2014 at 4:30 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Apr 18, Ley Foon Tan wrote:
>> +
>> +bad_area_nosemaphore:
>> +     /* User mode accesses just cause a SIGSEGV */
>> +     if (user_mode(regs)) {
>
> I found that it's useful to add some printing here, just as ARM
> does. I carry this patch on my kernel:
>
> +               printk(KERN_INFO "%s: unhandled page fault (%d) at 0x%08lx, cause %ld\n",
> +                      current->comm, SIGSEGV, address, cause);
> +               show_regs(regs);
>
> Do you think we could do something like it? Maybe with a compile time option?

Can this easily be triggered from userspace? If yes, please use
pr_info_ratelimited().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
