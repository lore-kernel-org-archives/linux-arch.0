Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36762 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbcHLNup (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Aug 2016 09:50:45 -0400
Received: by mail-io0-f175.google.com with SMTP id b62so24942749iod.3
        for <linux-arch@vger.kernel.org>; Fri, 12 Aug 2016 06:50:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-Ek0NEPP9f2Jp+3ZxwRAP8rqPwwwRa56b2Bz4i=7h=Jw@mail.gmail.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160812123314.GX1041@n2100.armlinux.org.uk> <20160812231503.3e2e059b@roar.ozlabs.ibm.com>
 <CAKv+Gu-Ek0NEPP9f2Jp+3ZxwRAP8rqPwwwRa56b2Bz4i=7h=Jw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 12 Aug 2016 15:50:17 +0200
Message-ID: <CAKv+Gu_vmpg5ks4hPRYhJGEDBxy4oQW6wDGu1fjKSzEwW7y2uw@mail.gmail.com>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Alan Modra <amodra@gmail.com>, linux-kbuild@vger.kernel.org, Julian Brown <julian@codesourcery.com>, Michal Marek <mmarek@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20160812135017.PMLPKcQV5g62jc_S0-q3Lrpa_srP4e-Llc608pG5tpg@z>

On 12 August 2016 at 15:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 12 August 2016 at 15:15, Nicholas Piggin <npiggin@gmail.com> wrote:
>> On Fri, 12 Aug 2016 13:33:14 +0100
>> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>>
>>> On Fri, Aug 12, 2016 at 06:19:17PM +1000, Nicholas Piggin wrote:
>>> > This patch adds an option which defaults to "y" in cases where we
>>> > could possibly be running Cortex A8 and using Thumb2 instructions.
>>> > In reality the workaround might not be required at all for the kernel
>>> > if virtual instruction memory is linear in physical memory.
>>>
>>> Hmm.
>>>
>>> The main kernel image is guaranteed to be contiguous in physical memory
>>> for all sorts of reasons, so this really isn't a concern for the kernel
>>> itself.
>>
>> That's what it *seems* like. I wanted to be conservative because I don't
>> know the architecture nor have actually looked at the errata docs. You
>> can probably make stronger guarantees to avoid it. Perhaps enabling just
>> for modules would be workable.
>>
>>
>>> Modules, however, are a different matter, as they are mapped in using
>>> individual pages, and are most likely to be non-contiguous in physical
>>> memory.  The kernel's module linker knows nothing about this errata,
>>> so it'll generally just fix up the relocations in the most basic of
>>> ways.
>>>
>>> So, I think we should always use this --no-fix-cortex-a8 option where
>>> the linker supports it irrespective of whether we're running on a core
>>> needing this workaround, but we probably need to fix the kernel module
>>> linker to know about this.
>>
>> It looks like it would be a bit of work to go that route. The linker of
>> course would not give you relocations or stubs for the branches you
>> need them.
>>
>
> We could enable CONFIG_ARM_MODULE_PLTS in this case, and force a
> branch via a PLT entry if an affected instruction is encountered.
> However, this only covers branch instructions that are covered by
> relocations, so we'd still need to scan the module .text to look for
> affected instructions whose targets has been resolved at compile time.
>
> Running this

$ objdump -dr vmlinux |grep -A1 -E \\sb\.w |less

I get numerous instances of b.w that are not covered by any
relocations, so i assume that will be the case for modules as well.
