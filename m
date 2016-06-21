From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 16:14:35 +0200
Message-ID: <20160621141435.GB7381@worktop>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45723 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbcFUOPR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 10:15:17 -0400
Content-Disposition: inline
In-Reply-To: <20160621140408.GE3704@worktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jun 21, 2016 at 04:04:08PM +0200, Peter Zijlstra wrote:
> > I'm not sure who builds the toolchains, but tilepro is in upstream gcc/binutils/etc
> > so should be easy enough to include.  There's also a cross-toolchain for x64 I put
> > up a while ago [1] that you could grab if you wanted to try it.
> 
> I usually build my own set -- and just did. But tilepro was not
> included. Lemme go do so.

binutils-2_26-branch builds for tilepro-linux
gcc-6-branch does _not_ build for tilepro-linux


---

/usr/local/src/buildall/tilepro/gcc/./gcc/xgcc -B/usr/local/src/buildall/tilepro/gcc/./gcc/ -B/opt/cross/tilepro-linux/bin/ -B/opt/cross/tilepro-linux/lib/ -isystem /opt/cross/tilepro-linux/include -isystem /opt/cross/tilepro-linux/sys-include    -g -O2 -O2  -g -O2 -DIN_GCC  -DCROSS_DIRECTORY_STRUCTURE  -W -Wall -Wno-narrowing -Wwrite-strings -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes -Wold-style-definition  -isystem ./include   -fPIC -g -DIN_LIBGCC2 -fbuilding-libgcc -fno-stack-protector -Dinhibit_libc  -fPIC -I. -I. -I../.././gcc -I/usr/local/src/gcc/libgcc -I/usr/local/src/gcc/libgcc/. -I/usr/local/src/gcc/libgcc/../gcc -I/usr/local/src/gcc/libgcc/../include  -DHAVE_CC_TLS  -o unwind-sjlj.o -MT unwind-sjlj.o -MD -MP -MF unwind-sjlj.dep -fexceptions -c /usr/local/src/gcc/libgcc
 /unwind-sjlj.c -fvisibility=hidden -DHIDE_EXPORTS
In file included from /usr/local/src/gcc/libgcc/config/tilepro/atomic.c:26:0:
/usr/local/src/gcc/libgcc/config/tilepro/atomic.h:98:24: fatal error: asm/unistd.h: No such file or directory
 #include <asm/unistd.h>
                        ^
compilation terminated.
mv -f softmpy.visT softmpy.vis
make[2]: *** [atomic.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/usr/local/src/buildall/tilepro/gcc/tilepro-linux/libgcc'
make[1]: *** [all-target-libgcc] Error 2
make[1]: Leaving directory `/usr/local/src/buildall/tilepro/gcc'
make: *** [all] Error 2
