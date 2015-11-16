From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] m68knommu: Add missing initialization of max_pfn and {min,max}_low_pfn
Date: Mon, 16 Nov 2015 14:05:55 +0100
Message-ID: <CAMuHMdXt=UH_YoiRDRHCiHBCAsyyHenz2bDKkqUxF85tj2y6mw@mail.gmail.com>
References: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
	<1447585455-19671-5-git-send-email-geert@linux-m68k.org>
	<5649C987.3050600@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:35596 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbbKPNF4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2015 08:05:56 -0500
In-Reply-To: <5649C987.3050600@uclinux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@uclinux.org>
Cc: Sam Creasey <sammy@sammy.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Greg,

On Mon, Nov 16, 2015 at 1:18 PM, Greg Ungerer <gerg@uclinux.org> wrote:
>> --- a/arch/m68k/kernel/setup_no.c
>> +++ b/arch/m68k/kernel/setup_no.c
>> @@ -238,11 +238,14 @@ void __init setup_arch(char **cmdline_p)
>>          * Give all the memory to the bootmap allocator, tell it to put
>> the
>>          * boot mem_map at the start of memory.
>>          */
>> +       min_low_pfn = PFN_DOWN(memory_start);
>> +       max_pfn = max_low_pfn = PFN_DOWN(memory_end);
>> +
>>         bootmap_size = init_bootmem_node(
>>                         NODE_DATA(0),
>> -                       memory_start >> PAGE_SHIFT, /* map goes here */
>> -                       PAGE_OFFSET >> PAGE_SHIFT,      /* 0 on coldfire
>> */
>> -                       memory_end >> PAGE_SHIFT);
>> +                       min_low_pfn,            /* map goes here */
>> +                       PFN_DOWN(PAGE_OFFSET),  /* 0 on coldfire */
>> +                       max_pfn);
>>         /*
>>          * Free the usable memory, we have to make sure we do not free
>>          * the bootmem bitmap so we then reserve it after freeing it :-)
>
> Should this be changed to use init_bootmem() as per your changes
> in patch 3 ("m68k/mm: sun3 - Add missing initialization of max_pfn and
> {min,max}_low_pfn")? For the same reason?

No. PAGE_OFFSET = PAGE_OFFSET_RAW = CONFIG_RAMBASE.
As the comment says, this is zero on coldfire, but not on all m68knommu
platforms.

Upon closer look, this isn't even true on all Coldfire boards:

arch/m68k/configs/m5208evb_defconfig:CONFIG_RAMBASE=0x40000000

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
