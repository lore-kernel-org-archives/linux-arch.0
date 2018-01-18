Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45816 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755251AbeARK2t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 05:28:49 -0500
MIME-Version: 1.0
In-Reply-To: <4a602db0a58cc858515c3c669d5ac34c567b061c.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <4a602db0a58cc858515c3c669d5ac34c567b061c.1515766253.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 11:28:47 +0100
Message-ID: <CAK8P3a0GQDrj+7kc4YB1_ZC1vCWmMtSiYeKsNir_27FvY50Kmg@mail.gmail.com>
Subject: Re: [PATCH v6 19/36] nds32: VDSO support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180118102847.rYGSqrgxVYcCEkdyxoZSdUpHD1nv6SStyuVW3mhBvK0@z>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch adds VDSO support. The VDSO code is currently used for
> sys_rt_sigreturn() and optimised gettimeofday() (using the SoC timer counter).
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
