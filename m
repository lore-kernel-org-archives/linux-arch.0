Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44904 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfBHVnl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 16:43:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so5641479qte.11
        for <linux-arch@vger.kernel.org>; Fri, 08 Feb 2019 13:43:40 -0800 (PST)
Date: Fri, 8 Feb 2019 16:43:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
Message-ID: <20190208164206-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com>
 <20190208154239.GI674@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208154239.GI674@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190208214337.i_2LZQUEdECTr9BGUxuTTVF-9nWrRycGKDMMtUOYOvI@z>

On Fri, Feb 08, 2019 at 04:42:39PM +0100, Borislav Petkov wrote:
> On Fri, Feb 08, 2019 at 01:02:53AM -0500, Michael S. Tsirkin wrote:
> > Use linux/mman.h to make sure we get all mmap flags we need.
> 
> Why, asm/mman.h is not enough or is this fixing a build issue or what is that
> patch supposed to address?

Coding style violation: if a linux/foo.h exists then it must
be included in preference to asm/foo.h

And the specific issue is that a follow-up patch moves code from
asm/mman.h to linux/mman.h so if any one was indirectly using
this header it will now miss the symbols that are being moved.





> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/x86/mm/mpx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
> > index de1851d15699..c805db6236b4 100644
> > --- a/arch/x86/mm/mpx.c
> > +++ b/arch/x86/mm/mpx.c
> > @@ -9,12 +9,12 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/mm_types.h>
> > +#include <linux/mman.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/sched/sysctl.h>
> >  
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> > -#include <asm/mman.h>
> >  #include <asm/mmu_context.h>
> >  #include <asm/mpx.h>
> >  #include <asm/processor.h>
> > -- 
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
