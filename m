From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: Microblaze noMMU/MMU merge
Date: Tue, 21 Apr 2009 21:06:28 +1000
Message-ID: <49EDA8B4.1090808@snapgear.com>
References: <49ED79AB.10004@petalogix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rex.securecomputing.com ([203.24.151.4]:57941 "EHLO
	cyberguard.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752754AbZDULGb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2009 07:06:31 -0400
In-Reply-To: <49ED79AB.10004@petalogix.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michal.simek@petalogix.com
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel list <linux-kernel@vger.kernel.org>

Hi Michal,

Michal Simek wrote:
> I would like to say your opinion about putting together Microblaze MMU
> arch to noMMU version.
> 
> In C code will be #ifdef CONFIG_MMU ... #endif  or #ifndef.
> 
> Here is proposal for headers. The similar style is used in m68k but I
> would like to have the same code
> for both archs in main file.
> 
> #ifndef _ASM_MICROBLAZE_PAGE_H
> #define _ASM_MICROBLAZE_PAGE_H
> 
> code for noMMU and MMU which is the same for both.
> 
> #ifdef __uClinux__
> #include "page_no.h" -> noMMU specific
> #else
> #include "page_mm.h"-> MMU specific
> #endif
> #endif /* _ASM_MICROBLAZE_PAGE_H */

Breaking up the files that way is really only temporary. They will
eventually all be merged back to single files (I have probably
reworked about 60% of them so far). There ends up being very little
difference.

I would keep single files if you could.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
