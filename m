Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42069 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdK1Gzd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Nov 2017 01:55:33 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3nczwuuna8BGRQU11hhOFZMqGQqn9i_7D=Tzrc1PizFQ@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1055af0e8b98571b4461d6f899d043fe7f17408b.1511785528.git.green.hu@gmail.com>
 <CAK8P3a3nczwuuna8BGRQU11hhOFZMqGQqn9i_7D=Tzrc1PizFQ@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 28 Nov 2017 14:54:52 +0800
Message-ID: <CAEbi=3dtJLT_WzpepAx69WOzPc1gYNFMVML+NqA7JACiKBQvyw@mail.gmail.com>
Subject: Re: [PATCH v2 22/35] nds32: Device tree support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171128065452.7-lzQUkic0oGF7Wxh-PbxdO8wYm-doVX3KUCeQJu4pY@z>

2017-11-27 22:30 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> @@ -0,0 +1,55 @@
>> +/dts-v1/;
>> +/ {
>> +       compatible = "nds32 ae3xx";
>
> The compatible string doesn't seem to match the binding, it should always have
> vendor prefix.

Sorry I forgot to check this.
I will provide a document in bindings like
"Documentation/devicetree/bindings/nds32/andestech-boards".


>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +       interrupt-parent = <&intc>;
>> +
>> +       chosen {
>> +               bootargs = "earlycon console=ttyS0,38400n8 debug loglevel=7";
>> +               stdout-path = &serial0;
>> +       };
>
> I would drop the bootargs here, this is something that should be set by the
> bootloader and is up to the user.

Thanks
I will drop it in the next version patch.
