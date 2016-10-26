Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:52373 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932987AbcJZUPC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2016 16:15:02 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/3] ARM: convert to generated system call tables
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
        <4337157.Eff9E2riVH@wuerfel>
        <20161021154856.GC1041@n2100.armlinux.org.uk>
        <24632117.YsmPs86ri6@wuerfel> <87eg382kv9.fsf@belgarion.home>
        <CAMuHMdVy_h6Uss9bwVK5hGD42bXeEBcBsBDwCpx_eYnT9r+=Lw@mail.gmail.com>
Date: Wed, 26 Oct 2016 22:14:46 +0200
In-Reply-To: <CAMuHMdVy_h6Uss9bwVK5hGD42bXeEBcBsBDwCpx_eYnT9r+=Lw@mail.gmail.com>
        (Geert Uytterhoeven's message of "Mon, 24 Oct 2016 11:25:03 +0200")
Message-ID: <87vawe27gp.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20161026201446.5PnPVShiyIzQVVio2Q27bRYK-u4a5arhg_ZNWZjJLCc@z>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Sat, Oct 22, 2016 at 10:23 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>> On Friday, October 21, 2016 4:48:56 PM CEST Russell King - ARM Linux wrote:
>>>> What's the point of the x32 mode?
>>>
>>> On x86, the motivation is faster code for most use cases that
>>> don't need a lot of memory, as the 64-bit opcodes have 16 registers
>>> rather than 8 in 32-bit mode but 32-bit pointers have lower
>>> cache footprint than 64-bit pointers.
>>
>> For completness, the second point of x32 AFAIU is the IP-relative addressing
>> which is not available in standard 32 bit mode, which improves PIC code. For
>> simple not algorithmic code (think Android HAL for example) with many shared
>> libraries, it's better in the Hardware Abstraction Layer Libraries, instead of
>> the push-to-stack and pop register.
>
> But that's not an advantage compared to full am64 mode, right?
Nope, the amd64 (that's what you have in mind with am64, not aarch64 right ?)
mode has the IP-relative has well, so x32 has no advantage over amd64 in this
area.

x32 over amd64 advantage is cache and memory footprint AFAICT, I don't see other
benefits. There doesn't seem to be any ISA differences, or I didn't really
notice in my daily system performance analysis job.

There was a nice presentation made by Peter Anvin at a Plumber conference, here
: http://linuxplumbersconf.org/2011/ocw/sessions/531

Cheers.

-- 
Robert
