Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:58000 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965162AbWIEFiQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 01:38:16 -0400
Subject: Re: [PATCH 3/9] actual generic PAGE_SIZE infrastructure
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1157434085.2413.22.camel@shinybook.infradead.org>
References: <20060901190805.C906A21A@localhost.localdomain>
	 <20060901190807.522EDD97@localhost.localdomain>
	 <1157434085.2413.22.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 22:37:49 -0700
Message-Id: <1157434669.2413.30.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-04 at 22:28 -0700, David Woodhouse wrote:
> No it isn't OK -- compiler.h isn't listed in include/linux/Kbuild, and
> hence doesn't exist at _all_ outside the kernel. And why are you doing
> it? The userspace version of your new asm-generic/page.h still doesn't
> do anything _but_ include compiler.h and align.h, so why do you feel the
> need to move those inclusions outside the ifdef?
> 
> Actually, I suppose it _is_ OK because asm-generic/page.h doesn't exist
> in userspace either, because it isn't listed in asm-generic/Kbuild. But
> I assume that was just an oversight on your part and you did mean to
> export it?
> 
> There's a similar problem with the new <linux/align.h> which you create,
> don't (and probably shouldn't) add to the Kbuild file, and then include
> from outside the confines of #ifdef __KERNEL__. 

The above can be summarised: In general, please remember to run 
'make headers_install' and check the sanity of the result if you're
making changes which are going to affect user-visible headers.

-- 
dwmw2

