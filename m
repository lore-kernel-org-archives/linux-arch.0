From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
Date: Mon, 19 Nov 2018 09:08:06 +0100
Message-ID: <CAMuHMdUKPo6Lu0CtWERYkQTKSATqq0QVit-Awcn1O2EsS22iKQ@mail.gmail.com>
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org> <0b9aaa2f-9eda-82f1-8d52-b537a8c0c190@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0b9aaa2f-9eda-82f1-8d52-b537a8c0c190@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: firoz.khan@linaro.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 19, 2018 at 6:26 AM Rob Landley <rob@landley.net> wrote:
> On 11/13/18 10:32 PM, Firoz Khan wrote:
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>
> I applied the patch in https://github.com/landley/mkroot and the result booted
> under qemu-system-sh4, seems to work fine. Network's fine, it can read a block
> device, etc.
>
> Acked-and-or-tested-by: Rob Landley <rob@landley.net>
>
> I assume that this is just git du jour and not your patch:
>
> WARNING: CPU: 0 PID: 1 at mm/slub.c:2448 ___slab_alloc.constprop.34+0x196/0x288

https://patchwork.kernel.org/patch/10549883/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
