From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 11:26:19 -0400
Message-ID: <94270f5c-1a28-f9d7-2b5a-eb874dc35398@mellanox.com>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop> <20160621141435.GB7381@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621141435.GB7381@worktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 6/21/2016 10:14 AM, Peter Zijlstra wrote:
> On Tue, Jun 21, 2016 at 04:04:08PM +0200, Peter Zijlstra wrote:
>>> I'm not sure who builds the toolchains, but tilepro is in upstream gcc/binutils/etc
>>> so should be easy enough to include.  There's also a cross-toolchain for x64 I put
>>> up a while ago [1] that you could grab if you wanted to try it.
>> I usually build my own set -- and just did. But tilepro was not
>> included. Lemme go do so.
> binutils-2_26-branch builds for tilepro-linux
> gcc-6-branch does _not_ build for tilepro-linux

I figured I would take a stab at diagnosing this myself, and it looks like the
toolchain build assumes that the kernel headers have already been installed
and therefore we have <asm/unistd.h> available.  This actually seems like
a reasonable prerequisite for building the toolchain.  I'm guessing you
don't?  Should you?  Or perhaps the compiler shouldn't make that assumption?
This has been true since gcc 4.x when tilepro support was first added.

In any case if you replace the #include <asm/unistd.h> with

#define __NR_FAST_cmpxchg    -1
#define __NR_FAST_atomic_update    -2
#define __NR_FAST_cmpxchg64    -3

that should also probably fix it, though I haven't tested it.  It probably
wouldn't be crazy to just put those #defines directly in tilepro's atomic.h,
since it's not like those fast system call numbers will ever change.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
