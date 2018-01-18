From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 13/36] nds32: IRQ handling
Date: Thu, 18 Jan 2018 11:22:42 +0100
Message-ID: <CAK8P3a3pXh+Eb+omQfLGUvn4ys047oPrK8qz_=t+9rGTMW+Hng@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <84ac81fe8ba6873e7665764d7912e79a900f0c54.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36814 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755323AbeARKWn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 05:22:43 -0500
In-Reply-To: <84ac81fe8ba6873e7665764d7912e79a900f0c54.1515766253.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch includes irq related functions and irqchip_init().
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
