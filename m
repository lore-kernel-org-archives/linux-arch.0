Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:17641 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbYDKTBT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2008 15:01:19 -0400
Received: by wr-out-0506.google.com with SMTP id c48so680681wra.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2008 12:01:18 -0700 (PDT)
Subject: Re: [PATCHv2 1/8] kernel: add common infrastructure for unaligned
	access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <20080411180928.GA9137@flint.arm.linux.org.uk>
References: <1207856646.22001.25.camel@brick>
	 <1207872394.22001.69.camel@brick>
	 <20080411180928.GA9137@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 11 Apr 2008 12:01:21 -0700
Message-ID: <1207940481.22001.100.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080411190121.1hYFIH3TXAZ-pBez65FLqWi2ex_2qe1TnPJkId3hWy4@z>

On Fri, 2008-04-11 at 19:09 +0100, Russell King wrote:
> On Thu, Apr 10, 2008 at 05:06:34PM -0700, Harvey Harrison wrote:
> > +#define __get_unaligned_cpu(ptr) ({			\
> > +	const void *__gu_p = (ptr);			\
> > +	typeof(*(ptr)) __val;				\
> > +	switch (sizeof(*(ptr))) {			\
> > +	case 1:						\
> > +		__val = *(const u8 *)__gu_p;		\
> > +		break;					\
> > +	case 2:						\
> > +		__val = __get_unaligned_cpu16(__gu_p);	\
> > +		break;					\
> > +	case 4:						\
> > +		__val = __get_unaligned_cpu32(__gu_p);	\
> > +		break;					\
> > +	case 8:						\
> > +		__val = __get_unaligned_cpu64(__gu_p);	\
> > +		break;					\
> > +	default:					\
> > +		BUILD_BUG_ON(1);			\
> > +		break;					\
> > +	};						\
> > +	__val; })
> 
> This won't work - on ARM we used to use this style, but it fails in
> some corner case, so we ended up switching to using GCC's
> __builtin_choose_expr() instead.
> 
> Such a corner case:
> 
> static unsigned long foo(const unsigned long *ptr)
> {
> 	return __get_unaligned_cpu(ptr);
> }
> 
> This results in '__val' being declared as const, and therefore the
> compiler errors out in the switch statement since the code tries to
> assign to a const '__val'.

OK, will respin the set, I think I have a better way of doing it anyway.

Not that it matters, but wouldn't that be a gcc bug, for it to preserve
const on __val, wouldn't that have to be:

const unsigned long * const ptr

Just curious.

Thanks.

Harvey


