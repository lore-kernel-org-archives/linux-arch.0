From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC][PATCH 00/31] implement atomic_fetch_$op
Date: Sat, 23 Apr 2016 09:59:08 +0800
Message-ID: <20160423015908.GA24989@wfg-t540p.sh.intel.com>
References: <20160422090413.393652501@infradead.org>
 <20160422094455.GO3430@twins.programming.kicks-ass.net>
 <20160422125656.GA15453@wfg-t540p.sh.intel.com>
 <20160422142303.GS3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31202 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbcDWB7X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Apr 2016 21:59:23 -0400
Content-Disposition: inline
In-Reply-To: <20160422142303.GS3430@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de

On Fri, Apr 22, 2016 at 04:23:03PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 22, 2016 at 08:56:56PM +0800, Fengguang Wu wrote:
> > I'll add arm64-defconfig to P1 list to improve its coverage.
> 
> Thanks; any more architectures missing from P1?

Good question! Just double checked and find s390 still missing.
All other supported archs have corresponding kconfigs in the P1 list:

alpha-defconfig
arm64-allnoconfig
arm64-defconfig
arm-allnoconfig
arm-at91_dt_defconfig
arm-efm32_defconfig
arm-exynos_defconfig
arm-multi_v5_defconfig
arm-multi_v7_defconfig
arm-shmobile_defconfig
arm-sunxi_defconfig
avr32-atngw100_defconfig
avr32-atstk1006_defconfig
blackfin-BF526-EZBRD_defconfig
blackfin-BF533-EZKIT_defconfig
blackfin-BF561-EZKIT-SMP_defconfig
blackfin-defconfig
blackfin-TCM-BF537_defconfig
cris-etrax-100lx_v2_defconfig
frv-defconfig
i386-alldefconfig
i386-allmodconfig
i386-allnoconfig
i386-allyesconfig
i386-defconfig
i386-tinyconfig
ia64-alldefconfig
ia64-allnoconfig
ia64-defconfig
m32r-m32104ut_defconfig
m32r-mappi3.smp_defconfig
m32r-opsput_defconfig
m32r-usrv_defconfig
m68k-m5475evb_defconfig
m68k-multi_defconfig
m68k-sun3_defconfig
microblaze-mmu_defconfig
microblaze-nommu_defconfig
mips-allnoconfig
mips-defconfig
mips-fuloong2e_defconfig
mips-jz4740
mips-txx9
mn10300-asb2364_defconfig
openrisc-or1ksim_defconfig
parisc-allnoconfig
parisc-b180_defconfig
parisc-c3000_defconfig
parisc-defconfig
powerpc-allnoconfig
powerpc-defconfig
powerpc-ppc64_defconfig
sh-allnoconfig
sh-defconfig
sh-rsk7269_defconfig
sh-sh7785lcr_32bit_defconfig
sh-titan_defconfig
sparc64-allnoconfig
sparc64-defconfig
sparc-defconfig
tile-tilegx_defconfig
um-i386_defconfig
um-x86_64_defconfig
x86_64-acpi-redef
x86_64-allmodconfig
x86_64-allyesdebian
x86_64-lkp
x86_64-nfsroot
x86_64-rhel
x86_64-rhel_gcov
xtensa-common_defconfig
xtensa-iss_defconfig

I'll add s390-default_defconfig to the above list.  Architecture
maintainers are welcome to suggest more suitable list of configs!

Thanks,
Fengguang
