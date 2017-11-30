From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 25/35] nds32: Build infrastructure
Date: Thu, 30 Nov 2017 08:52:59 +0100
Message-ID: <CAMuHMdWXe-1=-98V=AcUzu-MiEaAqPQi2HZ6OTS=8sXY3XNhjw@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <5e1be9ebc591c6de79b75f726a5a38b2564eaa92.1511785528.git.green.hu@gmail.com>
 <CAK8P3a1GuH2tgtC5t834-PNeUVYQxreD7seZH8sjraZFtRUWKw@mail.gmail.com>
 <CAEbi=3c=hTCcUOPs+Fc10srzTFsB4MnVxgcFydz12-jH0ZXjog@mail.gmail.com>
 <CAK8P3a0kvt52UTtEmE+tWHZuH_rmgTxP7+CiD9Ddwe2cJLwXTQ@mail.gmail.com>
 <CAMuHMdViO=+-kGdXFPSW+9PsPbf3sUa5xdaJ_1C-cX2vE1G35Q@mail.gmail.com>
 <CAK8P3a3yk7ww+LdQdL+wgz2wYrzXLSsj1PTdfK-qx013jdg4SQ@mail.gmail.com>
 <CAEbi=3cc8e__DnFKmTSMm9xQMx7CGu+1v3e55w8UekwnTTkw5Q@mail.gmail.com>
 <CAK8P3a2d2_jxXehE3xP_G9Tzp6jP4hFmS4CJkh=6bePLEDcdGw@mail.gmail.com>
 <CAEbi=3fmXP=n_tS+-TSFhdht2G=VHOzVCVU=SRy4A6Ym_GToUQ@mail.gmail.com>
 <CAK8P3a3-CexhRkJB7_8TGShuDQP8w=myhkoB8-7ax3my96PrMw@mail.gmail.com> <CAEbi=3cTkbt9i7XPXMnY1D6qtbebDW1x8sFVsgqhq-nApAx5mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33075 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbdK3HxB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Nov 2017 02:53:01 -0500
In-Reply-To: <CAEbi=3cTkbt9i7XPXMnY1D6qtbebDW1x8sFVsgqhq-nApAx5mA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

On Thu, Nov 30, 2017 at 6:48 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2017-11-30 4:27 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Wed, Nov 29, 2017 at 3:10 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>> 2017-11-29 19:57 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>>> On Wed, Nov 29, 2017 at 12:39 PM, Greentime Hu <green.hu@gmail.com> wrote:
> I think I can use this name "CPU_V3" for all nds32 v3 compatible cpu.
> It will be implemented like this.
>
> config HWZOL
>         bool "hardware zero overhead loop support"
>         depends on CPU_D10 || CPU_D15
>         default n
>         help
>           A set of Zero-Overhead Loop mechanism is provided to reduce the
>           instruction fetch and execution overhead of loop-control instructions.
>           It will save 3 registers($LB, $LC, $LE) for context saving if say Y.
>           You don't need to save these registers if you can make sure your user
>           program doesn't use these registers.
>
>           If unsure, say N.
>
> config CPU_CACHE_NONALIASING
>         bool "Non-aliasing cache"
>         depends on !CPU_N10 && !CPU_D10
>         default n
>         help
>           If this CPU is using VIPT data cache and its cache way size is larger
>           than page size, say N. If it is using PIPT data cache, say Y.
>
>           If unsure, say N.

I still think it will be easier to revert the logic, and have
CPU_CACHE_ALIASING.

Gr{oetje,eeting}s,

                        Geert
