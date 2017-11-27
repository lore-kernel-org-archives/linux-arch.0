Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40041 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdK0OaR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 09:30:17 -0500
MIME-Version: 1.0
In-Reply-To: <1055af0e8b98571b4461d6f899d043fe7f17408b.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1055af0e8b98571b4461d6f899d043fe7f17408b.1511785528.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Nov 2017 15:30:16 +0100
Message-ID: <CAK8P3a3nczwuuna8BGRQU11hhOFZMqGQqn9i_7D=Tzrc1PizFQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/35] nds32: Device tree support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171127143016.fUu8Qn35mZIXI9z1N92OVDtTIDVomQ62Izpcwk_uMX8@z>

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
