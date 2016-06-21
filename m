From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 16:04:08 +0200
Message-ID: <20160621140408.GE3704@worktop>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 21, 2016 at 09:47:00AM -0400, Chris Metcalf wrote:
> On 6/21/2016 8:42 AM, Peter Zijlstra wrote:
> >On Tue, Jun 21, 2016 at 08:08:29AM -0400, Chris Metcalf wrote:
> >>You need to have a tilepro toolchain (not tilegx)
> >Ah, should I go use TARGET=tilepro-linux ?
> 
> Yes.

> I'm not sure who builds the toolchains, but tilepro is in upstream gcc/binutils/etc
> so should be easy enough to include.  There's also a cross-toolchain for x64 I put
> up a while ago [1] that you could grab if you wanted to try it.

I usually build my own set -- and just did. But tilepro was not
included. Lemme go do so.
