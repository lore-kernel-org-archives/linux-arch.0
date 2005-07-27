Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 27 Jul 2005 15:42:43 -0700 (PDT)
Message-Id: <20050727.154243.131915305.davem@davemloft.net>
Subject: Re: sparsemem patches in -mm
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050621230024.4cd8d2fd.akpm@osdl.org>
References: <20050621021352.46fc3b81.akpm@osdl.org>
	<20050621.224645.78710941.davem@davemloft.net>
	<20050621230024.4cd8d2fd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, apw@shadowen.org, haveblue@us.ibm.com, matthew.e.tolentino@intel.com, bob.picco@hp.com
List-ID: <linux-arch.vger.kernel.org>

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 21 Jun 2005 23:00:24 -0700

[ Old email, something I want to bring closure to :-) ]

> "David S. Miller" <davem@davemloft.net> wrote:
> > The only thing that sticks out to me in this patch is that
> > sparc64 uses a field starting at bit 24 in page->flags to
> > determine the cpu which needs a D-cache flush for a page.
> 
> <looks>
> 
> That's a bit hacky.  Doesn't it conflict with the way in which we stuff the
> page's zone index into the top of page->flags?  I guess with a small number
> of zones and a smallish number of CPUs you got lucky.
> 
> It'd be safer to use bit 32.

I disagree.  In fact, using bit 24 is the current optimal place.

When page->flags is 64-bit, FLAGS_RESERVED is 32, which means
that all of this node, zone, section stuff will be stored in
the top 32-bits of the page->flags.  The highest defined flag
for the bottom 32-bits is PG_uncached which is 19.

This leaves bits 24-->31 free to sparc64 to use in this way.

It of course limits the number of cpus I support to 256
but that limitation also exists in the form of thread_info()->cpu
being a "u8" on sparc64, so not a big deal.
