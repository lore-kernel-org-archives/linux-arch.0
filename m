From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 04/37] earlycon: add reg-offset to physical address
 before mapping
Date: Thu, 15 Feb 2018 09:40:49 -0600
Message-ID: <CAL_JsqJteT1P2GJGdesTsz=PuXU1qxiyhtKLURkGwV9sSQ7XZQ@mail.gmail.com>
References: <cover.1518505384.git.greentime@andestech.com> <968497070242f849dd70ab1fa81635451f8fda7f.1518505384.git.greentime@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <968497070242f849dd70ab1fa81635451f8fda7f.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, deanbo422@gmail.com, devicetree@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, ren_guo@c-sky.com, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 13, 2018 at 3:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> It will get the wrong virtual address because port->mapbase is not added
> the correct reg-offset yet. We have to update it before earlycon_map()
> is called
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: stable@vger.kernel.org
> Fixes: 088da2a17619 ("of: earlycon: Initialize port fields from DT
> properties")

This should get applied now rather than sit in numerous revisions of
this series for nds32.

Acked-by: Rob Herring <robh@kernel.org>

Greg, can you apply?

Rob
