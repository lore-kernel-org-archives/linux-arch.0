From: Michal Simek <michal.simek@petalogix.com>
Subject: Re: Microblaze noMMU/MMU merge
Date: Tue, 21 Apr 2009 11:46:06 +0200
Message-ID: <49ED95DE.5070804@petalogix.com>
References: <49ED79AB.10004@petalogix.com> <20090421082523.GA19864@uranus.ravnborg.org>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:47859 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbZDUJqJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2009 05:46:09 -0400
In-Reply-To: <20090421082523.GA19864@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel list <linux-kernel@vger.kernel.org>

Sam Ravnborg wrote:
> On Tue, Apr 21, 2009 at 09:45:47AM +0200, Michal Simek wrote:
>   
>> Hi All,
>>
>> I would like to say your opinion about putting together Microblaze MMU
>> arch to noMMU version.
>>
>> In C code will be #ifdef CONFIG_MMU ... #endif  or #ifndef.
>>
>> Here is proposal for headers. The similar style is used in m68k but I
>> would like to have the same code
>> for both archs in main file.
>>
>> #ifndef _ASM_MICROBLAZE_PAGE_H
>> #define _ASM_MICROBLAZE_PAGE_H
>>
>> code for noMMU and MMU which is the same for both.
>>
>> #ifdef __uClinux__
>> #include "page_no.h" -> noMMU specific
>> #else
>> #include "page_mm.h"-> MMU specific
>> #endif
>> #endif /* _ASM_MICROBLAZE_PAGE_H */
>>     
>
> Use dedicated header files for nommu / mmu only when it is really necessary.
>
> In headers that are _NOT_ exported you can use CONFIG_MMU to test
> if you are building for MMU or not - which is more readable.
>  
> The reason why you cannot use CONFIG_MMU in exported headers
> are that CONFIG_MMU is not valid in the userspace headers (not set/unset).
>
> In the optimal case you have no conditionals in the exported haders
> and then just use CONFIG_MMU all over.
>   
ok. I'll create first proposal and you can look if is ok or not.

Thanks.
Michal

> 	Sam
>
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
