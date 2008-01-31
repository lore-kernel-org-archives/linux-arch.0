Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:52628 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933147AbYAaQwb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 31 Jan 2008 11:52:31 -0500
Date: Thu, 31 Jan 2008 18:53:08 +0200
From: Adrian Bunk <bunk@kernel.org>
Subject: Re: asm-generic/tlb.h and check_pgt_cache()
Message-ID: <20080131165308.GF19700@cs181133002.pp.htv.fi>
References: <20080131125425.7e91b54d@dhcp-252-066.norway.atmel.com> <20080131130328.GA29209@cs181133002.pp.htv.fi> <47A1F7C5.3020108@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47A1F7C5.3020108@goop.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, David Brownell <david-b@pacbell.net>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>

On Thu, Jan 31, 2008 at 08:31:01AM -0800, Jeremy Fitzhardinge wrote:
> Adrian Bunk wrote:
>> On Thu, Jan 31, 2008 at 12:54:25PM +0100, Haavard Skinnemoen wrote:
>>   
>>> Hi,
>>>
>>> Commit a5a19c63f4e55e32dc0bc3d936d7f94793d8b380 from x86.git seems to
>>> have broken several architectures, including alpha (fixed by
>>> c18d1250c7425dddd2633ce4eaf03d5015e68a0f) and avr32 (not fixed yet).
>>>
>>> The problem seems to be that asm-generic/tlb.h references
>>> check_pgt_cache(), which is defined in asm/pgalloc.h on most
>>> architectures, so removing that include seems like the wrong thing to
>>> do. x86, however, defines it in asm/pgtable.h which is apparently
>>> included indirectly through other headers.
>>>
>>> One way to fix this would be to move the check_pgt_cache() definition
>>> over to asm/pgtable.h, but I suspect this would complicate things a lot
>>> on architectures that use quicklists since they need the QUICK_*
>>> definitions from pgalloc.h in order to implement check_pgt_cache. I
>>> have patches that make avr32 use quicklists as well, so I'm a bit
>>> hesitant to do this.
>>>
>>> Another way to fix it would be to include asm/pgalloc.h elsewhere, e.g.
>>> from asm/tlb.h right before including asm-generic/tlb.h. Or perhaps we
>>> should move check_pgt_cache() into asm/tlb.h on all architectures and
>>> include asm/pgalloc.h as needed?
>>>
>>> I don't know how many architectures are currently broken -- if it's
>>> only avr32, I can probably come up with a way to fix it on my own. But
>>> if there are others, I thought it might be a good idea to coordinate
>>> things.
>>>     
>>
>> At least blackfin and m32r suffer from the same compile breakage.
>>   
>
> Huh, interesting: avr32, sh, blackfin and m32r - all a similar class of  
> architectures.  Does this show a genealogical relationship?
>
> Anyway, sorry about the breakage.  There's a cyclic dependency between  
> asm-generic/tlb.h and asm/pgalloc.h, since __*_free_tlb (often) uses  
> tlb_remove_page().
>
> From the look of it:
> avr32 - no-op check_pgt_list
> sh - uses quicklist_*, and defines QUICK_* (unique among architectures)
> blackfin - how does this break? asm-blackfin/pgalloc.h is more or less no-op
> m32r - no-op check_pgt_list
> um - no-op check_pgt_list
>
> I'm guessing in blackfin's case, the breakage is some indirect  
> dependency on asm-blackfin/pgalloc.h via asm/tlb.h->asm-generic/tlb.h  
> rather than a specific check_pgt_list() problem.  Adrian, is that right?  
>...

blackfin is:

<--  snip  -->

...
  CC      mm/nommu.o
In file included from include2/asm/tlb.h:14,
                 from 
/home/bunk/linux/kernel-2.6/git/linux-2.6/mm/nommu.c:33:
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/asm-generic/tlb.h: In function 'tlb_finish_mmu':
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/asm-generic/tlb.h:91: error: implicit declaration of function 'check_pgt_cache'
make[2]: *** [mm/nommu.o] Error 1

<--  snip  -->

>    J

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

