Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33603 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeARKZR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 05:25:17 -0500
MIME-Version: 1.0
In-Reply-To: <b19fe719ae9d56901fbf7670d9d7fd6aa035c355.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <b19fe719ae9d56901fbf7670d9d7fd6aa035c355.1515766253.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 11:25:15 +0100
Message-ID: <CAK8P3a0K-=FmcCvFqx7vE0BCaUEvoyvFKLxyGyj5M09B974dew@mail.gmail.com>
Subject: Re: [PATCH v6 15/36] nds32: Device specific operations
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180118102515.1DOpQqesa198o7wrz_uwjLm5Hiz1Pm4K22J0ZoiB05Y@z>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch introduces ioremap implementations.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
