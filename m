From: Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH 1/3] Reduce get_current() to the asm-generic
 implementation where possible
Date: Wed, 19 May 2010 16:21:12 +1000
Message-ID: <20100519062112.GQ2516@laptop>
References: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
 <20100518194753.GA2318@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40521 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab0ESGVQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2010 02:21:16 -0400
Content-Disposition: inline
In-Reply-To: <20100518194753.GA2318@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: David Howells <dhowells@redhat.com>, oleg@redhat.com, linux-arch@vger.kernel.org

On Tue, May 18, 2010 at 08:47:53PM +0100, Jamie Lokier wrote:
> David Howells wrote:
> > Reduce get_current() to the asm-generic implementation where
> > possible to remove duplicate cases.
> > 
> > Note that this will lose the const attribute on get_current() for ARM and
> > MN10300.  This will be added back in a later patch for all architectures.
> [...]
> > -static inline struct task_struct *get_current(void) __attribute_const__;
> > -
> > -static inline struct task_struct *get_current(void)
> > -{
> > -	return current_thread_info()->task;
> > -}
> 
> 
> Last time I looked, GCC didn't seem to do anything useful with the
> const attribute on inline functions.  I.e. no elimination of duplicate calls.

Probably child functions should be marked const as well.

 
> (It does eliminate them when out-of-line.)
> 
> So there is probably no point putting the const attribute back, unless
> GCC has changed at this.
> 
> It might be able to eliminate some duplicates if the asm inside
> current_thread_info() is consty enough, and duplicate ->task
> dereferences might be eliminated by strict-aliasing in some cases.

I don't think it hurts to give more information even if the compiler
does not use it yet.
