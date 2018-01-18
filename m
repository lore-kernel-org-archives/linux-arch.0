Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46409 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754765AbeARKBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 05:01:38 -0500
MIME-Version: 1.0
In-Reply-To: <d36e188c167392994a84c8f52ef0dab90b93ed8d.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <d36e188c167392994a84c8f52ef0dab90b93ed8d.1515766253.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 11:01:36 +0100
Message-ID: <CAK8P3a3RsJUnXeyghS4B-BqN5xppk8CHZbmhT=UdrvKLEARq2A@mail.gmail.com>
Subject: Re: [PATCH v6 05/36] nds32: Assembly macros and definitions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180118100136.GYEbKST4yKDLfKDfpzoeThOOmwfALbJ4EiziAlXY8go@z>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch includes assembly macros, bit field definitions used in .S
> files across arch/nds32/.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
