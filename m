Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26882 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeEGArc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 May 2018 20:47:32 -0400
MIME-Version: 1.0
In-Reply-To: <20180420204104.6e22b136@roar.ozlabs.ibm.com>
References: <20180420073414.23169-1-npiggin@gmail.com> <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com> <20180420204104.6e22b136@roar.ozlabs.ibm.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 7 May 2018 09:46:43 +0900
Message-ID: <CAK7LNASvOwam=AhN11sUKvBbtJbBzQULqs8kRV2KRS45jbSLcQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arch <linux-arch@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Message-ID: <20180507004643.dVCgcbDEAp6t1K1EYek7OuY1GsdW5l3xbJB6dwHghzc@z>

Hi Nicholas,

2018-04-20 19:41 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
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
>
> Thanks,
> Nick



I applied this series because I want it to be more tested in linux-next.


Some requests:

 - Could you provide information to replace '[ppc32 numbers here]'?
   (or just remove it)

 - V2 is welcome if you have code improvement.
   (I thought so from your comments)

Thanks.


-- 
Best Regards
Masahiro Yamada
