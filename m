Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43658 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeDTUIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2018 16:08:49 -0400
MIME-Version: 1.0
In-Reply-To: <20180420204104.6e22b136@roar.ozlabs.ibm.com>
References: <20180420073414.23169-1-npiggin@gmail.com> <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com> <20180420204104.6e22b136@roar.ozlabs.ibm.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 20 Apr 2018 22:08:27 +0200
Message-ID: <CA+7wUsyWu3eweWjwfFoS5FD5yb3OxjLV4-XyErcNA4fJGPCf8Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arch@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, linux-kbuild@vger.kernel.org
Message-ID: <20180420200827.OzItMrZ5cX6k7ViTaHm78BfwJkFj0e1sl5WLgi7zoPk@z>

On Fri, Apr 20, 2018 at 12:41 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Fri, 20 Apr 2018 12:00:49 +0200
> Mathieu Malaterre <malat@debian.org> wrote:
>
>> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> > This requires further changes to linker script to KEEP some tables
>> > and wildcard compiler generated sections into the right place. This
>> > includes pp32 modifications from Christophe Leroy.
>> >
>> > When compiling powernv_defconfig with this option:
>> >
>> > text       data      bss       dec        filename
>> > 11827621   4810490   1341080   17979191   vmlinux
>> > 11752437   4598858   1338776   17690071   vmlinux.dcde
>> >
>> > Resulting kernel is almost 400kB smaller (and still boots).
>> >
>> > [ppc32 numbers here]
>>
>> ^^^
>>
>> Do you want somebody else to provide those numbers ?
>
> If you have a booting kernel, yes some more numbers would be good.

I've used /boot/config-4.15.0-2-powerpc from my current debian
package. Rebuild master with and without option, boot ok, load/unload
module ok.

$ size nick/vmlinux.with*
   text    data     bss     dec     hex filename
7386425 2364370 1425432 11176227 aa8923 nick/vmlinux.with
7461457 2475122 1428064 11364643 ad6923 nick/vmlinux.without

This is not clear why with option the size of kernel is slightly bigger:

$ du -sk nick/vmlinux.with*
124488 nick/vmlinux.with
124004 nick/vmlinux.without


> Thanks,
> Nick
