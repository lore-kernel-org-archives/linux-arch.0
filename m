From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 20:50:48 +0200
Message-ID: <20160621185048.GR30909@twins.programming.kicks-ass.net>
References: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop>
 <20160621141435.GB7381@worktop>
 <94270f5c-1a28-f9d7-2b5a-eb874dc35398@mellanox.com>
 <20160621170607.GQ30154@twins.programming.kicks-ass.net>
 <20160621172918.GS30927@twins.programming.kicks-ass.net>
 <20160621182844.GT30927@twins.programming.kicks-ass.net>
 <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
Sender: linux-next-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 21, 2016 at 02:36:34PM -0400, Chris Metcalf wrote:
> On 6/21/2016 2:28 PM, Peter Zijlstra wrote:

> >I had to s/__atomic_fetch/__atomic32_fetch/ to avoid a namespace clash
> >with the builtin C11 atomic primitives.
> >
> >You want me to rename them all to regain consistent naming?
> 
> Yes, it's probably the right thing to do.  All the internal routines with "atomic32"
> or "atomic64" I assume you mean?

Yep, after this patch we have a few __atomic_ and a few __atomic32_,
which is rather unbecoming. Lemme go convert them all to __atomic32_.

> So what's your build process for the cross tools, by the way?  I'm assuming
> you're not doing a total bootstrap cross-tool build since you'd need minimal
> kernel headers (linux/errno.h or whatever) in that case.  I assume you're using
> the host headers to build the cross tool?
> 
> So I'm a little confused how the other kernel headers are working out for you,
> e.g. <arch/icache.h> is referenced when building the tilegx libgcc.

I've no idea; I use this thing:

  git://git.infradead.org/users/segher/buildall.git

Although I've got some local modifications, none are to the actual
toolchain building part (although I suppose I should send segher a
patch).

I have binutils-gdb.git and gcc.bit checkouts and point the buildall
config to that (both are on latest stable branches binutils-2_26-branch
and gcc-6-branch resp.). And I point the kernel path to my current
hacked up tree.

I don't really rebuild the entire toolchains often, mostly only when I
really need a new GCC or its getting really old (like I used 5.3.0 for a
long while).
