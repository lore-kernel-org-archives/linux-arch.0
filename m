From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH] remove ibcs2/PER_SVR4 from SET_PERSONALITY
Date: Wed, 15 Oct 2008 15:32:25 +0300
Message-ID: <20081015123225.GC10917@cs181140183.pp.htv.fi>
References: <1224072352.16990.18.camel@localhost> <20081015121445.GB21756@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:56705 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbYJOMc2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Oct 2008 08:32:28 -0400
Content-Disposition: inline
In-Reply-To: <20081015121445.GB21756@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org, akpm@linux-foundation.org

On Wed, Oct 15, 2008 at 01:14:45PM +0100, Russell King wrote:
> On Wed, Oct 15, 2008 at 02:05:52PM +0200, Martin Schwidefsky wrote:
> > Greetings,
> > this is the ibcs2/PER_SVR4 removal patch against today git tree. Nobody
> > complained so I guess it is ready for prime time.
> 
> Not yet.
> 
> > The question I have is
> > by which path should it go upstream? I can certainly create a branch on
> > git390 for it but that would be rather unusual since normally only s390
> > related patches go over that repository. Andrew, can you take care of
> > it ?
> 
> You're not fixing up all users of SET_PERSONALITY, so this patch is
> build-breaking.  For example, you're missing the SET_PERSONALITY macro
> in arch/arm/include/asm/elf.h.
> 
> Please use 'grep -r' or 'git grep' to find all definitions of this
> macro so you can verify if you've hit all of them.

His original patch [1] did also fix the ARM one.

Looks more like this got accidentally lost when rediffing his patch due 
to a conflict with your "[ARM] Improve non-executable support" commit?

> Russell King

cu
Adrian

[1] http://marc.info/?l=linux-arch&m=122306678613448&w=2

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
