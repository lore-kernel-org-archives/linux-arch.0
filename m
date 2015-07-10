From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] mm: cleaning per architecture MM hook header files
Date: Fri, 10 Jul 2015 14:47:18 +0200
Message-ID: <559FBED6.5080902@linux.vnet.ibm.com>
References: <55924508.9080101@synopsys.com> <1435745853-27535-1-git-send-email-ldufour@linux.vnet.ibm.com> <20150709160934.888dad2b24ce45957e65b139@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150709160934.888dad2b24ce45957e65b139@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, uclinux-h8-devel@lists.sourceforge.jp, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On 10/07/2015 01:09, Andrew Morton wrote:
> On Wed,  1 Jul 2015 12:17:33 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
>> The commit 2ae416b142b6 ("mm: new mm hook framework") introduced an empty
>> header file (mm-arch-hooks.h) for every architecture, even those which
>> doesn't need to define mm hooks.
>>
>> As suggested by Geert Uytterhoeven, this could be cleaned through the use
>> of a generic header file included via each per architecture
>> asm/include/Kbuild file.
>>
>> The PowerPC architecture is not impacted here since this architecture has
>> to defined the arch_remap MM hook.
> 
> So the way this works is that if an arch wants to override a hook, it
> will remove the "generic-y += mm-arch-hooks.h" and add
> arch/XXX/include/asm/mm-arch-hooks.h, yes?
>
> And the new arch/XXX/include/asm/mm-arch-hooks.h only needs to define
> the hook(s) which the arch wants to override?

Yes that's the way it should work.

> So nothing will ever be added to include/asm-generic/mm-arch-hooks.h?

This file is the fallback one when no hooks is defined. It is here for
the compiler happiness, and should be kept empty.

> Seems fair enough.
> 
> Oleg is angling to remove arch_remap(), so there won't be anything left
> in these files!  But there are plenty of ad-hoc things which *should*
> be moved over.

I'll try to move some hooks there as soon as I've so free time.

> 
>> Changes in V2:
>> --------------
>>  - Vineet Gupta reported that the Kbuild files should be kept sorted.
> 
> Yes, we do this to avoid patch collisions.  Everyone always adds stuff
> to the end of the list (Makefiles, #includes, etc etc), thus carefully
> maximizing the number of patch collisions :(

This makes sense.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
