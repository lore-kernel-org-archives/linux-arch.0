From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 14:36:34 -0400
Message-ID: <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop> <20160621141435.GB7381@worktop>
 <94270f5c-1a28-f9d7-2b5a-eb874dc35398@mellanox.com>
 <20160621170607.GQ30154@twins.programming.kicks-ass.net>
 <20160621172918.GS30927@twins.programming.kicks-ass.net>
 <20160621182844.GT30927@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160621182844.GT30927@twins.programming.kicks-ass.net>
Sender: linux-next-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 6/21/2016 2:28 PM, Peter Zijlstra wrote:
> On Tue, Jun 21, 2016 at 07:29:18PM +0200, Peter Zijlstra wrote:
>
>> >OK, I seem to have a tilepro-linux-gcc-6.1.1 build done. Lets see if I
>> >can build me a kernel with it.
> The below, much larger than desired, patch seems to make it go again.
>
> I had to s/__atomic_fetch/__atomic32_fetch/ to avoid a namespace clash
> with the builtin C11 atomic primitives.
>
> You want me to rename them all to regain consistent naming?

Yes, it's probably the right thing to do.  All the internal routines with "atomic32"
or "atomic64" I assume you mean?

So what's your build process for the cross tools, by the way?  I'm assuming
you're not doing a total bootstrap cross-tool build since you'd need minimal
kernel headers (linux/errno.h or whatever) in that case.  I assume you're using
the host headers to build the cross tool?

So I'm a little confused how the other kernel headers are working out for you,
e.g. <arch/icache.h> is referenced when building the tilegx libgcc.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
