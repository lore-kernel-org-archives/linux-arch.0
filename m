From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 22/35] nds32: Device tree support
Date: Mon, 27 Nov 2017 15:30:16 +0100
Message-ID: <CAK8P3a3nczwuuna8BGRQU11hhOFZMqGQqn9i_7D=Tzrc1PizFQ@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1055af0e8b98571b4461d6f899d043fe7f17408b.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1055af0e8b98571b4461d6f899d043fe7f17408b.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
> @@ -0,0 +1,55 @@
> +/dts-v1/;
> +/ {
> +       compatible = "nds32 ae3xx";

The compatible string doesn't seem to match the binding, it should always have
vendor prefix.

> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&intc>;
> +
> +       chosen {
> +               bootargs = "earlycon console=ttyS0,38400n8 debug loglevel=7";
> +               stdout-path = &serial0;
> +       };

I would drop the bootargs here, this is something that should be set by the
bootloader and is up to the user.

      Arnd
