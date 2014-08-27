From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATH V2 1/6] mm: Introduce a general RCU get_user_pages_fast.
Date: Wed, 27 Aug 2014 15:42:36 +0100
Message-ID: <20140827144235.GA10456@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-2-git-send-email-steve.capper@linaro.org>
 <20140827142801.GA13850@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:51180 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933698AbaH0Omr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Aug 2014 10:42:47 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so329919wes.23
        for <linux-arch@vger.kernel.org>; Wed, 27 Aug 2014 07:42:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827142801.GA13850@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>

On Wed, Aug 27, 2014 at 03:28:01PM +0100, Catalin Marinas wrote:
> On Thu, Aug 21, 2014 at 04:43:27PM +0100, Steve Capper wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 886db21..6a4d764 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
> >  config HAVE_MEMBLOCK_PHYS_MAP
> >  	boolean
> >  
> > +config HAVE_RCU_GUP
> > +	boolean
> 
> Minor detail, maybe HAVE_GENERIC_RCU_GUP to avoid confusion.

Yeah, that does look better, I'll amend the series accordingly.

> 
> Otherwise the patch looks fine to me.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Catalin.
