Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:45665 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbaEALoY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 May 2014 07:44:24 -0400
Received: by mail-we0-f182.google.com with SMTP id u57so3033153wes.27
        for <linux-arch@vger.kernel.org>; Thu, 01 May 2014 04:44:23 -0700 (PDT)
Date: Thu, 1 May 2014 12:44:08 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [RFC PATCH V4 3/7] arm: mm: Enable HAVE_RCU_TABLE_FREE logic
Message-ID: <20140501114408.GA4501@linaro.org>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-4-git-send-email-steve.capper@linaro.org>
 <20140501111120.GF22316@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140501111120.GF22316@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Message-ID: <20140501114408.ypHj0MmiVy8QNbvIO_7T7Xgn2Ss-Fh6xp9P4PITh-eg@z>

On Thu, May 01, 2014 at 12:11:21PM +0100, Catalin Marinas wrote:
> On Fri, Mar 28, 2014 at 03:01:28PM +0000, Steve Capper wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 1594945..7d5340d 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -58,6 +58,7 @@ config ARM
> >  	select HAVE_PERF_EVENTS
> >  	select HAVE_PERF_REGS
> >  	select HAVE_PERF_USER_STACK_DUMP
> > +	select HAVE_RCU_TABLE_FREE if SMP
> 
> You select this if (SMP && CPU_V7). On ARMv6 SMP systems we use IPI for
> TLB maintenance already.

Thanks, I'll add that to the next series.
-- 
Steve
> 
> -- 
> Catalin
