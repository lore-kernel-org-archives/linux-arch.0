Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 25 Feb 2005 13:43:22 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: Changing  update_mmu_cache()
Message-Id: <20050225134322.43274a9a.akpm@osdl.org>
In-Reply-To: <20050225201538.B27842@flint.arm.linux.org.uk>
References: <1109047997.5327.70.camel@gaston>
	<20050222090741.B16786@flint.arm.linux.org.uk>
	<20050222100858.27d05a86.davem@davemloft.net>
	<20050225201538.B27842@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King <rmk@arm.linux.org.uk> wrote:
>
> The item I was referring to was my flush_cache_page() changes from
>  January 11th (attached), posted to both linux-arch and lkml, and
>  previous to that in November some time, along with Linus' reply,
>  and my somewhat later reply.
> 
>  To be completely honest, because it has been such a long time since
>  the solution was first developed, I no longer even know if this
>  solution still works.  I also suspect, since I don't follow VM
>  progress, that my knowledge of the VM is now rather out of date.
> 
>  On the plus side, a couple of architecture people have come forward
>  to say that it could be beneficial to their architecture as well.
> 
>  I just find it extremely hard to do these architecture-wide changes
>  and get them past Linus with little or no help from any other
>  architecture people, especially when I'm then asked to prove that
>  the changes do not hurt other architectures.
> 
>  I'm not really expecting anyone to do lots of hard work on this
>  though... maybe just enough satisfaction feedback to from architecture
>  people to Linus will be sufficient.
> 
>  The problem I now face is that we're almost at 2.6.11, and its been
>  almost three months, so I think it's safe to assume that Linus will
>  have forgotten everything about this, and will probably hate the
>  patch next time around.  But maybe I'm underestimating Linus.

What does it do?  Just adds a pfn arg to flush_cache_page()?  We do that
sort of thing quite a lot, and I can help.

A typical approach would be to send me a patch for the core kernel, a patch
for x86 and a patch for arm.  Any additional best-effort per-architecture
patches would be appreciated as well, of course.

I test of four architectures and compile on seven.  arch maintainers will
develop, test and submit their bits and when all the ducks are lined up
I'll send it all off to Linus.

The main problem is that people are hacking on mm/* all the damn time, so
I have to live with massive reject storms during the changeover period. 
But that's my problem, not yours ;)
