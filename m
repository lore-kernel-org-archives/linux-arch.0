From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 14:42:47 +0200
Message-ID: <20160621124247.GM30921@twins.programming.kicks-ass.net>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
Sender: linux-next-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 21, 2016 at 08:08:29AM -0400, Chris Metcalf wrote:
> 
> On inspection, I note that the arch/tile/include/atomic_32.h header has
> 
> ATOMIC64_OP(and)
> ATOMIC64_OP(or)
> ATOMIC64_OP(xor)
> 
> but these should be ATOMIC64_OPS, plural.

Bugger, I'll go fix. Clearly nobody has tilepro toolchains :/

> Peter, what toolchain were you using for tilepro build testing? 

tilegx-linux-

> You need to have a tilepro toolchain (not tilegx) 

Ah, should I go use TARGET=tilepro-linux ?

> and build with ARCH=tilepro.

        tilepro)
                ARCH=tile
                CROSS_COMPILE=tilegx-linux-
                if [ "$CONFIG" == "defconfig" ] ; then
                        CONFIG=tilepro_defconfig
                fi
                ;;

So I suppose that too is wrong.
