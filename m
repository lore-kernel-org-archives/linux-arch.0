From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 26/31] nds32: Build infrastructure
Date: Thu, 16 Nov 2017 18:03:25 +0800
Message-ID: <CAEbi=3d=SNk5gWB=JAB3babeyJn1A=GcDK3RChgKMJC+VA3rZw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <7278eca76456b412e02d9baa5dc164e83199cbab.1510118606.git.green.hu@gmail.com>
 <CAK8P3a11Mk3XcmP5Ecbv55TuNRjrrp_43GX8hPDfdLh6JMHE=g@mail.gmail.com> <CAMuHMdXTNQZSX71E4ds2OeR-5pPKmARqtP0BQbaWzKhpvieC7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:50045 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbdKPKEH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Nov 2017 05:04:07 -0500
In-Reply-To: <CAMuHMdXTNQZSX71E4ds2OeR-5pPKmARqtP0BQbaWzKhpvieC7w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

2017-11-13 18:45 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Wed, Nov 8, 2017 at 11:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> --- /dev/null
>>> +++ b/arch/nds32/Kconfig
>>> @@ -0,0 +1,107 @@
>>> +#
>>> +# For a description of the syntax of this configuration file,
>>> +# see Documentation/kbuild/kconfig-language.txt.
>>> +#
>>> +
>>> +config NDS32
>>> +        def_bool y
>>> +       select ARCH_HAS_RAW_COPY_USER
>>> +       select ARCH_WANT_FRAME_POINTERS if FTRACE
>>> +       select ARCH_WANT_IPC_PARSE_VERSION
>>> +       select CLKSRC_MMIO
>>> +       select CLONE_BACKWARDS
>>> +       select TIMER_OF
>>> +       select FRAME_POINTER
>>> +       select GENERIC_ATOMIC64
>>> +       select GENERIC_CPU_DEVICES
>>> +       select GENERIC_CLOCKEVENTS
>>> +       select GENERIC_IOMAP
>>> +       select GENERIC_IRQ_CHIP
>>> +       select GENERIC_IRQ_PROBE
>>> +       select GENERIC_IRQ_SHOW
>>> +       select GENERIC_STRNCPY_FROM_USER
>>> +       select GENERIC_STRNLEN_USER
>>> +       select GENERIC_TIME_VSYSCALL
>>> +       select HAVE_ARCH_TRACEHOOK
>>> +       select HAVE_GENERIC_IOMAP
>>
>> You normally don't want HAVE_GENERIC_IOMAP, at least unless the CPU
>> has special instructions to trigger PCI I/O port access.
>
> GENERIC_IOMAP or HAVE_GENERIC_IOMAP?
>
> The latter doesn't even exist, except in
> Documentation/kbuild/kconfig-language.txt, so it cannot be selected.

Thanks.
I will remove HAVE_GENERIC_IOMAP in the next version patch.

> Given the checks for __NDS32_EB__, NDS32 can be either big or little endian,
> so you should have (excatly one of) CPU_BIG_ENDIAN or CPU_LITTLE_ENDIAN set.

Thanks.
I will check if we need this config or not and update in the next version patch.
