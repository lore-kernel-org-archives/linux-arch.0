Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35101 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeARLIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 06:08:18 -0500
MIME-Version: 1.0
In-Reply-To: <de648d211061a16c85ae0321625c51343ce5e5ce.1515766198.git.green.hu@gmail.com>
References: <cover.1515766198.git.green.hu@gmail.com> <de648d211061a16c85ae0321625c51343ce5e5ce.1515766198.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 12:08:17 +0100
Message-ID: <CAK8P3a1RQxBNGiVD11BuL5kUx+fn0QcA02j0HVPnMQ2j3WmMQQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] clocksource/drivers/atcpit100: VDSO support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Rick Chen <rickchen36@gmail.com>, Rick Chen <rick@andestech.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180118110817.C3NqweXt7bMiHuIZMnGUmH9c8zukFhIiIPNKBsv9FSc@z>

On Mon, Jan 15, 2018 at 6:57 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Rick Chen <rickchen36@gmail.com>
>
> VDSO needs real-time cycle count to ensure the time accuracy.
> Unlike others, nds32 architecture does not define clock source,
> hence VDSO needs atcpit100 offering real-time cycle count
> to derive the correct time.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Rick Chen <rickchen36@gmail.com>
> Signed-off-by: Greentime Hu <green.hu@gmail.com>

I'm a bit puzzled by this patch, can you explain how the vdso actually
manages to access the clock hardware? It looks like you make the
physical address and the register offset available to user space, but
how does it end up accessing it?

      Arnd
