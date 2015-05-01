From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] m68k: use for_each_sg()
Date: Fri, 1 May 2015 11:07:28 +0200
Message-ID: <CAMuHMdURwUnHtp2Q327m8y9Cqud=gyfkpUbTC_+7Y7v=nogLkw@mail.gmail.com>
References: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Mita-san,

On Fri, May 1, 2015 at 8:47 AM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> Since m68k doesn't select ARCH_HAS_SG_CHAIN, it is not necessary to
> use for_each_sg() in order to loop over each sg element.  But this can
> help find problems with drivers that do not properly initialize their
> sg tables when CONFIG_DEBUG_SG is enabled.
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-arch@vger.kernel.org

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Do you want me to queue this up for v4.2, or do you want to handle these
changes yourself, together with "[PATCH] scatterlist: enable sg chaining
for all architectures"?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
