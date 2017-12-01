From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 35/35] dt-bindings: timer: Add andestech atcpit100
 timer binding doc
Date: Fri, 1 Dec 2017 13:19:25 +0100
Message-ID: <CACRpkdYuo88qeEznKxVojYofV4YTGu6AOgan-2GPYS9qZCVxZA@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <60f23e7fcff11f16b0bca4753a39d098849eeac3.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60f23e7fcff11f16b0bca4753a39d098849eeac3.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, deanbo422@gmail.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Rick Chen <rickchen36@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:

> From: Rick Chen <rickchen36@gmail.com>
>
> Add a document to describe Andestech atcpit100 timer and
> binding information.
>
> Signed-off-by: Rick Chen <rickchen36@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Greentime Hu <green.hu@gmail.com>

Thanks for submitting this interesting architecture!

(...)

> +Required properties:
> +- compatible   : Should be "andestech,atcpit100"
> +- reg          : Address and length of the register set
> +- interrupts   : Reference to the timer interrupt
> +- clocks : a clock to provide the tick rate for "andestech,atcpit100"
> +- clock-names : should be "PCLK" for the external tick timer.

This text seem wrong. PCLK is the internal timer, right? "PCLK" is
"peripheral clock" (I hope) and that comes from the bus.

Consider also adding an optional "EXTCLK" already now, since it is
evident from the driver that this is also supported.

Yours,
Linus Walleij
