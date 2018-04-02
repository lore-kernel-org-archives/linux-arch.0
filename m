From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] arch: remove obsolete architecture ports
Date: Mon, 2 Apr 2018 09:17:30 +0200
Message-ID: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, Hirokazu Takata <takata@linux-m32r.org>, Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>, Bryan Wu <cooloney@gmail.com>, Chris Metcalf <chris.d.metcalf@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org

Hi Linus,

The series is rather long and conflicts in trivial ways with lots
of subsystem trees. You probably want to pull it either really
early in the merge window or really late.

     Arnd

----
The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/arch-removal

for you to fetch changes up to dd3b8c329aa270027fba61a02a12600972dc3983:

  MAINTAINERS: UNICORE32: Change email account (2018-03-26 15:57:29 +0200)

----------------------------------------------------------------
arch: remove obsolete architecture ports

This removes the entire architecture code for blackfin, cris, frv, m32r,
metag, mn10300, score, and tile, including the associated device drivers.

I have been working with the (former) maintainers for each one to ensure
that my interpretation was right and the code is definitely unused in
mainline kernels. Many had fond memories of working on the respective
ports to start with and getting them included in upstream, but also saw
no point in keeping the port alive without any users.

In the end, it seems that while the eight architectures are extremely
different, they all suffered the same fate: There was one company
in charge of an SoC line, a CPU microarchitecture and a software
ecosystem, which was more costly than licensing newer off-the-shelf
CPU cores from a third party (typically ARM, MIPS, or RISC-V). It seems
that all the SoC product lines are still around, but have not used the
custom CPU architectures for several years at this point. In contrast,
CPU instruction sets that remain popular and have actively maintained
kernel ports tend to all be used across multiple licensees.

The removal came out of a discussion that is now documented at
https://lwn.net/Articles/748074/. Unlike the original plans, I'm not
marking any ports as deprecated but remove them all at once after I made
sure that they are all unused. Some architectures (notably tile, mn10300,
and blackfin) are still being shipped in products with old kernels,
but those products will never be updated to newer kernel releases.

After this series, we still have a few architectures without mainline
gcc support:

- unicore32 and hexagon both have very outdated gcc releases, but the
  maintainers promised to work on providing something newer. At least
  in case of hexagon, this will only be llvm, not gcc.

- openrisc, risc-v and nds32 are still in the process of finishing their
  support or getting it added to mainline gcc in the first place.
  They all have patched gcc-7.3 ports that work to some degree, but
  complete upstream support won't happen before gcc-8.1. Csky posted
  their first kernel patch set last week, their situation will be similar.

----------------------------------------------------------------

