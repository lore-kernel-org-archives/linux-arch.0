From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 19:29:18 +0200
Message-ID: <20160621172918.GS30927@twins.programming.kicks-ass.net>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop>
 <20160621141435.GB7381@worktop>
 <94270f5c-1a28-f9d7-2b5a-eb874dc35398@mellanox.com>
 <20160621170607.GQ30154@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160621170607.GQ30154@twins.programming.kicks-ass.net>
Sender: linux-next-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 21, 2016 at 07:06:07PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 21, 2016 at 11:26:19AM -0400, Chris Metcalf wrote:
> > This has been true since gcc 4.x when tilepro support was first added.
> > 
> > In any case if you replace the #include <asm/unistd.h> with
> > 
> > #define __NR_FAST_cmpxchg    -1
> > #define __NR_FAST_atomic_update    -2
> > #define __NR_FAST_cmpxchg64    -3
> > 
> > that should also probably fix it, though I haven't tested it.  It probably
> > wouldn't be crazy to just put those #defines directly in tilepro's atomic.h,
> > since it's not like those fast system call numbers will ever change.

OK, I seem to have a tilepro-linux-gcc-6.1.1 build done. Lets see if I
can build me a kernel with it.
