Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268360AbUHKXrv@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:55486 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268326AbUHKXqU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 19:46:20 -0400
Date: Wed, 11 Aug 2004 16:46:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clear_user_highpage()
In-Reply-To: <20040811161537.5e24c2b6.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 11 Aug 2004, David S. Miller wrote:
> 
> During a kernel build, this is what tops the profiling charts
> for me on sparc64 currently.  This drives me crazy :-)

Think of it this way: if that function is your top function, then you're 
doing really really well. It's a good function to have at top.

> The PPC people used to zero out pages in the cpu idle loop
> and I'd definitely like to do something along those lines
> on sparc64 as well, I feel it would be extremely effective.

No. It sucks. It sucks so bad it's not funny.

It sucks because it eats CPU and memory bandwidth when it shouldn't be 
eaten. It's a total disaster on SMP, but it's bad on UP too.

It sucks because it does bad things to cache behaviour. Sure, you'll move 
the cost away from "clear_user_highpage", but the thing is, you will _not_ 
move it into the idle time. What you will do is to move it into some 
random time _after_ the idle time, when the idle thing has crapped all 
over your caches.

The thing is, you make your cache footprint per CPU _much_ bigger, and you 
spread it out a lot over time too, so you make it even worse.

The clearing will then be totally hidden in the profiles, because you will
have turned a nice and well-behaved "this is there the time goes" profile
into a mush of "we're taking cache misses at random times, and we don't
know why".

That, btw, is a _classic_ mistake in profiling. Move the work around so 
that it's not as visible any more.

In other words, don't do it. It's a mistake. It is optimizing the profile 
without actually optimizing what you want _done_. 

Btw, this is exactly what the totally brain-damaged slab stuff does. It 
takes away the peaks, but does so by having worse cache access patterns 
all around. 

Look at it this way:

 - it might be worth doing in big batches under some kind of user control, 
   when you really can _control_ that it happens at a good time.

   I _might_ buy into this argument. Make it a batch thing that really 
   screws the caches, but only does so very seldom, when the user asked
   for it.

 - but we aren't supposed to have that much memory free _anyway_, and 
   trying to keep it around on a separate list is horrible for 
   fragmentation.  So batching huge things up is likely not a good idea 
   either.

 - with caches growing larger, it's actually BETTER to clear the page at 
   usage time, because then the CPU that actually touches the page won't 
   have to bring in the page in from memory. We'll blow one page of cache 
   by clearing it, but we will blow it in a "good" way - hopefully with
   almost no memory traffic at all (ie the clear can be done as pure 
   invalidate cycles, no read-back into the CPU).

And the thing is, the background clearing will just get worse and worse.

In summary: it's a _good_ thing when you see a sharp peak in your 
profiles, and you can say "I know exactly what that peak is for, and it's 
doing exactly the work it should be doing and nothing else".

			Linus
