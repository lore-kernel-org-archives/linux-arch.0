From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 35/35] remove old ptemap.h includes
Date: Fri, 01 May 2009 08:02:50 -0700
Message-ID: <1241190170.29485.164.camel@nimitz>
References: <20090501144201.D31EF417@kernel>
	 <20090501144255.35FCBB72@kernel>  <20090501145917.GB7618@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:47038 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756436AbZEAPCy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 May 2009 11:02:54 -0400
In-Reply-To: <20090501145917.GB7618@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2009-05-01 at 16:59 +0200, Ingo Molnar wrote:
> * Dave Hansen <dave@linux.vnet.ibm.com> wrote:
> > +++
> linux-2.6.git-dave/arch/alpha/include/asm/pgtable.h       2009-04-30
> 15:11:13.000000000 -0700
> > @@ -317,7 +317,7 @@ extern inline pte_t * pte_offset_kernel(
> >       return ret;
> >  }
> >  
> > -#inclue <asm/ptemap.h>
> > +#include <asm/ptemap.h>
> 
> that typo fix should be backmerged to earlier in the series i guess.

Whoops.  Got it now, thanks.

-- Dave
