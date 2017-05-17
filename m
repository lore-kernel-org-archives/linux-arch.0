Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:32953 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbdEQOWa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2017 10:22:30 -0400
MIME-Version: 1.0
In-Reply-To: <CAOesGMh3UxHPYQ7SDG7+NODuT5TnP_i23ru0ZRR-rOYxbOGe_g@mail.gmail.com>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk> <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
 <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
 <CAL_JsqJCjwvvta0n7dNpyVZkK5hp25fYO78q_pQZzUAPRDq+-w@mail.gmail.com> <CAOesGMh3UxHPYQ7SDG7+NODuT5TnP_i23ru0ZRR-rOYxbOGe_g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 May 2017 16:22:28 +0200
Message-ID: <CAMuHMdVQPB57dckRDjjLLocE4=0J4fQZQux9LJoV6xzZW16eKA@mail.gmail.com>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate directory
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand <frowand.list@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Message-ID: <20170517142228.qhHXZG6BAYiXtddH7Q8WTN-dRbe9p-qgPSeDlapYQk4@z>

Hi Olof,

On Mon, May 15, 2017 at 6:09 PM, Olof Johansson <olof@lixom.net> wrote:
>> The only other comment I would have is at some point, we're going to
>> have overlays that aren't tied to any arch. Where are we going to put
>> those? Maybe they are tied to some vendor which tends to have most
>> stuff in $arch and we just continue this band-aid. Or we define some
>> common location. I bring this up now only because both could use that
>> location.
>
> Those are good questions. What kind of common overlays are you
> anticipating? Things like fragments describing connectors, etc?

I'm mostly using overlays to describe custom test hardware that
is connection to expansion connectors on standard development boards.
These fall into one of two classes:
  1. Overlays enabling an on-SoC device and configuring access to it from
     an expansion connector,
  2. Overlays describing hardware connected to a device from class1.

Class 1 overlays are SoC and board-specific, so they belong in e.g.
arch/arm/boot/dts/.
Class 2 overlays are more universal (depending on what they extend; Pantelis'
connectors work may help here), so they can be shared between architectures.

Other people may have other use cases.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
