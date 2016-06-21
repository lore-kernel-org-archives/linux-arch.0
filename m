From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 10:20:39 -0400
Message-ID: <2c751e92-9dcb-a42c-7ecb-764d3974c1e4@mellanox.com>
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

That's unexpected.  I'll pass this over to our compiler folks. Thanks!

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
