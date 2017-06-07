From: Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH 08/17] dts: include documentation for the RISC-V interrupt controllers
Date: Wed, 7 Jun 2017 13:31:55 -0700
Message-ID: <CAMgXwTg9f_i00GFiAfkb7zCzyxjGvRbd9Hrt2gbQwwLb4-F6Yg@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-9-palmer@dabbelt.com> <CAMuHMdWYNVvh4hqDrqYNe2oyVHkCbH15VfWTWHaBCeRAaf6O4g@mail.gmail.com>
 <20170607101343.GC29370@leverpostej> <CAMgXwTiz0jXgSw=veJ3O7xzVgm==YisZZLWpZFH7aJMXV4j7qA@mail.gmail.com>
 <CAL_JsqKtFVdSkW+4Ph2nPpcepoNWiYYCcsd0nnXReFshdrhwSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:36645 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdFGUb4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 16:31:56 -0400
Received: by mail-yb0-f170.google.com with SMTP id o9so5423166yba.3
        for <linux-arch@vger.kernel.org>; Wed, 07 Jun 2017 13:31:56 -0700 (PDT)
In-Reply-To: <CAL_JsqKtFVdSkW+4Ph2nPpcepoNWiYYCcsd0nnXReFshdrhwSg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Albert Ou <albert@sifive.com>, patches@groups.riscv.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

I've reread the relevant sections now, and you are correct. We should
remove the address-cells from the PLIC's dts.

On Wed, Jun 7, 2017 at 12:57 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Jun 7, 2017 at 1:57 PM, Wesley Terpstra <wesley@sifive.com> wrote:
>> On Wed, Jun 7, 2017 at 3:13 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> > +RISC-V Hart-Level Interrupt Controller (HLIC)
>>>> > +---------------------------------------------
>
> [...]
>
>>>> > +       plic: interrupt-controller@c000000 {
>>>> > +               #address-cells = <0>;
>>>
>>> This can go, given you don't have sub-nodes, nor a #size-cells property.
>>
>> The device-tree-specification seems to indicate that this is mandatory
>> for an interrupt-controller. Or have I understood this wrongly? When
>> you use interrupts-extended, doesn't it use the address-cells of the
>> interrupt controller? We should add that size-cells = 0, though.
>
> It's only needed if you have an interrupt-map property AIUI.
> #size-cells should never be needed (unless you have child nodes of
> this one).
>
> Rob
