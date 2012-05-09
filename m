From: Vladimir Murzin <murzin.v@gmail.com>
Subject: Re: [PATCH 3/6] get_unmapped_area checks for TASK_SIZE before
 MAP_FIXED on sparc32
Date: Wed, 9 May 2012 12:07:08 +0400
Message-ID: <20120509080705.GA3516@pinguin>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
 <1336488022-3723-4-git-send-email-murzin.v@gmail.com>
 <20120508162722.GA11624@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51563 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757757Ab2EIIJb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2012 04:09:31 -0400
Received: by lahd3 with SMTP id d3so1664364lah.19
        for <linux-arch@vger.kernel.org>; Wed, 09 May 2012 01:09:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120508162722.GA11624@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk

On Tue, May 08, 2012 at 06:27:22PM +0200, Sam Ravnborg wrote:
> On Tue, May 08, 2012 at 06:40:19PM +0400, Vladimir Murzin wrote:
> > Move check for TASK_SIZE before MAP_FIXED in sparc32's arch_get_unmapped_area().
> 
> I would be good to copy relevant parts of your cover letter into each patch.
> when the patches are applied we looses the cover letter...
> 

In my opinion patches are quite trivial and self-explained. However,
if there are requests to update patches in this way I'll do it in v2. 

> 
> > 
> > Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> > ---
> >  arch/sparc/kernel/sys_sparc_32.c |    9 +++++----
> >  1 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
> > index 42b282f..7bf30de 100644
> > --- a/arch/sparc/kernel/sys_sparc_32.c
> > +++ b/arch/sparc/kernel/sys_sparc_32.c
> > @@ -40,6 +40,11 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
> >  {
> >  	struct vm_area_struct * vmm;
> >  
> > +	if (len > TASK_SIZE - PAGE_SIZE)
> > +		return -ENOMEM;
> This is not the same as the check it replaces - what is going on here?
> 

It shouldn't be the same. The a_g_u_a serves to help arches customize
get_unmapped_are depends on their specific like cache aliasing,
etc. Checking for length (in this case) could be also customized.

> 	Sam

Best wishes
Vladimir Murzin