(dirstat only for brevity)

   0.0% Documentation/admin-guide/
   0.0% Documentation/blackfin/
   0.0% Documentation/cris/
   0.0% Documentation/dev-tools/
   0.0% Documentation/devicetree/bindings/cris/
   0.0% Documentation/devicetree/bindings/gpio/
   0.0% Documentation/devicetree/bindings/interrupt-controller/
   0.0% Documentation/devicetree/bindings/metag/
   0.0% Documentation/devicetree/bindings/serial/
   0.0% Documentation/driver-api/usb/
   0.0% Documentation/features/core/BPF-JIT/
   0.0% Documentation/features/core/generic-idle-thread/
   0.0% Documentation/features/core/jump-labels/
   0.0% Documentation/features/core/tracehook/
   0.0% Documentation/features/debug/KASAN/
   0.0% Documentation/features/debug/gcov-profile-all/
   0.0% Documentation/features/debug/kgdb/
   0.0% Documentation/features/debug/kprobes-on-ftrace/
   0.0% Documentation/features/debug/kprobes/
   0.0% Documentation/features/debug/kretprobes/
   0.0% Documentation/features/debug/optprobes/
   0.0% Documentation/features/debug/stackprotector/
   0.0% Documentation/features/debug/uprobes/
   0.0% Documentation/features/debug/user-ret-profiler/
   0.0% Documentation/features/io/dma-api-debug/
   0.0% Documentation/features/io/dma-contiguous/
   0.0% Documentation/features/io/sg-chain/
   0.0% Documentation/features/lib/strncasecmp/
   0.0% Documentation/features/locking/cmpxchg-local/
   0.0% Documentation/features/locking/lockdep/
   0.0% Documentation/features/locking/queued-rwlocks/
   0.0% Documentation/features/locking/queued-spinlocks/
   0.0% Documentation/features/locking/rwsem-optimized/
   0.0% Documentation/features/perf/kprobes-event/
   0.0% Documentation/features/perf/perf-regs/
   0.0% Documentation/features/perf/perf-stackdump/
   0.0% Documentation/features/sched/membarrier-sync-core/
   0.0% Documentation/features/sched/numa-balancing/
   0.0% Documentation/features/seccomp/seccomp-filter/
   0.0% Documentation/features/time/arch-tick-broadcast/
   0.0% Documentation/features/time/clockevents/
   0.0% Documentation/features/time/context-tracking/
   0.0% Documentation/features/time/irq-time-acct/
   0.0% Documentation/features/time/modern-timekeeping/
   0.0% Documentation/features/time/virt-cpuacct/
   0.0% Documentation/features/vm/ELF-ASLR/
   0.0% Documentation/features/vm/PG_uncached/
   0.0% Documentation/features/vm/THP/
   0.0% Documentation/features/vm/TLB/
   0.0% Documentation/features/vm/huge-vmap/
   0.0% Documentation/features/vm/ioremap_prot/
   0.0% Documentation/features/vm/numa-memblock/
   0.0% Documentation/features/vm/pte_special/
   0.4% Documentation/frv/
   0.0% Documentation/ioctl/
   0.0% Documentation/metag/
   0.0% Documentation/mn10300/
   0.0% Documentation/watchdog/
   0.0% Documentation/
   0.0% arch/blackfin/boot/
   0.5% arch/blackfin/configs/
   2.3% arch/blackfin/include/asm/
   0.0% arch/blackfin/include/mach-common/
   0.1% arch/blackfin/include/uapi/asm/
   0.0% arch/blackfin/kernel/cplb-mpu/
   0.0% arch/blackfin/kernel/cplb-nompu/
   2.2% arch/blackfin/kernel/
   0.2% arch/blackfin/lib/
   0.2% arch/blackfin/mach-bf518/boards/
   1.5% arch/blackfin/mach-bf518/include/mach/
   0.0% arch/blackfin/mach-bf518/
   0.7% arch/blackfin/mach-bf527/boards/
   2.0% arch/blackfin/mach-bf527/include/mach/
   0.0% arch/blackfin/mach-bf527/
   0.4% arch/blackfin/mach-bf533/boards/
   0.8% arch/blackfin/mach-bf533/include/mach/
   0.0% arch/blackfin/mach-bf533/
   1.0% arch/blackfin/mach-bf537/boards/
   2.1% arch/blackfin/mach-bf537/include/mach/
   0.0% arch/blackfin/mach-bf537/
   0.1% arch/blackfin/mach-bf538/boards/
   1.9% arch/blackfin/mach-bf538/include/mach/
   0.0% arch/blackfin/mach-bf538/
   0.5% arch/blackfin/mach-bf548/boards/
   5.4% arch/blackfin/mach-bf548/include/mach/
   0.1% arch/blackfin/mach-bf548/
   0.2% arch/blackfin/mach-bf561/boards/
   1.6% arch/blackfin/mach-bf561/include/mach/
   0.2% arch/blackfin/mach-bf561/
   0.3% arch/blackfin/mach-bf609/boards/
   3.8% arch/blackfin/mach-bf609/include/mach/
   0.4% arch/blackfin/mach-bf609/
   0.8% arch/blackfin/mach-common/
   0.2% arch/blackfin/mm/
   0.0% arch/blackfin/oprofile/
   0.3% arch/blackfin/
   0.8% arch/cris/arch-v10/drivers/
   1.3% arch/cris/arch-v10/kernel/
   0.2% arch/cris/arch-v10/lib/
   0.1% arch/cris/arch-v10/mm/
   0.1% arch/cris/arch-v10/
   0.0% arch/cris/arch-v32/drivers/mach-a3/
   0.0% arch/cris/arch-v32/drivers/mach-fs/
   0.0% arch/cris/arch-v32/drivers/pci/
   1.2% arch/cris/arch-v32/drivers/
   1.2% arch/cris/arch-v32/kernel/
   0.2% arch/cris/arch-v32/lib/
   0.2% arch/cris/arch-v32/mach-a3/
   0.2% arch/cris/arch-v32/mach-fs/
   0.1% arch/cris/arch-v32/mm/
   0.0% arch/cris/arch-v32/
   0.1% arch/cris/boot/compressed/
   0.0% arch/cris/boot/dts/
   0.1% arch/cris/boot/rescue/
   0.0% arch/cris/boot/tools/
   0.0% arch/cris/boot/
   0.0% arch/cris/configs/
   0.3% arch/cris/include/arch-v10/arch/
   1.4% arch/cris/include/arch-v32/arch/hwregs/asm/
   2.9% arch/cris/include/arch-v32/arch/hwregs/iop/asm/
   1.8% arch/cris/include/arch-v32/arch/hwregs/iop/
   0.9% arch/cris/include/arch-v32/arch/hwregs/
   0.3% arch/cris/include/arch-v32/arch/
   0.7% arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/
   1.2% arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/
   0.6% arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/
   0.8% arch/cris/include/arch-v32/mach-a3/mach/hwregs/
   0.0% arch/cris/include/arch-v32/mach-a3/mach/
   0.4% arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/
   0.6% arch/cris/include/arch-v32/mach-fs/mach/hwregs/
   0.0% arch/cris/include/arch-v32/mach-fs/mach/
   0.3% arch/cris/include/asm/
   2.0% arch/cris/include/uapi/arch-v10/arch/
   0.0% arch/cris/include/uapi/arch-v32/arch/
   0.3% arch/cris/include/uapi/asm/
   0.2% arch/cris/kernel/
   0.1% arch/cris/mm/
   0.1% arch/cris/
   0.0% arch/frv/boot/
   1.3% arch/frv/include/asm/
   0.2% arch/frv/include/uapi/asm/
   2.3% arch/frv/kernel/
   0.2% arch/frv/lib/
   0.1% arch/frv/mb93090-mb00/
   0.3% arch/frv/mm/
   0.0% arch/frv/
   0.0% arch/m32r/boot/compressed/
   0.0% arch/m32r/boot/
   0.1% arch/m32r/configs/
   0.0% arch/m32r/include/asm/m32104ut/
   0.1% arch/m32r/include/asm/m32700ut/
   0.0% arch/m32r/include/asm/mappi2/
   0.0% arch/m32r/include/asm/mappi3/
   0.0% arch/m32r/include/asm/opsput/
   1.2% arch/m32r/include/asm/
   0.2% arch/m32r/include/uapi/asm/
   0.9% arch/m32r/kernel/
   0.2% arch/m32r/lib/
   0.2% arch/m32r/mm/
   0.0% arch/m32r/oprofile/
   0.0% arch/m32r/platforms/m32104ut/
   0.2% arch/m32r/platforms/m32700ut/
   0.2% arch/m32r/platforms/mappi/
   0.1% arch/m32r/platforms/mappi2/
   0.1% arch/m32r/platforms/mappi3/
   0.0% arch/m32r/platforms/oaks32r/
   0.1% arch/m32r/platforms/opsput/
   0.0% arch/m32r/platforms/usrv/
   0.0% arch/m32r/platforms/
   0.0% arch/m32r/
   0.0% arch/metag/boot/dts/
   0.0% arch/metag/boot/
   0.0% arch/metag/configs/
   0.0% arch/metag/include/asm/mach/
   1.9% arch/metag/include/asm/
   0.0% arch/metag/include/uapi/asm/
   0.1% arch/metag/kernel/perf/
   1.0% arch/metag/kernel/
   0.4% arch/metag/lib/
   0.4% arch/metag/mm/
   0.0% arch/metag/oprofile/
   0.4% arch/metag/tbx/
   0.0% arch/metag/
   0.0% arch/mn10300/boot/compressed/
   0.0% arch/mn10300/boot/tools/
   0.0% arch/mn10300/boot/
   0.0% arch/mn10300/configs/
   1.5% arch/mn10300/include/asm/
   0.2% arch/mn10300/include/uapi/asm/
   2.0% arch/mn10300/kernel/
   0.1% arch/mn10300/lib/
   0.9% arch/mn10300/mm/
   0.0% arch/mn10300/oprofile/
   0.0% arch/mn10300/proc-mn103e010/include/proc/
   0.0% arch/mn10300/proc-mn103e010/
   0.1% arch/mn10300/proc-mn2ws0050/include/proc/
   0.0% arch/mn10300/proc-mn2ws0050/
   0.0% arch/mn10300/unit-asb2303/include/unit/
   0.0% arch/mn10300/unit-asb2303/
   0.0% arch/mn10300/unit-asb2305/include/unit/
   0.1% arch/mn10300/unit-asb2305/
   0.1% arch/mn10300/unit-asb2364/include/unit/
   0.0% arch/mn10300/unit-asb2364/
   0.1% arch/mn10300/
   0.0% arch/score/boot/
   0.0% arch/score/configs/
   0.4% arch/score/include/asm/
   0.0% arch/score/include/uapi/asm/
   0.4% arch/score/kernel/
   0.1% arch/score/lib/
   0.1% arch/score/mm/
   0.0% arch/score/
   0.1% arch/tile/configs/
   0.4% arch/tile/gxio/
   0.5% arch/tile/include/arch/
   1.9% arch/tile/include/asm/
   0.7% arch/tile/include/gxio/
   2.0% arch/tile/include/hv/
   1.1% arch/tile/include/uapi/arch/
   0.1% arch/tile/include/uapi/asm/
   0.0% arch/tile/kernel/vdso/
   5.3% arch/tile/kernel/
   0.0% arch/tile/kvm/
   0.6% arch/tile/lib/
   0.7% arch/tile/mm/
   0.1% arch/tile/
   0.0% block/
   0.0% crypto/
   0.3% drivers/ata/
   0.1% drivers/char/
   0.0% drivers/clocksource/
   0.0% drivers/cpufreq/
   0.0% drivers/edac/
   0.0% drivers/gpio/
   0.1% drivers/i2c/busses/
   0.0% drivers/ide/
   0.0% drivers/input/joystick/
   0.0% drivers/input/keyboard/
   0.0% drivers/input/misc/
   0.2% drivers/irqchip/
   0.0% drivers/isdn/hisax/
   0.2% drivers/media/platform/blackfin/
   0.1% drivers/media/platform/
   0.0% drivers/media/rc/img-ir/
   0.0% drivers/misc/echo/
   0.1% drivers/mmc/host/
   0.1% drivers/net/can/
   0.3% drivers/net/cris/
   0.0% drivers/net/ethernet/8390/
   0.3% drivers/net/ethernet/adi/
   0.0% drivers/net/ethernet/davicom/
   0.0% drivers/net/ethernet/smsc/
   0.8% drivers/net/ethernet/tile/
   0.0% drivers/net/ethernet/
   0.0% drivers/net/wireless/cisco/
   0.0% drivers/net/
   0.0% drivers/pci/
   0.3% drivers/pcmcia/
   0.4% drivers/pinctrl/
   0.0% drivers/pwm/
   0.1% drivers/rtc/
   0.5% drivers/spi/
   0.0% drivers/staging/iio/trigger/
   0.0% drivers/staging/iio/
   0.0% drivers/staging/speakup/
   0.0% drivers/tty/hvc/
   1.7% drivers/tty/serial/
   0.1% drivers/tty/
   0.0% drivers/usb/gadget/function/
   0.0% drivers/usb/gadget/legacy/
   0.0% drivers/usb/host/
   0.1% drivers/usb/musb/
   0.0% drivers/video/console/
   0.7% drivers/video/fbdev/
   1.2% drivers/video/logo/
   0.0% drivers/watchdog/
   0.0% fs/minix/
   0.0% fs/proc/
   0.0% fs/
   0.0% include/asm-generic/
   0.0% include/clocksource/
   0.0% include/linux/irqchip/
   0.0% include/linux/platform_data/
   0.0% include/linux/raid/
   0.0% include/linux/usb/
   0.0% include/linux/
   0.0% include/media/blackfin/
   0.0% include/trace/events/
   0.0% include/uapi/asm-generic/
   0.0% include/uapi/linux/
   0.0% init/
   0.0% kernel/
   0.0% lib/raid6/test/
   0.0% lib/raid6/
   0.0% lib/
   0.0% mm/
   0.0% samples/blackfin/
   0.0% samples/kprobes/
   0.0% samples/
   0.0% scripts/mod/
   0.0% scripts/
   0.0% tools/arch/frv/include/uapi/asm/
   0.0% tools/arch/m32r/include/uapi/asm/
   0.0% tools/arch/mn10300/include/uapi/asm/
   0.0% tools/arch/score/include/uapi/asm/
   0.0% tools/arch/tile/include/asm/
   0.0% tools/arch/tile/include/uapi/asm/
   0.0% tools/include/asm-generic/
   0.0% tools/perf/
   0.0% tools/scripts/
   0.0% tools/testing/ktest/examples/
   0.0% tools/testing/ktest/
 2498 files changed, 95 insertions(+), 467668 deletions(-)
