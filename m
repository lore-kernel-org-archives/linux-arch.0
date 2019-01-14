From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header files
Date: Mon, 14 Jan 2019 13:29:49 +0530
Message-ID: <CALxhOnjZrZksPypSvewsF1d=94sxAQNx7smKJLiXP364jzCZFg@mail.gmail.com>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org> <20190110235428.GA10016@roeck-us.net>
 <CAMuHMdXuo1wMvwx-FZB6uBJahSSbqrmnxEAfepnhAS_odQkHDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXuo1wMvwx-FZB6uBJahSSbqrmnxEAfepnhAS_odQkHDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Geert, Rob, Guenter,

Thanks for the mail.

On Sat, 12 Jan 2019 at 14:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jan 11, 2019 at 1:37 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
> > Have you tested this patch ?

Yes.

>
> All these series depend on "scripts: unify system call table generation
> scripts"
> https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Yes, This patch is depends on:
https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

FYI, I'm going to abandon this patch series (for other 9 architecture
also) and planning
to come up with asm-generic support along with this one. That can be
single patch
series. And everything can be landed in upstream in the same time.

Rob,

> I tested it at one point, but not recently. (It was before 4.20 came out...)

The one you tested is the previous version this patch series (w/o
unified script)

Thanks
Firoz
