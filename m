From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: linux-next: Tree for Jun 21
Date: Wed, 22 Jun 2016 16:40:39 -0400
Message-ID: <a4b8b020-abe0-0e81-c0e5-d8b99aec84fe@mellanox.com>
References: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop> <20160621141435.GB7381@worktop>
 <94270f5c-1a28-f9d7-2b5a-eb874dc35398@mellanox.com>
 <20160621170607.GQ30154@twins.programming.kicks-ass.net>
 <20160621172918.GS30927@twins.programming.kicks-ass.net>
 <20160621182844.GT30927@twins.programming.kicks-ass.net>
 <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
 <20160622091649.GB30154@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0070.outbound.protection.outlook.com ([157.56.112.70]:43520
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750904AbcFVUk5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jun 2016 16:40:57 -0400
In-Reply-To: <20160622091649.GB30154@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 6/22/2016 5:16 AM, Peter Zijlstra wrote:
> On Tue, Jun 21, 2016 at 02:36:34PM -0400, Chris Metcalf wrote:
>> >On 6/21/2016 2:28 PM, Peter Zijlstra wrote:
>>> > >On Tue, Jun 21, 2016 at 07:29:18PM +0200, Peter Zijlstra wrote:
>>> > >
>>>>> > >>>OK, I seem to have a tilepro-linux-gcc-6.1.1 build done. Lets see if I
>>>>> > >>>can build me a kernel with it.
>>> > >The below, much larger than desired, patch seems to make it go again.
>>> > >
>>> > >I had to s/__atomic_fetch/__atomic32_fetch/ to avoid a namespace clash
>>> > >with the builtin C11 atomic primitives.
>>> > >
>>> > >You want me to rename them all to regain consistent naming?
>> >
>> >Yes, it's probably the right thing to do.  All the internal routines with "atomic32"
>> >or "atomic64" I assume you mean?
> Something like so then?
>
> ---
>   arch/tile/include/asm/atomic_32.h |   24 ++++++++++++------------
>   arch/tile/include/asm/futex.h     |   14 +++++++-------
>   arch/tile/lib/atomic_32.c         |   16 ++++++++--------
>   arch/tile/lib/atomic_asm_32.S     |   21 +++++++++++++--------
>   4 files changed, 40 insertions(+), 35 deletions(-)

Yes, that looks good.  Thanks!

Acked-by: Chris Metcalf <cmetcalf@mellanox.com>

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
