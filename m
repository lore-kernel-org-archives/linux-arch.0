From: Vladimir Murzin <murzin.v@gmail.com>
Subject: Re: [PATCH 3/6] get_unmapped_area checks for TASK_SIZE before
 MAP_FIXED on sparc32
Date: Wed, 9 May 2012 22:04:11 +0400
Message-ID: <20120509180409.GB3338@pinguin>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
 <1336488022-3723-4-git-send-email-murzin.v@gmail.com>
 <20120508162722.GA11624@merkur.ravnborg.org>
 <20120509080705.GA3516@pinguin>
 <20120509161834.GA13133@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45498 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2EISGf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2012 14:06:35 -0400
Received: by lbbgm6 with SMTP id gm6so430637lbb.19
        for <linux-arch@vger.kernel.org>; Wed, 09 May 2012 11:06:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120509161834.GA13133@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk

On Wed, May 09, 2012 at 06:18:34PM +0200, Sam Ravnborg wrote:
> On Wed, May 09, 2012 at 12:07:08PM +0400, Vladimir Murzin wrote:
> > On Tue, May 08, 2012 at 06:27:22PM +0200, Sam Ravnborg wrote:
> > > On Tue, May 08, 2012 at 06:40:19PM +0400, Vladimir Murzin wrote:
> > > > Move check for TASK_SIZE before MAP_FIXED in sparc32's arch_get_unmapped_area().
> > > 
> > > I would be good to copy relevant parts of your cover letter into each patch.
> > > when the patches are applied we looses the cover letter...
> > > 
> > 
> > In my opinion patches are quite trivial and self-explained. However,
> > if there are requests to update patches in this way I'll do it in v2. 
> 
> The cahngelog say this:
> 
>     Move check for TASK_SIZE before MAP_FIXED in sparc32's arch_get_unmapped_area().
> 
> And this is exactly what the code does.
> 
> But neither say anything WHY this is done.
> And if that WHY is not explained then the changelog is not good.
> 
> 	Sam

Ok. I'll update patches in v2.

Best wishes
Vladimir Murzin
