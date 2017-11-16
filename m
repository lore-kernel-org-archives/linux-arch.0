From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 26/31] nds32: Build infrastructure
Date: Thu, 16 Nov 2017 11:25:45 +0100
Message-ID: <CAK8P3a3DBbCeqvQeS4sdG8tzAvvgk72EDA7oDfeQDL1-7bnzkg@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <7278eca76456b412e02d9baa5dc164e83199cbab.1510118606.git.green.hu@gmail.com>
 <CAK8P3a11Mk3XcmP5Ecbv55TuNRjrrp_43GX8hPDfdLh6JMHE=g@mail.gmail.com>
 <CAMuHMdXTNQZSX71E4ds2OeR-5pPKmARqtP0BQbaWzKhpvieC7w@mail.gmail.com> <CAEbi=3d=SNk5gWB=JAB3babeyJn1A=GcDK3RChgKMJC+VA3rZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:56258 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758899AbdKPKZr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Nov 2017 05:25:47 -0500
In-Reply-To: <CAEbi=3d=SNk5gWB=JAB3babeyJn1A=GcDK3RChgKMJC+VA3rZw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

On Thu, Nov 16, 2017 at 11:03 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2017-11-13 18:45 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>> Given the checks for __NDS32_EB__, NDS32 can be either big or little endian,
>> so you should have (excatly one of) CPU_BIG_ENDIAN or CPU_LITTLE_ENDIAN set.
>
> Thanks.
> I will check if we need this config or not and update in the next version patch.

I think we have one architecture in the kernel that determines endianess from
the way that the toolchain is built. What all the others do it to have a Kconfig
option, at least CONFIG_CPU_BIG_ENDIAN that is used to pass -mbig-endian
or -mlittle-endian to the compiler. You should do it that way so you can use
any toolchain with any kernel configuration.

       Arnd
