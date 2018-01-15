From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v6 02/36] openrisc: add ioremap_nocache declaration before
 include asm-generic/io.h and sync ioremap prototype with it.
Date: Mon, 15 Jan 2018 21:28:55 +0800
Message-ID: <CAEbi=3cSRMQm7wKS80Bd5brnBHpct9oRM1DgtyPPd_XPRgnZww@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <3e5ba33674a883b56e20b35ea9ae34990ea838c8.1515766253.git.green.hu@gmail.com>
 <20180115130728.GG13019@lianli.shorne-pla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39287 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752438AbeAON3h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 08:29:37 -0500
In-Reply-To: <20180115130728.GG13019@lianli.shorne-pla.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>

2018-01-15 21:07 GMT+08:00 Stafford Horne <shorne@gmail.com>:
> On Mon, Jan 15, 2018 at 01:53:10PM +0800, Greentime Hu wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> It will be built failed if commit id: d25ea659 is selected. This patch can fix this
>> build error.
>
> Hello,
>
> As I mentioned last time, can you you change this to not mention the commit id?
> The ID will probably change when this is actually committed.  You might want to
> do something like:
>
>  1. Move this commit before the ioremap_nocache change.  This is because we want
>  each commit to result in a buildable kernel.
>
>  2. The text here and other changes could read:
>
>  A future commit for the nds32 architecture bootstrap ("asm-generic/io.h: move
>  ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
>  will move the ioremap_nocache out of the CONFIG_MMU ifdef.  This means that
>  in order to suppress re-definition errors we need to setup #define's before
>  importing asm-generic/io.h.
>
>  Also, the change adds a prototype for ioremap where size is size_t so fix that
>  as well.
>
> I hope that helps. But for the change:
>
> Acked-by: Stafford Horne <shorne@gmail.com>
>

Hi, Stafford:

Thanks for the feedback.
I will move this commit before the ioremap_nocache change and use
these commit messages.
