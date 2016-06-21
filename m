From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 09:58:28 +0200
Message-ID: <20160621075828.GL30154@twins.programming.kicks-ass.net>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5768E650.2080506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 21, 2016 at 08:01:36AM +0100, Sudip Mukherjee wrote:

> tilepro defconfig is failing while doing "make prepare" and bisect shows the
> first bad commit as:
> 
> 1af5de9af138 ("locking/atomic, arch/tile: Implement
> atomic{,64}_fetch_{add,sub,and,or,xor}()")
> 
> You can find today's build log at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/139112570
> 
> Please do let me know if i can help in any way to debug/solve this.

I cannot reproduce, I tried both tip/master (which carries the patch you
fingered) and next/master.

My tilepro build ends in a vmlinux with just a single warning.


root@ivb-ep:/usr/src/linux-2.6# rm -rf tile-defconfig/ tile-tilepro_defconfig/
root@ivb-ep:/usr/src/linux-2.6# ./build-arch-defconfig.sh tilepro
make[1]: Entering directory `/usr/src/linux-2.6/tile-tilepro_defconfig'
  HOSTCC  scripts/basic/fixdep
  GEN     ./Makefile
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
make[1]: Leaving directory `/usr/src/linux-2.6/tile-tilepro_defconfig'
../arch/tile/lib/cacheflush.c: In function 'finv_buffer_remote':
../arch/tile/lib/cacheflush.c:146:0: warning: ignoring #pragma unroll  [-Wunknown-pragmas]
 #pragma unroll 8
 
root@ivb-ep:/usr/src/linux-2.6# ls -la tile-tilepro_defconfig/vmlinux
vmlinux    vmlinux.o  
