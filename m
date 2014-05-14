From: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v4 0/4] metag,parisc: Stack limit patches
Date: Wed, 14 May 2014 21:22:52 +0200
Message-ID: <5373C28C.3040106@gmx.de>
References: <1400071968-21581-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400071968-21581-1-git-send-email-james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi James,

On 05/14/2014 02:52 PM, James Hogan wrote:
> Patch 1 is a metag bug fix for v3.15 & stable.
> 
> Patch 2 depends on patch 1, and makes the stack limit configurable.
> Helge: I don't object if you want to take this patch yourself since it
> was originally yours, so long as it goes after patch 1 (which I'll try
> and get into v3.15-rc6).

Thanks for cleaning it up!
I'd really prefer if you could push the whole series through your tree.
That way you can easily ensure the correct sequence.
IMHO, it would be nice if all four patches would still go into 3.15, esp.
since it affects our platforms (parisc & metag) only.

Helge

> 
> Patch 3 depends on patch 1, and removes the RLIMIT_STACK default value
> for metag. I'll take this through metag tree for v3.16.
> 
> Patch 4 depends on patch 3 and the corresponding parisc patch and
> removes the ability to override the default hard RLIMIT_STACK. Depending
> on when the parisc patch reaches mainline I'll try and get this in for
> v3.16.
> 
> Helge Deller (1):
>   parisc,metag: Do not hardcode maximum userspace stack size
> 
> James Hogan (3):
>   metag: Reduce maximum stack size to 256MB
>   metag: Remove _STK_LIM_MAX override
>   asm-generic: remove _STK_LIM_MAX
> 
>  arch/metag/include/asm/processor.h     |  2 ++
>  arch/metag/include/uapi/asm/Kbuild     |  2 +-
>  arch/metag/include/uapi/asm/resource.h |  7 -------
>  arch/parisc/include/asm/processor.h    |  5 +++++
>  arch/parisc/kernel/sys_parisc.c        |  6 +++---
>  fs/exec.c                              |  6 +++---
>  include/asm-generic/resource.h         |  2 +-
>  include/uapi/asm-generic/resource.h    |  7 -------
>  mm/Kconfig                             | 15 +++++++++++++++
>  9 files changed, 30 insertions(+), 22 deletions(-)
>  delete mode 100644 arch/metag/include/uapi/asm/resource.h
> 
> Cc: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
> Cc: "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Cc: John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>
> Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
