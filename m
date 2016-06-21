From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 08:08:29 -0400
Message-ID: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5768E650.2080506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 6/21/2016 3:01 AM, Sudip Mukherjee wrote:
> On Tuesday 21 June 2016 06:46 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20160620:
>
> tilepro defconfig is failing while doing "make prepare" and bisect shows the first bad commit as:
>
> 1af5de9af138 ("locking/atomic, arch/tile: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()")
>
> You can find today's build log at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/139112570

On inspection, I note that the arch/tile/include/atomic_32.h header has

ATOMIC64_OP(and)
ATOMIC64_OP(or)
ATOMIC64_OP(xor)

but these should be ATOMIC64_OPS, plural.

Peter, what toolchain were you using for tilepro build testing?  You need to have a tilepro toolchain (not tilegx) and build with ARCH=tilepro.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
