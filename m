From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/3] sparc: Increase portability of strncpy_from_user()
 implementation.
Date: Fri, 25 May 2012 01:25:00 +0900
Message-ID: <20120524162459.GA29888@linux-sh.org>
References: <20120523.233430.1084831063018998232.davem@davemloft.net>
 <CA+55aFw8jsrqipdKq9-EiA5a+Y-HKMQmpBsirs9ojfk1yUSxww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:34162 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757441Ab2EXQZJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 May 2012 12:25:09 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw8jsrqipdKq9-EiA5a+Y-HKMQmpBsirs9ojfk1yUSxww@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org

On Thu, May 24, 2012 at 09:04:27AM -0700, Linus Torvalds wrote:
> On Wed, May 23, 2012 at 8:34 PM, David Miller <davem@davemloft.net> wrote:
> > -
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > ? ? ? ?if (((long) dst | (long) src) & (sizeof(long) - 1))
> > ? ? ? ? ? ? ? ?goto byte_at_a_time;
> > +#endif
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > ?byte_at_a_time:
> > +#endif
> 
> Btw, this would have been much cleaner with something like
> 
>    #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>       #define IS_UNALIGNED(src,dst) 0
>    #else
>       #define IS_UNALIGNED(src,dst) (((long)(src) | (long)(dst)) &
> (sizeof(long) - 1))
>    #endif
> 
> and then just
> 
>      if (IS_UNALIGNED(src,dst))
>         goto byte_at_a_time;
> 
> in the source code. Those #ifdef's in the middle of the code really
> are horribly ugly, and are unnecessary.
> 
> Besides, some architecture may actually have ok unaligned loads, and
> just horrible unaligned stores, and it would be easier with that kind
> of abstraction.
> 
SH-4A processors fall under this. All of them support efficient 32-bit
unaligned loads but no stores at all or loads of any other size. Having
said that, the compiler isn't exactly brilliant at figuring out when to
emit them, so I'd probably still have to do it by hand.
