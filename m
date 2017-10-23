From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 19/19] COCCINELLE: treewide: kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:29 -0700
Message-ID: <1508792849-3115-19-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Please do not apply this to mainline directly, instead please re-run the
coccinelle script shown below and apply its output.

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't harmful, and changing them results in
churn.

However, for some features, the read/write distinction is critical to
correct operation. To distinguish these cases, separate read/write
accessors must be used. This patch migrates (most) remaining
ACCESS_ONCE() instances to {READ,WRITE}_ONCE(), using the following
coccinelle script:

----
// Convert trivial ACCESS_ONCE() uses to equivalent READ_ONCE() and
// WRITE_ONCE()

// $ make coccicheck COCCI=/home/mark/once.cocci SPFLAGS="--include-headers" MODE=patch

virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/arc/kernel/smp.c                              |  2 +-
 arch/arm/include/asm/spinlock.h                    |  6 ++--
 arch/arm/mach-tegra/cpuidle-tegra20.c              |  2 +-
 arch/arm/vdso/vgettimeofday.c                      |  2 +-
 arch/ia64/include/asm/spinlock.h                   |  8 ++---
 arch/mips/include/asm/vdso.h                       |  2 +-
 arch/mips/kernel/pm-cps.c                          |  2 +-
 arch/mn10300/kernel/mn10300-serial.c               |  4 +--
 arch/parisc/include/asm/atomic.h                   |  2 +-
 arch/powerpc/platforms/powernv/opal-msglog.c       |  2 +-
 arch/s390/include/asm/spinlock.h                   |  6 ++--
 arch/s390/lib/spinlock.c                           | 16 +++++-----
 arch/sparc/include/asm/atomic_32.h                 |  2 +-
 arch/tile/gxio/dma_queue.c                         |  4 +--
 arch/tile/include/gxio/dma_queue.h                 |  2 +-
 arch/tile/kernel/ptrace.c                          |  2 +-
 arch/x86/entry/common.c                            |  2 +-
 arch/x86/entry/vdso/vclock_gettime.c               |  2 +-
 arch/x86/events/core.c                             |  2 +-
 arch/x86/include/asm/vgtod.h                       |  2 +-
 arch/x86/kernel/espfix_64.c                        |  6 ++--
 arch/x86/kernel/nmi.c                              |  2 +-
 arch/x86/kvm/mmu.c                                 |  4 +--
 arch/x86/kvm/page_track.c                          |  2 +-
 arch/x86/xen/p2m.c                                 |  2 +-
 arch/xtensa/platforms/xtfpga/lcd.c                 | 14 ++++-----
 block/blk-wbt.c                                    |  2 +-
 drivers/base/core.c                                |  2 +-
 drivers/base/power/runtime.c                       |  4 +--
 drivers/char/random.c                              |  4 +--
 drivers/clocksource/bcm2835_timer.c                |  2 +-
 drivers/crypto/caam/jr.c                           |  4 +--
 drivers/crypto/nx/nx-842-powernv.c                 |  2 +-
 drivers/firewire/ohci.c                            | 10 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  4 +--
 drivers/gpu/drm/amd/scheduler/gpu_scheduler.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  2 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |  2 +-
 drivers/infiniband/hw/hfi1/pio.c                   |  6 ++--
 drivers/infiniband/hw/hfi1/ruc.c                   |  2 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |  8 ++---
 drivers/infiniband/hw/hfi1/sdma.h                  |  2 +-
 drivers/infiniband/hw/hfi1/uc.c                    |  4 +--
 drivers/infiniband/hw/hfi1/ud.c                    |  4 +--
 drivers/infiniband/hw/hfi1/user_sdma.c             |  8 ++---
 drivers/infiniband/hw/qib/qib_ruc.c                |  2 +-
 drivers/infiniband/hw/qib/qib_uc.c                 |  4 +--
 drivers/infiniband/hw/qib/qib_ud.c                 |  4 +--
 drivers/infiniband/sw/rdmavt/qp.c                  |  6 ++--
 drivers/input/misc/regulator-haptic.c              |  2 +-
 drivers/md/dm-bufio.c                              | 10 +++---
 drivers/md/dm-kcopyd.c                             |  4 +--
 drivers/md/dm-stats.c                              | 36 +++++++++++-----------
 drivers/md/dm-switch.c                             |  2 +-
 drivers/md/dm-thin.c                               |  2 +-
 drivers/md/dm-verity-target.c                      |  2 +-
 drivers/md/dm.c                                    |  4 +--
 drivers/md/md.c                                    |  2 +-
 drivers/md/raid5.c                                 |  2 +-
 drivers/misc/mic/scif/scif_rb.c                    |  8 ++---
 drivers/misc/mic/scif/scif_rma_list.c              |  2 +-
 drivers/net/bonding/bond_alb.c                     |  2 +-
 drivers/net/bonding/bond_main.c                    |  6 ++--
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |  4 +--
 drivers/net/ethernet/emulex/benet/be_main.c        |  2 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  4 +--
 drivers/net/ethernet/intel/igb/e1000_regs.h        |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h    |  4 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  8 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  4 +--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  2 +-
 drivers/net/ethernet/intel/ixgbevf/vf.h            |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         | 12 ++++----
 drivers/net/ethernet/neterion/vxge/vxge-main.c     |  2 +-
 drivers/net/ethernet/sfc/ef10.c                    | 10 +++---
 drivers/net/ethernet/sfc/efx.c                     |  4 +--
 drivers/net/ethernet/sfc/falcon/efx.c              |  4 +--
 drivers/net/ethernet/sfc/falcon/falcon.c           |  4 +--
 drivers/net/ethernet/sfc/falcon/farch.c            |  8 ++---
 drivers/net/ethernet/sfc/falcon/nic.h              |  6 ++--
 drivers/net/ethernet/sfc/falcon/tx.c               |  6 ++--
 drivers/net/ethernet/sfc/farch.c                   |  8 ++---
 drivers/net/ethernet/sfc/nic.h                     |  6 ++--
 drivers/net/ethernet/sfc/ptp.c                     | 10 +++---
 drivers/net/ethernet/sfc/tx.c                      |  6 ++--
 drivers/net/ethernet/sun/niu.c                     |  4 +--
 drivers/net/tap.c                                  |  2 +-
 drivers/net/tun.c                                  |  4 +--
 drivers/net/wireless/ath/ath5k/desc.c              |  8 ++---
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  4 +--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 10 +++---
 drivers/net/wireless/mac80211_hwsim.c              |  4 +--
 drivers/scsi/qla2xxx/qla_target.c                  |  2 +-
 drivers/target/target_core_user.c                  |  2 +-
 drivers/usb/class/cdc-wdm.c                        |  2 +-
 drivers/usb/core/devio.c                           |  2 +-
 drivers/usb/core/sysfs.c                           |  4 +--
 drivers/usb/gadget/udc/gr_udc.c                    |  4 +--
 drivers/usb/host/ohci-hcd.c                        |  2 +-
 drivers/usb/host/uhci-hcd.h                        |  4 +--
 drivers/vfio/vfio.c                                |  2 +-
 drivers/vhost/scsi.c                               |  2 +-
 fs/aio.c                                           |  2 +-
 fs/buffer.c                                        |  3 +-
 fs/crypto/keyinfo.c                                |  2 +-
 fs/direct-io.c                                     |  2 +-
 fs/exec.c                                          |  2 +-
 fs/fcntl.c                                         |  2 +-
 fs/fs_pin.c                                        |  4 +--
 fs/fuse/dev.c                                      |  2 +-
 fs/inode.c                                         |  2 +-
 fs/namei.c                                         |  4 +--
 fs/namespace.c                                     |  2 +-
 fs/nfs/dir.c                                       |  8 ++---
 fs/proc/array.c                                    |  2 +-
 fs/proc_namespace.c                                |  2 +-
 fs/splice.c                                        |  2 +-
 fs/userfaultfd.c                                   |  8 ++---
 fs/xfs/xfs_log_priv.h                              |  4 +--
 include/linux/bitops.h                             |  4 +--
 include/linux/dynamic_queue_limits.h               |  2 +-
 include/linux/huge_mm.h                            |  2 +-
 include/linux/if_team.h                            |  2 +-
 include/linux/llist.h                              |  2 +-
 include/linux/pm_runtime.h                         |  2 +-
 include/net/ip_vs.h                                |  6 ++--
 kernel/acct.c                                      |  4 +--
 kernel/events/core.c                               |  6 ++--
 kernel/events/ring_buffer.c                        |  2 +-
 kernel/exit.c                                      |  2 +-
 kernel/trace/ring_buffer.c                         |  2 +-
 kernel/trace/trace.h                               |  2 +-
 kernel/trace/trace_stack.c                         |  2 +-
 kernel/user_namespace.c                            |  2 +-
 lib/assoc_array.c                                  | 20 ++++++------
 lib/dynamic_queue_limits.c                         |  2 +-
 lib/llist.c                                        |  2 +-
 lib/vsprintf.c                                     |  4 +--
 mm/huge_memory.c                                   |  2 +-
 net/core/dev.c                                     |  2 +-
 net/core/pktgen.c                                  |  2 +-
 net/ipv4/inet_fragment.c                           |  2 +-
 net/ipv4/route.c                                   |  2 +-
 net/ipv4/tcp_output.c                              |  2 +-
 net/ipv4/udp.c                                     |  4 +--
 net/ipv6/ip6_tunnel.c                              |  8 ++---
 net/ipv6/udp.c                                     |  4 +--
 net/llc/llc_input.c                                |  4 +--
 net/mac80211/sta_info.c                            |  2 +-
 net/netlabel/netlabel_calipso.c                    |  2 +-
 net/wireless/nl80211.c                             |  2 +-
 sound/firewire/amdtp-am824.c                       |  6 ++--
 sound/firewire/amdtp-stream.c                      | 23 +++++++-------
 sound/firewire/amdtp-stream.h                      |  2 +-
 sound/firewire/digi00x/amdtp-dot.c                 |  6 ++--
 sound/firewire/fireface/amdtp-ff.c                 |  4 +--
 sound/firewire/fireface/ff-midi.c                  | 10 +++---
 sound/firewire/fireface/ff-transaction.c           |  8 ++---
 sound/firewire/isight.c                            | 18 +++++------
 sound/firewire/motu/amdtp-motu.c                   |  4 +--
 sound/firewire/oxfw/oxfw-scs1x.c                   | 12 ++++----
 sound/firewire/tascam/amdtp-tascam.c               |  4 +--
 sound/firewire/tascam/tascam-transaction.c         |  6 ++--
 sound/soc/xtensa/xtfpga-i2s.c                      |  6 ++--
 sound/usb/bcd2000/bcd2000.c                        |  4 +--
 tools/arch/x86/include/asm/atomic.h                |  2 +-
 tools/include/asm-generic/atomic-gcc.h             |  2 +-
 tools/perf/util/auxtrace.h                         |  4 +--
 tools/perf/util/evlist.h                           |  2 +-
 tools/perf/util/session.h                          |  2 +-
 virt/kvm/kvm_main.c                                |  2 +-
 181 files changed, 386 insertions(+), 388 deletions(-)

diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index f46267153ec2..94cabe73664b 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -245,7 +245,7 @@ static void ipi_send_msg_one(int cpu, enum ipi_msg_type msg)
 	 * and read back old value
 	 */
 	do {
-		new = old = ACCESS_ONCE(*ipi_data_ptr);
+		new = old = READ_ONCE(*ipi_data_ptr);
 		new |= 1U << msg;
 	} while (cmpxchg(ipi_data_ptr, old, new) != old);
 
diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index c030143c18c6..060e4ebb4e8a 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -73,7 +73,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 
 	while (lockval.tickets.next != lockval.tickets.owner) {
 		wfe();
-		lockval.tickets.owner = ACCESS_ONCE(lock->tickets.owner);
+		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
 	}
 
 	smp_mb();
@@ -194,7 +194,7 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 }
 
 /* write_can_lock - would write_trylock() succeed? */
-#define arch_write_can_lock(x)		(ACCESS_ONCE((x)->lock) == 0)
+#define arch_write_can_lock(x)		(READ_ONCE((x)->lock) == 0)
 
 /*
  * Read locks are a bit more hairy:
@@ -274,7 +274,7 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 }
 
 /* read_can_lock - would read_trylock() succeed? */
-#define arch_read_can_lock(x)		(ACCESS_ONCE((x)->lock) < 0x80000000)
+#define arch_read_can_lock(x)		(READ_ONCE((x)->lock) < 0x80000000)
 
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 76e4c83cd5c8..3f24addd7972 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -179,7 +179,7 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 	bool entered_lp2 = false;
 
 	if (tegra_pending_sgi())
-		ACCESS_ONCE(abort_flag) = true;
+		WRITE_ONCE(abort_flag, true);
 
 	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
 
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 79214d5ff097..a9dd619c6c29 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -35,7 +35,7 @@ static notrace u32 __vdso_read_begin(const struct vdso_data *vdata)
 {
 	u32 seq;
 repeat:
-	seq = ACCESS_ONCE(vdata->seq_count);
+	seq = READ_ONCE(vdata->seq_count);
 	if (seq & 1) {
 		cpu_relax();
 		goto repeat;
diff --git a/arch/ia64/include/asm/spinlock.h b/arch/ia64/include/asm/spinlock.h
index df2c121164b8..9c1f0b3b7ef5 100644
--- a/arch/ia64/include/asm/spinlock.h
+++ b/arch/ia64/include/asm/spinlock.h
@@ -61,7 +61,7 @@ static __always_inline void __ticket_spin_lock(arch_spinlock_t *lock)
 
 static __always_inline int __ticket_spin_trylock(arch_spinlock_t *lock)
 {
-	int tmp = ACCESS_ONCE(lock->lock);
+	int tmp = READ_ONCE(lock->lock);
 
 	if (!(((tmp >> TICKET_SHIFT) ^ tmp) & TICKET_MASK))
 		return ia64_cmpxchg(acq, &lock->lock, tmp, tmp + 1, sizeof (tmp)) == tmp;
@@ -73,19 +73,19 @@ static __always_inline void __ticket_spin_unlock(arch_spinlock_t *lock)
 	unsigned short	*p = (unsigned short *)&lock->lock + 1, tmp;
 
 	asm volatile ("ld2.bias %0=[%1]" : "=r"(tmp) : "r"(p));
-	ACCESS_ONCE(*p) = (tmp + 2) & ~1;
+	WRITE_ONCE(*p, (tmp + 2) & ~1);
 }
 
 static inline int __ticket_spin_is_locked(arch_spinlock_t *lock)
 {
-	long tmp = ACCESS_ONCE(lock->lock);
+	long tmp = READ_ONCE(lock->lock);
 
 	return !!(((tmp >> TICKET_SHIFT) ^ tmp) & TICKET_MASK);
 }
 
 static inline int __ticket_spin_is_contended(arch_spinlock_t *lock)
 {
-	long tmp = ACCESS_ONCE(lock->lock);
+	long tmp = READ_ONCE(lock->lock);
 
 	return ((tmp - (tmp >> TICKET_SHIFT)) & TICKET_MASK) > 1;
 }
diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index b7cd6cf77b83..91bf0c2c265c 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -99,7 +99,7 @@ static inline u32 vdso_data_read_begin(const union mips_vdso_data *data)
 	u32 seq;
 
 	while (true) {
-		seq = ACCESS_ONCE(data->seq_count);
+		seq = READ_ONCE(data->seq_count);
 		if (likely(!(seq & 1))) {
 			/* Paired with smp_wmb() in vdso_data_write_*(). */
 			smp_rmb();
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 4655017f2377..1d2996cd58da 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -166,7 +166,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	nc_core_ready_count = nc_addr;
 
 	/* Ensure ready_count is zero-initialised before the assembly runs */
-	ACCESS_ONCE(*nc_core_ready_count) = 0;
+	WRITE_ONCE(*nc_core_ready_count, 0);
 	coupled_barrier(&per_cpu(pm_barrier, core), online);
 
 	/* Run the generated entry code */
diff --git a/arch/mn10300/kernel/mn10300-serial.c b/arch/mn10300/kernel/mn10300-serial.c
index 7ecf69879e2d..d7ef1232a82a 100644
--- a/arch/mn10300/kernel/mn10300-serial.c
+++ b/arch/mn10300/kernel/mn10300-serial.c
@@ -543,7 +543,7 @@ static void mn10300_serial_receive_interrupt(struct mn10300_serial_port *port)
 
 try_again:
 	/* pull chars out of the hat */
-	ix = ACCESS_ONCE(port->rx_outp);
+	ix = READ_ONCE(port->rx_outp);
 	if (CIRC_CNT(port->rx_inp, ix, MNSC_BUFFER_SIZE) == 0) {
 		if (push && !tport->low_latency)
 			tty_flip_buffer_push(tport);
@@ -1724,7 +1724,7 @@ static int mn10300_serial_poll_get_char(struct uart_port *_port)
 	if (mn10300_serial_int_tbl[port->rx_irq].port != NULL) {
 		do {
 			/* pull chars out of the hat */
-			ix = ACCESS_ONCE(port->rx_outp);
+			ix = READ_ONCE(port->rx_outp);
 			if (CIRC_CNT(port->rx_inp, ix, MNSC_BUFFER_SIZE) == 0)
 				return NO_POLL_CHAR;
 
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 17b98a87e5e2..c57d4e8307f2 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -260,7 +260,7 @@ atomic64_set(atomic64_t *v, s64 i)
 static __inline__ s64
 atomic64_read(const atomic64_t *v)
 {
-	return ACCESS_ONCE((v)->counter);
+	return READ_ONCE((v)->counter);
 }
 
 #define atomic64_inc(v)		(atomic64_add(   1,(v)))
diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 7a9cde0cfbd1..acd3206dfae3 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -43,7 +43,7 @@ ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
 	if (!opal_memcons)
 		return -ENODEV;
 
-	out_pos = be32_to_cpu(ACCESS_ONCE(opal_memcons->out_pos));
+	out_pos = be32_to_cpu(READ_ONCE(opal_memcons->out_pos));
 
 	/* Now we've read out_pos, put a barrier in before reading the new
 	 * data it points to in conbuf. */
diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index 8182b521c42f..fc03f9dc7cd1 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -130,14 +130,14 @@ extern int _raw_write_trylock_retry(arch_rwlock_t *lp);
 
 static inline int arch_read_trylock_once(arch_rwlock_t *rw)
 {
-	int old = ACCESS_ONCE(rw->lock);
+	int old = READ_ONCE(rw->lock);
 	return likely(old >= 0 &&
 		      __atomic_cmpxchg_bool(&rw->lock, old, old + 1));
 }
 
 static inline int arch_write_trylock_once(arch_rwlock_t *rw)
 {
-	int old = ACCESS_ONCE(rw->lock);
+	int old = READ_ONCE(rw->lock);
 	return likely(old == 0 &&
 		      __atomic_cmpxchg_bool(&rw->lock, 0, 0x80000000));
 }
@@ -224,7 +224,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 	int old;
 
 	do {
-		old = ACCESS_ONCE(rw->lock);
+		old = READ_ONCE(rw->lock);
 	} while (!__atomic_cmpxchg_bool(&rw->lock, old, old - 1));
 }
 
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index b12663d653d8..34e30b9ea234 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -162,8 +162,8 @@ void _raw_read_lock_wait(arch_rwlock_t *rw)
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
-		old = ACCESS_ONCE(rw->lock);
-		owner = ACCESS_ONCE(rw->owner);
+		old = READ_ONCE(rw->lock);
+		owner = READ_ONCE(rw->owner);
 		if (old < 0)
 			continue;
 		if (__atomic_cmpxchg_bool(&rw->lock, old, old + 1))
@@ -178,7 +178,7 @@ int _raw_read_trylock_retry(arch_rwlock_t *rw)
 	int old;
 
 	while (count-- > 0) {
-		old = ACCESS_ONCE(rw->lock);
+		old = READ_ONCE(rw->lock);
 		if (old < 0)
 			continue;
 		if (__atomic_cmpxchg_bool(&rw->lock, old, old + 1))
@@ -202,8 +202,8 @@ void _raw_write_lock_wait(arch_rwlock_t *rw, int prev)
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
-		old = ACCESS_ONCE(rw->lock);
-		owner = ACCESS_ONCE(rw->owner);
+		old = READ_ONCE(rw->lock);
+		owner = READ_ONCE(rw->owner);
 		smp_mb();
 		if (old >= 0) {
 			prev = __RAW_LOCK(&rw->lock, 0x80000000, __RAW_OP_OR);
@@ -230,8 +230,8 @@ void _raw_write_lock_wait(arch_rwlock_t *rw)
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
-		old = ACCESS_ONCE(rw->lock);
-		owner = ACCESS_ONCE(rw->owner);
+		old = READ_ONCE(rw->lock);
+		owner = READ_ONCE(rw->owner);
 		if (old >= 0 &&
 		    __atomic_cmpxchg_bool(&rw->lock, old, old | 0x80000000))
 			prev = old;
@@ -251,7 +251,7 @@ int _raw_write_trylock_retry(arch_rwlock_t *rw)
 	int old;
 
 	while (count-- > 0) {
-		old = ACCESS_ONCE(rw->lock);
+		old = READ_ONCE(rw->lock);
 		if (old)
 			continue;
 		if (__atomic_cmpxchg_bool(&rw->lock, 0, 0x80000000))
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 7643e979e333..e2f398e9456c 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -31,7 +31,7 @@ void atomic_set(atomic_t *, int);
 
 #define atomic_set_release(v, i)	atomic_set((v), (i))
 
-#define atomic_read(v)          ACCESS_ONCE((v)->counter)
+#define atomic_read(v)          READ_ONCE((v)->counter)
 
 #define atomic_add(i, v)	((void)atomic_add_return( (int)(i), (v)))
 #define atomic_sub(i, v)	((void)atomic_add_return(-(int)(i), (v)))
diff --git a/arch/tile/gxio/dma_queue.c b/arch/tile/gxio/dma_queue.c
index baa60357f8ba..b7ba577d82ca 100644
--- a/arch/tile/gxio/dma_queue.c
+++ b/arch/tile/gxio/dma_queue.c
@@ -163,14 +163,14 @@ int __gxio_dma_queue_is_complete(__gxio_dma_queue_t *dma_queue,
 				 int64_t completion_slot, int update)
 {
 	if (update) {
-		if (ACCESS_ONCE(dma_queue->hw_complete_count) >
+		if (READ_ONCE(dma_queue->hw_complete_count) >
 		    completion_slot)
 			return 1;
 
 		__gxio_dma_queue_update_credits(dma_queue);
 	}
 
-	return ACCESS_ONCE(dma_queue->hw_complete_count) > completion_slot;
+	return READ_ONCE(dma_queue->hw_complete_count) > completion_slot;
 }
 
 EXPORT_SYMBOL_GPL(__gxio_dma_queue_is_complete);
diff --git a/arch/tile/include/gxio/dma_queue.h b/arch/tile/include/gxio/dma_queue.h
index b9e45e37649e..c8fd47edba30 100644
--- a/arch/tile/include/gxio/dma_queue.h
+++ b/arch/tile/include/gxio/dma_queue.h
@@ -121,7 +121,7 @@ static inline int64_t __gxio_dma_queue_reserve(__gxio_dma_queue_t *dma_queue,
 		 * if the result is LESS than "hw_complete_count".
 		 */
 		uint64_t complete;
-		complete = ACCESS_ONCE(dma_queue->hw_complete_count);
+		complete = READ_ONCE(dma_queue->hw_complete_count);
 		slot |= (complete & 0xffffffffff000000);
 		if (slot < complete)
 			slot += 0x1000000;
diff --git a/arch/tile/kernel/ptrace.c b/arch/tile/kernel/ptrace.c
index e1a078e6828e..d516d61751c2 100644
--- a/arch/tile/kernel/ptrace.c
+++ b/arch/tile/kernel/ptrace.c
@@ -255,7 +255,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 int do_syscall_trace_enter(struct pt_regs *regs)
 {
-	u32 work = ACCESS_ONCE(current_thread_info()->flags);
+	u32 work = READ_ONCE(current_thread_info()->flags);
 
 	if ((work & _TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs)) {
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 03505ffbe1b6..eaa0ba66cf96 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -75,7 +75,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 		BUG_ON(regs != task_pt_regs(current));
 
-	work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
+	work = READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
 
 	if (unlikely(work & _TIF_SYSCALL_EMU))
 		emulated = true;
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index fa8dbfcf7ed3..11b13c4b43d5 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -318,7 +318,7 @@ int gettimeofday(struct timeval *, struct timezone *)
 notrace time_t __vdso_time(time_t *t)
 {
 	/* This is atomic on x86 so we don't need any locks. */
-	time_t result = ACCESS_ONCE(gtod->wall_time_sec);
+	time_t result = READ_ONCE(gtod->wall_time_sec);
 
 	if (t)
 		*t = result;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 589af1eec7c1..140d33288e78 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2118,7 +2118,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 			event->destroy(event);
 	}
 
-	if (ACCESS_ONCE(x86_pmu.attr_rdpmc))
+	if (READ_ONCE(x86_pmu.attr_rdpmc))
 		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
 
 	return err;
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 022e59714562..53dd162576a8 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -48,7 +48,7 @@ static inline unsigned gtod_read_begin(const struct vsyscall_gtod_data *s)
 	unsigned ret;
 
 repeat:
-	ret = ACCESS_ONCE(s->seq);
+	ret = READ_ONCE(s->seq);
 	if (unlikely(ret & 1)) {
 		cpu_relax();
 		goto repeat;
diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 9c4e7ba6870c..7d7715dde901 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -155,14 +155,14 @@ void init_espfix_ap(int cpu)
 	page = cpu/ESPFIX_STACKS_PER_PAGE;
 
 	/* Did another CPU already set this up? */
-	stack_page = ACCESS_ONCE(espfix_pages[page]);
+	stack_page = READ_ONCE(espfix_pages[page]);
 	if (likely(stack_page))
 		goto done;
 
 	mutex_lock(&espfix_init_mutex);
 
 	/* Did we race on the lock? */
-	stack_page = ACCESS_ONCE(espfix_pages[page]);
+	stack_page = READ_ONCE(espfix_pages[page]);
 	if (stack_page)
 		goto unlock_done;
 
@@ -200,7 +200,7 @@ void init_espfix_ap(int cpu)
 		set_pte(&pte_p[n*PTE_STRIDE], pte);
 
 	/* Job is done for this CPU and any CPU which shares this page */
-	ACCESS_ONCE(espfix_pages[page]) = stack_page;
+	WRITE_ONCE(espfix_pages[page], stack_page);
 
 unlock_done:
 	mutex_unlock(&espfix_init_mutex);
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 35aafc95e4b8..18bc9b51ac9b 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -105,7 +105,7 @@ static void nmi_max_handler(struct irq_work *w)
 {
 	struct nmiaction *a = container_of(w, struct nmiaction, irq_work);
 	int remainder_ns, decimal_msecs;
-	u64 whole_msecs = ACCESS_ONCE(a->max_duration);
+	u64 whole_msecs = READ_ONCE(a->max_duration);
 
 	remainder_ns = do_div(whole_msecs, (1000 * 1000));
 	decimal_msecs = remainder_ns / 1000;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 106d4a029a8a..af19a4291d54 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -443,7 +443,7 @@ static u64 __update_clear_spte_slow(u64 *sptep, u64 spte)
 
 static u64 __get_spte_lockless(u64 *sptep)
 {
-	return ACCESS_ONCE(*sptep);
+	return READ_ONCE(*sptep);
 }
 #else
 union split_spte {
@@ -4818,7 +4818,7 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 	 * If we don't have indirect shadow pages, it means no page is
 	 * write-protected, so we can exit simply.
 	 */
-	if (!ACCESS_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
+	if (!READ_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
 		return;
 
 	remote_flush = local_flush = false;
diff --git a/arch/x86/kvm/page_track.c b/arch/x86/kvm/page_track.c
index ea67dc876316..01c1371f39f8 100644
--- a/arch/x86/kvm/page_track.c
+++ b/arch/x86/kvm/page_track.c
@@ -157,7 +157,7 @@ bool kvm_page_track_is_active(struct kvm_vcpu *vcpu, gfn_t gfn,
 		return false;
 
 	index = gfn_to_index(gfn, slot->base_gfn, PT_PAGE_TABLE_LEVEL);
-	return !!ACCESS_ONCE(slot->arch.gfn_track[mode][index]);
+	return !!READ_ONCE(slot->arch.gfn_track[mode][index]);
 }
 
 void kvm_page_track_cleanup(struct kvm *kvm)
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 6083ba462f35..13b4f19b9131 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -547,7 +547,7 @@ int xen_alloc_p2m_entry(unsigned long pfn)
 	if (p2m_top_mfn && pfn < MAX_P2M_PFN) {
 		topidx = p2m_top_index(pfn);
 		top_mfn_p = &p2m_top_mfn[topidx];
-		mid_mfn = ACCESS_ONCE(p2m_top_mfn_p[topidx]);
+		mid_mfn = READ_ONCE(p2m_top_mfn_p[topidx]);
 
 		BUG_ON(virt_to_mfn(mid_mfn) != *top_mfn_p);
 
diff --git a/arch/xtensa/platforms/xtfpga/lcd.c b/arch/xtensa/platforms/xtfpga/lcd.c
index 4dc0c1b43f4b..2f7eb66c23ec 100644
--- a/arch/xtensa/platforms/xtfpga/lcd.c
+++ b/arch/xtensa/platforms/xtfpga/lcd.c
@@ -34,23 +34,23 @@
 static void lcd_put_byte(u8 *addr, u8 data)
 {
 #ifdef CONFIG_XTFPGA_LCD_8BIT_ACCESS
-	ACCESS_ONCE(*addr) = data;
+	WRITE_ONCE(*addr, data);
 #else
-	ACCESS_ONCE(*addr) = data & 0xf0;
-	ACCESS_ONCE(*addr) = (data << 4) & 0xf0;
+	WRITE_ONCE(*addr, data & 0xf0);
+	WRITE_ONCE(*addr, (data << 4) & 0xf0);
 #endif
 }
 
 static int __init lcd_init(void)
 {
-	ACCESS_ONCE(*LCD_INSTR_ADDR) = LCD_DISPLAY_MODE8BIT;
+	WRITE_ONCE(*LCD_INSTR_ADDR, LCD_DISPLAY_MODE8BIT);
 	mdelay(5);
-	ACCESS_ONCE(*LCD_INSTR_ADDR) = LCD_DISPLAY_MODE8BIT;
+	WRITE_ONCE(*LCD_INSTR_ADDR, LCD_DISPLAY_MODE8BIT);
 	udelay(200);
-	ACCESS_ONCE(*LCD_INSTR_ADDR) = LCD_DISPLAY_MODE8BIT;
+	WRITE_ONCE(*LCD_INSTR_ADDR, LCD_DISPLAY_MODE8BIT);
 	udelay(50);
 #ifndef CONFIG_XTFPGA_LCD_8BIT_ACCESS
-	ACCESS_ONCE(*LCD_INSTR_ADDR) = LCD_DISPLAY_MODE4BIT;
+	WRITE_ONCE(*LCD_INSTR_ADDR, LCD_DISPLAY_MODE4BIT);
 	udelay(50);
 	lcd_put_byte(LCD_INSTR_ADDR, LCD_DISPLAY_MODE4BIT);
 	udelay(50);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6a9a0f03a67b..d822530e6aea 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -261,7 +261,7 @@ static inline bool stat_sample_valid(struct blk_rq_stat *stat)
 
 static u64 rwb_sync_issue_lat(struct rq_wb *rwb)
 {
-	u64 now, issue = ACCESS_ONCE(rwb->sync_issue);
+	u64 now, issue = READ_ONCE(rwb->sync_issue);
 
 	if (!issue || !rwb->sync_cookie)
 		return 0;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 12ebd055724c..4b8ba2a75a4d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -668,7 +668,7 @@ const char *dev_driver_string(const struct device *dev)
 	 * so be careful about accessing it.  dev->bus and dev->class should
 	 * never change once they are set, so they don't need special care.
 	 */
-	drv = ACCESS_ONCE(dev->driver);
+	drv = READ_ONCE(dev->driver);
 	return drv ? drv->name :
 			(dev->bus ? dev->bus->name :
 			(dev->class ? dev->class->name : ""));
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7bcf80fa9ada..41d7c2b99f69 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -134,11 +134,11 @@ unsigned long pm_runtime_autosuspend_expiration(struct device *dev)
 	if (!dev->power.use_autosuspend)
 		goto out;
 
-	autosuspend_delay = ACCESS_ONCE(dev->power.autosuspend_delay);
+	autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
 	if (autosuspend_delay < 0)
 		goto out;
 
-	last_busy = ACCESS_ONCE(dev->power.last_busy);
+	last_busy = READ_ONCE(dev->power.last_busy);
 	elapsed = jiffies - last_busy;
 	if (elapsed < 0)
 		goto out;	/* jiffies has wrapped around. */
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8ad92707e45f..6c7ccac2679e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -641,7 +641,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		return;
 
 retry:
-	entropy_count = orig = ACCESS_ONCE(r->entropy_count);
+	entropy_count = orig = READ_ONCE(r->entropy_count);
 	if (nfrac < 0) {
 		/* Debit */
 		entropy_count += nfrac;
@@ -1265,7 +1265,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 
 	/* Can we pull enough? */
 retry:
-	entropy_count = orig = ACCESS_ONCE(r->entropy_count);
+	entropy_count = orig = READ_ONCE(r->entropy_count);
 	ibytes = nbytes;
 	/* never pull more than available */
 	have_bytes = entropy_count >> (ENTROPY_SHIFT + 3);
diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 39e489a96ad7..60da2537bef9 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -71,7 +71,7 @@ static irqreturn_t bcm2835_time_interrupt(int irq, void *dev_id)
 	if (readl_relaxed(timer->control) & timer->match_mask) {
 		writel_relaxed(timer->match_mask, timer->control);
 
-		event_handler = ACCESS_ONCE(timer->evt.event_handler);
+		event_handler = READ_ONCE(timer->evt.event_handler);
 		if (event_handler)
 			event_handler(&timer->evt);
 		return IRQ_HANDLED;
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index d258953ff488..f4f258075b89 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -172,7 +172,7 @@ static void caam_jr_dequeue(unsigned long devarg)
 
 	while (rd_reg32(&jrp->rregs->outring_used)) {
 
-		head = ACCESS_ONCE(jrp->head);
+		head = READ_ONCE(jrp->head);
 
 		spin_lock(&jrp->outlock);
 
@@ -341,7 +341,7 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 	spin_lock_bh(&jrp->inplock);
 
 	head = jrp->head;
-	tail = ACCESS_ONCE(jrp->tail);
+	tail = READ_ONCE(jrp->tail);
 
 	if (!rd_reg32(&jrp->rregs->inpring_avail) ||
 	    CIRC_SPACE(head, tail, JOBR_DEPTH) <= 0) {
diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 874ddf5e9087..0f20f5ec9617 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -193,7 +193,7 @@ static int wait_for_csb(struct nx842_workmem *wmem,
 	ktime_t start = wmem->start, now = ktime_get();
 	ktime_t timeout = ktime_add_ms(start, CSB_WAIT_MAX);
 
-	while (!(ACCESS_ONCE(csb->flags) & CSB_V)) {
+	while (!(READ_ONCE(csb->flags) & CSB_V)) {
 		cpu_relax();
 		now = ktime_get();
 		if (ktime_after(now, timeout))
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 8bf89267dc25..ccf52368a073 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -734,7 +734,7 @@ static unsigned int ar_search_last_active_buffer(struct ar_context *ctx,
 	__le16 res_count, next_res_count;
 
 	i = ar_first_buffer_index(ctx);
-	res_count = ACCESS_ONCE(ctx->descriptors[i].res_count);
+	res_count = READ_ONCE(ctx->descriptors[i].res_count);
 
 	/* A buffer that is not yet completely filled must be the last one. */
 	while (i != last && res_count == 0) {
@@ -742,8 +742,7 @@ static unsigned int ar_search_last_active_buffer(struct ar_context *ctx,
 		/* Peek at the next descriptor. */
 		next_i = ar_next_buffer_index(i);
 		rmb(); /* read descriptors in order */
-		next_res_count = ACCESS_ONCE(
-				ctx->descriptors[next_i].res_count);
+		next_res_count = READ_ONCE(ctx->descriptors[next_i].res_count);
 		/*
 		 * If the next descriptor is still empty, we must stop at this
 		 * descriptor.
@@ -759,8 +758,7 @@ static unsigned int ar_search_last_active_buffer(struct ar_context *ctx,
 			if (MAX_AR_PACKET_SIZE > PAGE_SIZE && i != last) {
 				next_i = ar_next_buffer_index(next_i);
 				rmb();
-				next_res_count = ACCESS_ONCE(
-					ctx->descriptors[next_i].res_count);
+				next_res_count = READ_ONCE(ctx->descriptors[next_i].res_count);
 				if (next_res_count != cpu_to_le16(PAGE_SIZE))
 					goto next_buffer_is_active;
 			}
@@ -2812,7 +2810,7 @@ static int handle_ir_buffer_fill(struct context *context,
 	u32 buffer_dma;
 
 	req_count = le16_to_cpu(last->req_count);
-	res_count = le16_to_cpu(ACCESS_ONCE(last->res_count));
+	res_count = le16_to_cpu(READ_ONCE(last->res_count));
 	completed = req_count - res_count;
 	buffer_dma = le32_to_cpu(last->data_address);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 333bad749067..303b5e099a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -260,7 +260,7 @@ static void amdgpu_fence_fallback(unsigned long arg)
  */
 int amdgpu_fence_wait_empty(struct amdgpu_ring *ring)
 {
-	uint64_t seq = ACCESS_ONCE(ring->fence_drv.sync_seq);
+	uint64_t seq = READ_ONCE(ring->fence_drv.sync_seq);
 	struct dma_fence *fence, **ptr;
 	int r;
 
@@ -300,7 +300,7 @@ unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
 	amdgpu_fence_process(ring);
 	emitted = 0x100000000ull;
 	emitted -= atomic_read(&ring->fence_drv.last_seq);
-	emitted += ACCESS_ONCE(ring->fence_drv.sync_seq);
+	emitted += READ_ONCE(ring->fence_drv.sync_seq);
 	return lower_32_bits(emitted);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 7171968f261e..6149a47fe63d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -788,11 +788,11 @@ static int amdgpu_debugfs_gem_bo_info(int id, void *ptr, void *data)
 	seq_printf(m, "\t0x%08x: %12ld byte %s",
 		   id, amdgpu_bo_size(bo), placement);
 
-	offset = ACCESS_ONCE(bo->tbo.mem.start);
+	offset = READ_ONCE(bo->tbo.mem.start);
 	if (offset != AMDGPU_BO_INVALID_OFFSET)
 		seq_printf(m, " @ 0x%010Lx", offset);
 
-	pin_count = ACCESS_ONCE(bo->pin_count);
+	pin_count = READ_ONCE(bo->pin_count);
 	if (pin_count)
 		seq_printf(m, " pin count %d", pin_count);
 	seq_printf(m, "\n");
diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
index 97c94f9683fa..46a5ec3eb438 100644
--- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
+++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
@@ -187,7 +187,7 @@ static bool amd_sched_entity_is_ready(struct amd_sched_entity *entity)
 	if (kfifo_is_empty(&entity->job_queue))
 		return false;
 
-	if (ACCESS_ONCE(entity->dependency))
+	if (READ_ONCE(entity->dependency))
 		return false;
 
 	return true;
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 3386452bd2f0..cf3deb283da5 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -451,7 +451,7 @@ int radeon_gem_busy_ioctl(struct drm_device *dev, void *data,
 	else
 		r = 0;
 
-	cur_placement = ACCESS_ONCE(robj->tbo.mem.mem_type);
+	cur_placement = READ_ONCE(robj->tbo.mem.mem_type);
 	args->domain = radeon_mem_type_to_domain(cur_placement);
 	drm_gem_object_put_unlocked(gobj);
 	return r;
@@ -481,7 +481,7 @@ int radeon_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
 		r = ret;
 
 	/* Flush HDP cache via MMIO if necessary */
-	cur_placement = ACCESS_ONCE(robj->tbo.mem.mem_type);
+	cur_placement = READ_ONCE(robj->tbo.mem.mem_type);
 	if (rdev->asic->mmio_hdp_flush &&
 	    radeon_mem_type_to_domain(cur_placement) == RADEON_GEM_DOMAIN_VRAM)
 		robj->rdev->asic->mmio_hdp_flush(rdev);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index a552e4ea5440..6ac094ee8983 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -904,7 +904,7 @@ vmw_surface_handle_reference(struct vmw_private *dev_priv,
 		if (unlikely(drm_is_render_client(file_priv)))
 			require_exist = true;
 
-		if (ACCESS_ONCE(vmw_fpriv(file_priv)->locked_master)) {
+		if (READ_ONCE(vmw_fpriv(file_priv)->locked_master)) {
 			DRM_ERROR("Locked master refused legacy "
 				  "surface reference.\n");
 			return -EACCES;
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index d9a1e9893136..97bea2e1aa6a 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -380,7 +380,7 @@ static long hfi1_file_ioctl(struct file *fp, unsigned int cmd,
 		if (sc->flags & SCF_FROZEN) {
 			wait_event_interruptible_timeout(
 				dd->event_queue,
-				!(ACCESS_ONCE(dd->flags) & HFI1_FROZEN),
+				!(READ_ONCE(dd->flags) & HFI1_FROZEN),
 				msecs_to_jiffies(SEND_CTXT_HALT_TIMEOUT));
 			if (dd->flags & HFI1_FROZEN)
 				return -ENOLCK;
diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 7108a4b5e94c..75e740780285 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -1423,14 +1423,14 @@ struct pio_buf *sc_buffer_alloc(struct send_context *sc, u32 dw_len,
 			goto done;
 		}
 		/* copy from receiver cache line and recalculate */
-		sc->alloc_free = ACCESS_ONCE(sc->free);
+		sc->alloc_free = READ_ONCE(sc->free);
 		avail =
 			(unsigned long)sc->credits -
 			(sc->fill - sc->alloc_free);
 		if (blocks > avail) {
 			/* still no room, actively update */
 			sc_release_update(sc);
-			sc->alloc_free = ACCESS_ONCE(sc->free);
+			sc->alloc_free = READ_ONCE(sc->free);
 			trycount++;
 			goto retry;
 		}
@@ -1667,7 +1667,7 @@ void sc_release_update(struct send_context *sc)
 
 	/* call sent buffer callbacks */
 	code = -1;				/* code not yet set */
-	head = ACCESS_ONCE(sc->sr_head);	/* snapshot the head */
+	head = READ_ONCE(sc->sr_head);	/* snapshot the head */
 	tail = sc->sr_tail;
 	while (head != tail) {
 		pbuf = &sc->sr[tail].pbuf;
diff --git a/drivers/infiniband/hw/hfi1/ruc.c b/drivers/infiniband/hw/hfi1/ruc.c
index b3291f0fde9a..a7fc664f0d4e 100644
--- a/drivers/infiniband/hw/hfi1/ruc.c
+++ b/drivers/infiniband/hw/hfi1/ruc.c
@@ -363,7 +363,7 @@ static void ruc_loopback(struct rvt_qp *sqp)
 
 again:
 	smp_read_barrier_depends(); /* see post_one_send() */
-	if (sqp->s_last == ACCESS_ONCE(sqp->s_head))
+	if (sqp->s_last == READ_ONCE(sqp->s_head))
 		goto clr_busy;
 	wqe = rvt_get_swqe_ptr(sqp, sqp->s_last);
 
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 6781bcdb10b3..08346d25441c 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1725,7 +1725,7 @@ static inline u16 sdma_gethead(struct sdma_engine *sde)
 
 		swhead = sde->descq_head & sde->sdma_mask;
 		/* this code is really bad for cache line trading */
-		swtail = ACCESS_ONCE(sde->descq_tail) & sde->sdma_mask;
+		swtail = READ_ONCE(sde->descq_tail) & sde->sdma_mask;
 		cnt = sde->descq_cnt;
 
 		if (swhead < swtail)
@@ -1872,7 +1872,7 @@ static void sdma_make_progress(struct sdma_engine *sde, u64 status)
 	if ((status & sde->idle_mask) && !idle_check_done) {
 		u16 swtail;
 
-		swtail = ACCESS_ONCE(sde->descq_tail) & sde->sdma_mask;
+		swtail = READ_ONCE(sde->descq_tail) & sde->sdma_mask;
 		if (swtail != hwhead) {
 			hwhead = (u16)read_sde_csr(sde, SD(HEAD));
 			idle_check_done = 1;
@@ -2222,7 +2222,7 @@ void sdma_seqfile_dump_sde(struct seq_file *s, struct sdma_engine *sde)
 	u16 len;
 
 	head = sde->descq_head & sde->sdma_mask;
-	tail = ACCESS_ONCE(sde->descq_tail) & sde->sdma_mask;
+	tail = READ_ONCE(sde->descq_tail) & sde->sdma_mask;
 	seq_printf(s, SDE_FMT, sde->this_idx,
 		   sde->cpu,
 		   sdma_state_name(sde->state.current_state),
@@ -3305,7 +3305,7 @@ int sdma_ahg_alloc(struct sdma_engine *sde)
 		return -EINVAL;
 	}
 	while (1) {
-		nr = ffz(ACCESS_ONCE(sde->ahg_bits));
+		nr = ffz(READ_ONCE(sde->ahg_bits));
 		if (nr > 31) {
 			trace_hfi1_ahg_allocate(sde, -ENOSPC);
 			return -ENOSPC;
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 107011d8613b..374c59784950 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -445,7 +445,7 @@ static inline u16 sdma_descq_freecnt(struct sdma_engine *sde)
 {
 	return sde->descq_cnt -
 		(sde->descq_tail -
-		 ACCESS_ONCE(sde->descq_head)) - 1;
+		 READ_ONCE(sde->descq_head)) - 1;
 }
 
 static inline u16 sdma_descq_inprocess(struct sdma_engine *sde)
diff --git a/drivers/infiniband/hw/hfi1/uc.c b/drivers/infiniband/hw/hfi1/uc.c
index 0b646173ca22..9a31c585427f 100644
--- a/drivers/infiniband/hw/hfi1/uc.c
+++ b/drivers/infiniband/hw/hfi1/uc.c
@@ -80,7 +80,7 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			goto bail;
 		/* We are in the error state, flush the work request. */
 		smp_read_barrier_depends(); /* see post_one_send() */
-		if (qp->s_last == ACCESS_ONCE(qp->s_head))
+		if (qp->s_last == READ_ONCE(qp->s_head))
 			goto bail;
 		/* If DMAs are in progress, we can't flush immediately. */
 		if (iowait_sdma_pending(&priv->s_iowait)) {
@@ -121,7 +121,7 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			goto bail;
 		/* Check if send work queue is empty. */
 		smp_read_barrier_depends(); /* see post_one_send() */
-		if (qp->s_cur == ACCESS_ONCE(qp->s_head)) {
+		if (qp->s_cur == READ_ONCE(qp->s_head)) {
 			clear_ahg(qp);
 			goto bail;
 		}
diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index 2ba74fdd6f15..7fec6b984e3e 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -487,7 +487,7 @@ int hfi1_make_ud_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			goto bail;
 		/* We are in the error state, flush the work request. */
 		smp_read_barrier_depends(); /* see post_one_send */
-		if (qp->s_last == ACCESS_ONCE(qp->s_head))
+		if (qp->s_last == READ_ONCE(qp->s_head))
 			goto bail;
 		/* If DMAs are in progress, we can't flush immediately. */
 		if (iowait_sdma_pending(&priv->s_iowait)) {
@@ -501,7 +501,7 @@ int hfi1_make_ud_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 
 	/* see post_one_send() */
 	smp_read_barrier_depends();
-	if (qp->s_cur == ACCESS_ONCE(qp->s_head))
+	if (qp->s_cur == READ_ONCE(qp->s_head))
 		goto bail;
 
 	wqe = rvt_get_swqe_ptr(qp, qp->s_cur);
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index c0c0e0445cbf..8ec6e8a8d6f7 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -276,7 +276,7 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 		/* Wait until all requests have been freed. */
 		wait_event_interruptible(
 			pq->wait,
-			(ACCESS_ONCE(pq->state) == SDMA_PKT_Q_INACTIVE));
+			(READ_ONCE(pq->state) == SDMA_PKT_Q_INACTIVE));
 		kfree(pq->reqs);
 		kfree(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
@@ -591,7 +591,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 			if (ret != -EBUSY) {
 				req->status = ret;
 				WRITE_ONCE(req->has_error, 1);
-				if (ACCESS_ONCE(req->seqcomp) ==
+				if (READ_ONCE(req->seqcomp) ==
 				    req->seqsubmitted - 1)
 					goto free_req;
 				return ret;
@@ -825,7 +825,7 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, unsigned maxpkts)
 		 */
 		if (req->data_len) {
 			iovec = &req->iovs[req->iov_idx];
-			if (ACCESS_ONCE(iovec->offset) == iovec->iov.iov_len) {
+			if (READ_ONCE(iovec->offset) == iovec->iov.iov_len) {
 				if (++req->iov_idx == req->data_iovs) {
 					ret = -EFAULT;
 					goto free_txreq;
@@ -1390,7 +1390,7 @@ static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 	} else {
 		if (status != SDMA_TXREQ_S_OK)
 			req->status = status;
-		if (req->seqcomp == (ACCESS_ONCE(req->seqsubmitted) - 1) &&
+		if (req->seqcomp == (READ_ONCE(req->seqsubmitted) - 1) &&
 		    (READ_ONCE(req->done) ||
 		     READ_ONCE(req->has_error))) {
 			user_sdma_free_request(req, false);
diff --git a/drivers/infiniband/hw/qib/qib_ruc.c b/drivers/infiniband/hw/qib/qib_ruc.c
index 53efbb0b40c4..9a37e844d4c8 100644
--- a/drivers/infiniband/hw/qib/qib_ruc.c
+++ b/drivers/infiniband/hw/qib/qib_ruc.c
@@ -368,7 +368,7 @@ static void qib_ruc_loopback(struct rvt_qp *sqp)
 
 again:
 	smp_read_barrier_depends(); /* see post_one_send() */
-	if (sqp->s_last == ACCESS_ONCE(sqp->s_head))
+	if (sqp->s_last == READ_ONCE(sqp->s_head))
 		goto clr_busy;
 	wqe = rvt_get_swqe_ptr(sqp, sqp->s_last);
 
diff --git a/drivers/infiniband/hw/qib/qib_uc.c b/drivers/infiniband/hw/qib/qib_uc.c
index 498e2202e72c..bddcc37ace44 100644
--- a/drivers/infiniband/hw/qib/qib_uc.c
+++ b/drivers/infiniband/hw/qib/qib_uc.c
@@ -61,7 +61,7 @@ int qib_make_uc_req(struct rvt_qp *qp, unsigned long *flags)
 			goto bail;
 		/* We are in the error state, flush the work request. */
 		smp_read_barrier_depends(); /* see post_one_send() */
-		if (qp->s_last == ACCESS_ONCE(qp->s_head))
+		if (qp->s_last == READ_ONCE(qp->s_head))
 			goto bail;
 		/* If DMAs are in progress, we can't flush immediately. */
 		if (atomic_read(&priv->s_dma_busy)) {
@@ -91,7 +91,7 @@ int qib_make_uc_req(struct rvt_qp *qp, unsigned long *flags)
 			goto bail;
 		/* Check if send work queue is empty. */
 		smp_read_barrier_depends(); /* see post_one_send() */
-		if (qp->s_cur == ACCESS_ONCE(qp->s_head))
+		if (qp->s_cur == READ_ONCE(qp->s_head))
 			goto bail;
 		/*
 		 * Start a new request.
diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index be4907453ac4..15962ed193ce 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -253,7 +253,7 @@ int qib_make_ud_req(struct rvt_qp *qp, unsigned long *flags)
 			goto bail;
 		/* We are in the error state, flush the work request. */
 		smp_read_barrier_depends(); /* see post_one_send */
-		if (qp->s_last == ACCESS_ONCE(qp->s_head))
+		if (qp->s_last == READ_ONCE(qp->s_head))
 			goto bail;
 		/* If DMAs are in progress, we can't flush immediately. */
 		if (atomic_read(&priv->s_dma_busy)) {
@@ -267,7 +267,7 @@ int qib_make_ud_req(struct rvt_qp *qp, unsigned long *flags)
 
 	/* see post_one_send() */
 	smp_read_barrier_depends();
-	if (qp->s_cur == ACCESS_ONCE(qp->s_head))
+	if (qp->s_cur == READ_ONCE(qp->s_head))
 		goto bail;
 
 	wqe = rvt_get_swqe_ptr(qp, qp->s_cur);
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 22df09ae809e..b670cb9d2006 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1073,7 +1073,7 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
 	rdi->driver_f.notify_error_qp(qp);
 
 	/* Schedule the sending tasklet to drain the send work queue. */
-	if (ACCESS_ONCE(qp->s_last) != qp->s_head)
+	if (READ_ONCE(qp->s_last) != qp->s_head)
 		rdi->driver_f.schedule_send(qp);
 
 	rvt_clear_mr_refs(qp, 0);
@@ -1686,7 +1686,7 @@ static inline int rvt_qp_is_avail(
 	if (likely(qp->s_avail))
 		return 0;
 	smp_read_barrier_depends(); /* see rc.c */
-	slast = ACCESS_ONCE(qp->s_last);
+	slast = READ_ONCE(qp->s_last);
 	if (qp->s_head >= slast)
 		avail = qp->s_size - (qp->s_head - slast);
 	else
@@ -1917,7 +1917,7 @@ int rvt_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 	 * ahead and kick the send engine into gear. Otherwise we will always
 	 * just schedule the send to happen later.
 	 */
-	call_send = qp->s_head == ACCESS_ONCE(qp->s_last) && !wr->next;
+	call_send = qp->s_head == READ_ONCE(qp->s_last) && !wr->next;
 
 	for (; wr; wr = wr->next) {
 		err = rvt_post_one_wr(qp, wr, &call_send);
diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index 2e8f801932be..a1db1e5040dc 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -233,7 +233,7 @@ static int __maybe_unused regulator_haptic_resume(struct device *dev)
 
 	haptic->suspended = false;
 
-	magnitude = ACCESS_ONCE(haptic->magnitude);
+	magnitude = READ_ONCE(haptic->magnitude);
 	if (magnitude)
 		regulator_haptic_set_voltage(haptic, magnitude);
 
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index d216a8f7bc22..33bb074d6941 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -347,7 +347,7 @@ static void __cache_size_refresh(void)
 	BUG_ON(!mutex_is_locked(&dm_bufio_clients_lock));
 	BUG_ON(dm_bufio_client_count < 0);
 
-	dm_bufio_cache_size_latch = ACCESS_ONCE(dm_bufio_cache_size);
+	dm_bufio_cache_size_latch = READ_ONCE(dm_bufio_cache_size);
 
 	/*
 	 * Use default if set to 0 and report the actual cache size used.
@@ -960,7 +960,7 @@ static void __get_memory_limit(struct dm_bufio_client *c,
 {
 	unsigned long buffers;
 
-	if (unlikely(ACCESS_ONCE(dm_bufio_cache_size) != dm_bufio_cache_size_latch)) {
+	if (unlikely(READ_ONCE(dm_bufio_cache_size) != dm_bufio_cache_size_latch)) {
 		if (mutex_trylock(&dm_bufio_clients_lock)) {
 			__cache_size_refresh();
 			mutex_unlock(&dm_bufio_clients_lock);
@@ -1600,7 +1600,7 @@ static bool __try_evict_buffer(struct dm_buffer *b, gfp_t gfp)
 
 static unsigned long get_retain_buffers(struct dm_bufio_client *c)
 {
-        unsigned long retain_bytes = ACCESS_ONCE(dm_bufio_retain_bytes);
+        unsigned long retain_bytes = READ_ONCE(dm_bufio_retain_bytes);
         return retain_bytes >> (c->sectors_per_block_bits + SECTOR_SHIFT);
 }
 
@@ -1647,7 +1647,7 @@ dm_bufio_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct dm_bufio_client *c = container_of(shrink, struct dm_bufio_client, shrinker);
 
-	return ACCESS_ONCE(c->n_buffers[LIST_CLEAN]) + ACCESS_ONCE(c->n_buffers[LIST_DIRTY]);
+	return READ_ONCE(c->n_buffers[LIST_CLEAN]) + READ_ONCE(c->n_buffers[LIST_DIRTY]);
 }
 
 /*
@@ -1818,7 +1818,7 @@ EXPORT_SYMBOL_GPL(dm_bufio_set_sector_offset);
 
 static unsigned get_max_age_hz(void)
 {
-	unsigned max_age = ACCESS_ONCE(dm_bufio_max_age);
+	unsigned max_age = READ_ONCE(dm_bufio_max_age);
 
 	if (max_age > UINT_MAX / HZ)
 		max_age = UINT_MAX / HZ;
diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index cf2c67e35eaf..eb45cc3df31d 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -107,7 +107,7 @@ static void io_job_start(struct dm_kcopyd_throttle *t)
 try_again:
 	spin_lock_irq(&throttle_spinlock);
 
-	throttle = ACCESS_ONCE(t->throttle);
+	throttle = READ_ONCE(t->throttle);
 
 	if (likely(throttle >= 100))
 		goto skip_limit;
@@ -157,7 +157,7 @@ static void io_job_finish(struct dm_kcopyd_throttle *t)
 
 	t->num_io_jobs--;
 
-	if (likely(ACCESS_ONCE(t->throttle) >= 100))
+	if (likely(READ_ONCE(t->throttle) >= 100))
 		goto skip_limit;
 
 	if (!t->num_io_jobs) {
diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index 6028d8247f58..a1a5eec783cc 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -431,7 +431,7 @@ static int dm_stats_delete(struct dm_stats *stats, int id)
 		synchronize_rcu_expedited();
 		dm_stat_free(&s->rcu_head);
 	} else {
-		ACCESS_ONCE(dm_stat_need_rcu_barrier) = 1;
+		WRITE_ONCE(dm_stat_need_rcu_barrier, 1);
 		call_rcu(&s->rcu_head, dm_stat_free);
 	}
 	return 0;
@@ -639,12 +639,12 @@ void dm_stats_account_io(struct dm_stats *stats, unsigned long bi_rw,
 		 */
 		last = raw_cpu_ptr(stats->last);
 		stats_aux->merged =
-			(bi_sector == (ACCESS_ONCE(last->last_sector) &&
+			(bi_sector == (READ_ONCE(last->last_sector) &&
 				       ((bi_rw == WRITE) ==
-					(ACCESS_ONCE(last->last_rw) == WRITE))
+					(READ_ONCE(last->last_rw) == WRITE))
 				       ));
-		ACCESS_ONCE(last->last_sector) = end_sector;
-		ACCESS_ONCE(last->last_rw) = bi_rw;
+		WRITE_ONCE(last->last_sector, end_sector);
+		WRITE_ONCE(last->last_rw, bi_rw);
 	}
 
 	rcu_read_lock();
@@ -693,22 +693,22 @@ static void __dm_stat_init_temporary_percpu_totals(struct dm_stat_shared *shared
 
 	for_each_possible_cpu(cpu) {
 		p = &s->stat_percpu[cpu][x];
-		shared->tmp.sectors[READ] += ACCESS_ONCE(p->sectors[READ]);
-		shared->tmp.sectors[WRITE] += ACCESS_ONCE(p->sectors[WRITE]);
-		shared->tmp.ios[READ] += ACCESS_ONCE(p->ios[READ]);
-		shared->tmp.ios[WRITE] += ACCESS_ONCE(p->ios[WRITE]);
-		shared->tmp.merges[READ] += ACCESS_ONCE(p->merges[READ]);
-		shared->tmp.merges[WRITE] += ACCESS_ONCE(p->merges[WRITE]);
-		shared->tmp.ticks[READ] += ACCESS_ONCE(p->ticks[READ]);
-		shared->tmp.ticks[WRITE] += ACCESS_ONCE(p->ticks[WRITE]);
-		shared->tmp.io_ticks[READ] += ACCESS_ONCE(p->io_ticks[READ]);
-		shared->tmp.io_ticks[WRITE] += ACCESS_ONCE(p->io_ticks[WRITE]);
-		shared->tmp.io_ticks_total += ACCESS_ONCE(p->io_ticks_total);
-		shared->tmp.time_in_queue += ACCESS_ONCE(p->time_in_queue);
+		shared->tmp.sectors[READ] += READ_ONCE(p->sectors[READ]);
+		shared->tmp.sectors[WRITE] += READ_ONCE(p->sectors[WRITE]);
+		shared->tmp.ios[READ] += READ_ONCE(p->ios[READ]);
+		shared->tmp.ios[WRITE] += READ_ONCE(p->ios[WRITE]);
+		shared->tmp.merges[READ] += READ_ONCE(p->merges[READ]);
+		shared->tmp.merges[WRITE] += READ_ONCE(p->merges[WRITE]);
+		shared->tmp.ticks[READ] += READ_ONCE(p->ticks[READ]);
+		shared->tmp.ticks[WRITE] += READ_ONCE(p->ticks[WRITE]);
+		shared->tmp.io_ticks[READ] += READ_ONCE(p->io_ticks[READ]);
+		shared->tmp.io_ticks[WRITE] += READ_ONCE(p->io_ticks[WRITE]);
+		shared->tmp.io_ticks_total += READ_ONCE(p->io_ticks_total);
+		shared->tmp.time_in_queue += READ_ONCE(p->time_in_queue);
 		if (s->n_histogram_entries) {
 			unsigned i;
 			for (i = 0; i < s->n_histogram_entries + 1; i++)
-				shared->tmp.histogram[i] += ACCESS_ONCE(p->histogram[i]);
+				shared->tmp.histogram[i] += READ_ONCE(p->histogram[i]);
 		}
 	}
 }
diff --git a/drivers/md/dm-switch.c b/drivers/md/dm-switch.c
index 4c8de1ff78ca..8d0ba879777e 100644
--- a/drivers/md/dm-switch.c
+++ b/drivers/md/dm-switch.c
@@ -144,7 +144,7 @@ static unsigned switch_region_table_read(struct switch_ctx *sctx, unsigned long
 
 	switch_get_position(sctx, region_nr, &region_index, &bit);
 
-	return (ACCESS_ONCE(sctx->region_table[region_index]) >> bit) &
+	return (READ_ONCE(sctx->region_table[region_index]) >> bit) &
 		((1 << sctx->region_table_entry_bits) - 1);
 }
 
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 1e25705209c2..89e5dff9b4cf 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2431,7 +2431,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 	struct pool_c *pt = pool->ti->private;
 	bool needs_check = dm_pool_metadata_needs_check(pool->pmd);
 	enum pool_mode old_mode = get_pool_mode(pool);
-	unsigned long no_space_timeout = ACCESS_ONCE(no_space_timeout_secs) * HZ;
+	unsigned long no_space_timeout = READ_ONCE(no_space_timeout_secs) * HZ;
 
 	/*
 	 * Never allow the pool to transition to PM_WRITE mode if user
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index bda3caca23ca..fba93237a780 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -589,7 +589,7 @@ static void verity_prefetch_io(struct work_struct *work)
 		verity_hash_at_level(v, pw->block, i, &hash_block_start, NULL);
 		verity_hash_at_level(v, pw->block + pw->n_blocks - 1, i, &hash_block_end, NULL);
 		if (!i) {
-			unsigned cluster = ACCESS_ONCE(dm_verity_prefetch_cluster);
+			unsigned cluster = READ_ONCE(dm_verity_prefetch_cluster);
 
 			cluster >>= v->data_dev_block_bits;
 			if (unlikely(!cluster))
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4be85324f44d..8aaffa19b29a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -114,7 +114,7 @@ static unsigned reserved_bio_based_ios = RESERVED_BIO_BASED_IOS;
 
 static int __dm_get_module_param_int(int *module_param, int min, int max)
 {
-	int param = ACCESS_ONCE(*module_param);
+	int param = READ_ONCE(*module_param);
 	int modified_param = 0;
 	bool modified = true;
 
@@ -136,7 +136,7 @@ static int __dm_get_module_param_int(int *module_param, int min, int max)
 unsigned __dm_get_module_param(unsigned *module_param,
 			       unsigned def, unsigned max)
 {
-	unsigned param = ACCESS_ONCE(*module_param);
+	unsigned param = READ_ONCE(*module_param);
 	unsigned modified_param = 0;
 
 	if (!param)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0ff1bbf6c90e..447ddcbc9566 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2651,7 +2651,7 @@ state_show(struct md_rdev *rdev, char *page)
 {
 	char *sep = ",";
 	size_t len = 0;
-	unsigned long flags = ACCESS_ONCE(rdev->flags);
+	unsigned long flags = READ_ONCE(rdev->flags);
 
 	if (test_bit(Faulty, &flags) ||
 	    (!test_bit(ExternalBbl, &flags) &&
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 928e24a07133..7d9a50eed9db 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6072,7 +6072,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 	 */
 	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = ACCESS_ONCE(conf->disks[i].rdev);
+		struct md_rdev *rdev = READ_ONCE(conf->disks[i].rdev);
 
 		if (rdev == NULL || test_bit(Faulty, &rdev->flags))
 			still_degraded = 1;
diff --git a/drivers/misc/mic/scif/scif_rb.c b/drivers/misc/mic/scif/scif_rb.c
index 637cc4686742..b665757ca89a 100644
--- a/drivers/misc/mic/scif/scif_rb.c
+++ b/drivers/misc/mic/scif/scif_rb.c
@@ -138,7 +138,7 @@ void scif_rb_commit(struct scif_rb *rb)
 	 * the read barrier in scif_rb_count(..)
 	 */
 	wmb();
-	ACCESS_ONCE(*rb->write_ptr) = rb->current_write_offset;
+	WRITE_ONCE(*rb->write_ptr, rb->current_write_offset);
 #ifdef CONFIG_INTEL_MIC_CARD
 	/*
 	 * X100 Si bug: For the case where a Core is performing an EXT_WR
@@ -147,7 +147,7 @@ void scif_rb_commit(struct scif_rb *rb)
 	 * This way, if ordering is violated for the Interrupt Message, it will
 	 * fall just behind the first Posted associated with the first EXT_WR.
 	 */
-	ACCESS_ONCE(*rb->write_ptr) = rb->current_write_offset;
+	WRITE_ONCE(*rb->write_ptr, rb->current_write_offset);
 #endif
 }
 
@@ -210,7 +210,7 @@ void scif_rb_update_read_ptr(struct scif_rb *rb)
 	 * scif_rb_space(..)
 	 */
 	mb();
-	ACCESS_ONCE(*rb->read_ptr) = new_offset;
+	WRITE_ONCE(*rb->read_ptr, new_offset);
 #ifdef CONFIG_INTEL_MIC_CARD
 	/*
 	 * X100 Si Bug: For the case where a Core is performing an EXT_WR
@@ -219,7 +219,7 @@ void scif_rb_update_read_ptr(struct scif_rb *rb)
 	 * This way, if ordering is violated for the Interrupt Message, it will
 	 * fall just behind the first Posted associated with the first EXT_WR.
 	 */
-	ACCESS_ONCE(*rb->read_ptr) = new_offset;
+	WRITE_ONCE(*rb->read_ptr, new_offset);
 #endif
 }
 
diff --git a/drivers/misc/mic/scif/scif_rma_list.c b/drivers/misc/mic/scif/scif_rma_list.c
index e1ef8daedd5a..a036dbb4101e 100644
--- a/drivers/misc/mic/scif/scif_rma_list.c
+++ b/drivers/misc/mic/scif/scif_rma_list.c
@@ -277,7 +277,7 @@ int scif_unregister_all_windows(scif_epd_t epd)
 		 * Need to restart list traversal if there has been
 		 * an asynchronous list entry deletion.
 		 */
-		if (ACCESS_ONCE(ep->rma_info.async_list_del))
+		if (READ_ONCE(ep->rma_info.async_list_del))
 			goto retry;
 	}
 	mutex_unlock(&ep->rma_info.rma_lock);
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index c02cc817a490..1ed9529e7bd1 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1378,7 +1378,7 @@ int bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 				unsigned int count;
 
 				slaves = rcu_dereference(bond->slave_arr);
-				count = slaves ? ACCESS_ONCE(slaves->count) : 0;
+				count = slaves ? READ_ONCE(slaves->count) : 0;
 				if (likely(count))
 					tx_slave = slaves->arr[hash_index %
 							       count];
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c99dc59d729b..af51b90cecbb 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1167,7 +1167,7 @@ static rx_handler_result_t bond_handle_frame(struct sk_buff **pskb)
 	slave = bond_slave_get_rcu(skb->dev);
 	bond = slave->bond;
 
-	recv_probe = ACCESS_ONCE(bond->recv_probe);
+	recv_probe = READ_ONCE(bond->recv_probe);
 	if (recv_probe) {
 		ret = recv_probe(skb, bond, slave);
 		if (ret == RX_HANDLER_CONSUMED) {
@@ -3810,7 +3810,7 @@ static int bond_xmit_roundrobin(struct sk_buff *skb, struct net_device *bond_dev
 		else
 			bond_xmit_slave_id(bond, skb, 0);
 	} else {
-		int slave_cnt = ACCESS_ONCE(bond->slave_cnt);
+		int slave_cnt = READ_ONCE(bond->slave_cnt);
 
 		if (likely(slave_cnt)) {
 			slave_id = bond_rr_gen_slave_id(bond);
@@ -3972,7 +3972,7 @@ static int bond_3ad_xor_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int count;
 
 	slaves = rcu_dereference(bond->slave_arr);
-	count = slaves ? ACCESS_ONCE(slaves->count) : 0;
+	count = slaves ? READ_ONCE(slaves->count) : 0;
 	if (likely(count)) {
 		slave = slaves->arr[bond_xmit_hash(bond, skb) % count];
 		bond_dev_queue_xmit(bond, skb, slave->dev);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 4ef68f69b58c..43f52a8fe708 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -405,7 +405,7 @@ void free_tx_desc(struct adapter *adap, struct sge_txq *q,
  */
 static inline int reclaimable(const struct sge_txq *q)
 {
-	int hw_cidx = ntohs(ACCESS_ONCE(q->stat->cidx));
+	int hw_cidx = ntohs(READ_ONCE(q->stat->cidx));
 	hw_cidx -= q->cidx;
 	return hw_cidx < 0 ? hw_cidx + q->size : hw_cidx;
 }
@@ -1375,7 +1375,7 @@ out_free:	dev_kfree_skb_any(skb);
  */
 static inline void reclaim_completed_tx_imm(struct sge_txq *q)
 {
-	int hw_cidx = ntohs(ACCESS_ONCE(q->stat->cidx));
+	int hw_cidx = ntohs(READ_ONCE(q->stat->cidx));
 	int reclaim = hw_cidx - q->cidx;
 
 	if (reclaim < 0)
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 0e3d9f39a807..c6e859a27ee6 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -605,7 +605,7 @@ static void accumulate_16bit_val(u32 *acc, u16 val)
 
 	if (wrapped)
 		newacc += 65536;
-	ACCESS_ONCE(*acc) = newacc;
+	WRITE_ONCE(*acc, newacc);
 }
 
 static void populate_erx_stats(struct be_adapter *adapter,
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 0cec06bec63e..340e28211135 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -373,7 +373,7 @@ static int hip04_tx_reclaim(struct net_device *ndev, bool force)
 	unsigned int count;
 
 	smp_rmb();
-	count = tx_count(ACCESS_ONCE(priv->tx_head), tx_tail);
+	count = tx_count(READ_ONCE(priv->tx_head), tx_tail);
 	if (count == 0)
 		goto out;
 
@@ -431,7 +431,7 @@ static int hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	dma_addr_t phys;
 
 	smp_rmb();
-	count = tx_count(tx_head, ACCESS_ONCE(priv->tx_tail));
+	count = tx_count(tx_head, READ_ONCE(priv->tx_tail));
 	if (count == (TX_DESC_NUM - 1)) {
 		netif_stop_queue(ndev);
 		return NETDEV_TX_BUSY;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 8f326f87a815..2cb9539c931e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -264,7 +264,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		 vsi->rx_buf_failed, vsi->rx_page_failed);
 	rcu_read_lock();
 	for (i = 0; i < vsi->num_queue_pairs; i++) {
-		struct i40e_ring *rx_ring = ACCESS_ONCE(vsi->rx_rings[i]);
+		struct i40e_ring *rx_ring = READ_ONCE(vsi->rx_rings[i]);
 
 		if (!rx_ring)
 			continue;
@@ -320,7 +320,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 ITR_IS_DYNAMIC(rx_ring->rx_itr_setting) ? "dynamic" : "fixed");
 	}
 	for (i = 0; i < vsi->num_queue_pairs; i++) {
-		struct i40e_ring *tx_ring = ACCESS_ONCE(vsi->tx_rings[i]);
+		struct i40e_ring *tx_ring = READ_ONCE(vsi->tx_rings[i]);
 
 		if (!tx_ring)
 			continue;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 05e89864f781..e9e04a485e0a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1570,7 +1570,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	}
 	rcu_read_lock();
 	for (j = 0; j < vsi->num_queue_pairs; j++) {
-		tx_ring = ACCESS_ONCE(vsi->tx_rings[j]);
+		tx_ring = READ_ONCE(vsi->tx_rings[j]);
 
 		if (!tx_ring)
 			continue;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6498da8806cb..de1fcac7834d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -455,7 +455,7 @@ static void i40e_get_netdev_stats_struct(struct net_device *netdev,
 		u64 bytes, packets;
 		unsigned int start;
 
-		tx_ring = ACCESS_ONCE(vsi->tx_rings[i]);
+		tx_ring = READ_ONCE(vsi->tx_rings[i]);
 		if (!tx_ring)
 			continue;
 		i40e_get_netdev_stats_struct_tx(tx_ring, stats);
@@ -791,7 +791,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	rcu_read_lock();
 	for (q = 0; q < vsi->num_queue_pairs; q++) {
 		/* locate Tx ring */
-		p = ACCESS_ONCE(vsi->tx_rings[q]);
+		p = READ_ONCE(vsi->tx_rings[q]);
 
 		do {
 			start = u64_stats_fetch_begin_irq(&p->syncp);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index d8456c381c99..97381238eb7c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -130,7 +130,7 @@ static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 	}
 
 	smp_mb(); /* Force any pending update before accessing. */
-	adj = ACCESS_ONCE(pf->ptp_base_adj);
+	adj = READ_ONCE(pf->ptp_base_adj);
 
 	freq = adj;
 	freq *= ppb;
@@ -499,7 +499,7 @@ void i40e_ptp_set_increment(struct i40e_pf *pf)
 	wr32(hw, I40E_PRTTSYN_INC_H, incval >> 32);
 
 	/* Update the base adjustement value. */
-	ACCESS_ONCE(pf->ptp_base_adj) = incval;
+	WRITE_ONCE(pf->ptp_base_adj, incval);
 	smp_mb(); /* Force the above update. */
 }
 
diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
index 58adbf234e07..31a3f09df9f7 100644
--- a/drivers/net/ethernet/intel/igb/e1000_regs.h
+++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
@@ -375,7 +375,7 @@ u32 igb_rd32(struct e1000_hw *hw, u32 reg);
 /* write operations, indexed using DWORDS */
 #define wr32(reg, val) \
 do { \
-	u8 __iomem *hw_addr = ACCESS_ONCE((hw)->hw_addr); \
+	u8 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
 	if (!E1000_REMOVED(hw_addr)) \
 		writel((val), &hw_addr[(reg)]); \
 } while (0)
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index fd4a46b03cc8..6bccc2be2b91 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -750,7 +750,7 @@ static void igb_cache_ring_register(struct igb_adapter *adapter)
 u32 igb_rd32(struct e1000_hw *hw, u32 reg)
 {
 	struct igb_adapter *igb = container_of(hw, struct igb_adapter, hw);
-	u8 __iomem *hw_addr = ACCESS_ONCE(hw->hw_addr);
+	u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
 	u32 value = 0;
 
 	if (E1000_REMOVED(hw_addr))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index e083732adf64..a01409e2e06c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -161,7 +161,7 @@ static inline bool ixgbe_removed(void __iomem *addr)
 
 static inline void ixgbe_write_reg(struct ixgbe_hw *hw, u32 reg, u32 value)
 {
-	u8 __iomem *reg_addr = ACCESS_ONCE(hw->hw_addr);
+	u8 __iomem *reg_addr = READ_ONCE(hw->hw_addr);
 
 	if (ixgbe_removed(reg_addr))
 		return;
@@ -180,7 +180,7 @@ static inline void writeq(u64 val, void __iomem *addr)
 
 static inline void ixgbe_write_reg64(struct ixgbe_hw *hw, u32 reg, u64 value)
 {
-	u8 __iomem *reg_addr = ACCESS_ONCE(hw->hw_addr);
+	u8 __iomem *reg_addr = READ_ONCE(hw->hw_addr);
 
 	if (ixgbe_removed(reg_addr))
 		return;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d962368d08d0..df2c8ecafcf4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -380,7 +380,7 @@ static void ixgbe_check_remove(struct ixgbe_hw *hw, u32 reg)
  */
 u32 ixgbe_read_reg(struct ixgbe_hw *hw, u32 reg)
 {
-	u8 __iomem *reg_addr = ACCESS_ONCE(hw->hw_addr);
+	u8 __iomem *reg_addr = READ_ONCE(hw->hw_addr);
 	u32 value;
 
 	if (ixgbe_removed(reg_addr))
@@ -8626,7 +8626,7 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 
 	rcu_read_lock();
 	for (i = 0; i < adapter->num_rx_queues; i++) {
-		struct ixgbe_ring *ring = ACCESS_ONCE(adapter->rx_ring[i]);
+		struct ixgbe_ring *ring = READ_ONCE(adapter->rx_ring[i]);
 		u64 bytes, packets;
 		unsigned int start;
 
@@ -8642,12 +8642,12 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 	}
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
-		struct ixgbe_ring *ring = ACCESS_ONCE(adapter->tx_ring[i]);
+		struct ixgbe_ring *ring = READ_ONCE(adapter->tx_ring[i]);
 
 		ixgbe_get_ring_stats64(stats, ring);
 	}
 	for (i = 0; i < adapter->num_xdp_queues; i++) {
-		struct ixgbe_ring *ring = ACCESS_ONCE(adapter->xdp_ring[i]);
+		struct ixgbe_ring *ring = READ_ONCE(adapter->xdp_ring[i]);
 
 		ixgbe_get_ring_stats64(stats, ring);
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 86d6924a2b71..ae312c45696a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -378,7 +378,7 @@ static int ixgbe_ptp_adjfreq_82599(struct ptp_clock_info *ptp, s32 ppb)
 	}
 
 	smp_mb();
-	incval = ACCESS_ONCE(adapter->base_incval);
+	incval = READ_ONCE(adapter->base_incval);
 
 	freq = incval;
 	freq *= ppb;
@@ -1159,7 +1159,7 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 	}
 
 	/* update the base incval used to calculate frequency adjustment */
-	ACCESS_ONCE(adapter->base_incval) = incval;
+	WRITE_ONCE(adapter->base_incval, incval);
 	smp_mb();
 
 	/* need lock to prevent incorrect read while modifying cyclecounter */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 032f8ac06357..cacb30682434 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -164,7 +164,7 @@ static void ixgbevf_check_remove(struct ixgbe_hw *hw, u32 reg)
 
 u32 ixgbevf_read_reg(struct ixgbe_hw *hw, u32 reg)
 {
-	u8 __iomem *reg_addr = ACCESS_ONCE(hw->hw_addr);
+	u8 __iomem *reg_addr = READ_ONCE(hw->hw_addr);
 	u32 value;
 
 	if (IXGBE_REMOVED(reg_addr))
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index 04d8d4ee4f04..c651fefcc3d2 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -182,7 +182,7 @@ struct ixgbevf_info {
 
 static inline void ixgbe_write_reg(struct ixgbe_hw *hw, u32 reg, u32 value)
 {
-	u8 __iomem *reg_addr = ACCESS_ONCE(hw->hw_addr);
+	u8 __iomem *reg_addr = READ_ONCE(hw->hw_addr);
 
 	if (IXGBE_REMOVED(reg_addr))
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 8a32a8f7f9c0..3541a7f9d12e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -414,8 +414,8 @@ bool mlx4_en_process_tx_cq(struct net_device *dev,
 
 	index = cons_index & size_mask;
 	cqe = mlx4_en_get_cqe(buf, index, priv->cqe_size) + factor;
-	last_nr_txbb = ACCESS_ONCE(ring->last_nr_txbb);
-	ring_cons = ACCESS_ONCE(ring->cons);
+	last_nr_txbb = READ_ONCE(ring->last_nr_txbb);
+	ring_cons = READ_ONCE(ring->cons);
 	ring_index = ring_cons & size_mask;
 	stamp_index = ring_index;
 
@@ -479,8 +479,8 @@ bool mlx4_en_process_tx_cq(struct net_device *dev,
 	wmb();
 
 	/* we want to dirty this cache line once */
-	ACCESS_ONCE(ring->last_nr_txbb) = last_nr_txbb;
-	ACCESS_ONCE(ring->cons) = ring_cons + txbbs_skipped;
+	WRITE_ONCE(ring->last_nr_txbb, last_nr_txbb);
+	WRITE_ONCE(ring->cons, ring_cons + txbbs_skipped);
 
 	if (cq->type == TX_XDP)
 		return done < budget;
@@ -858,7 +858,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto tx_drop;
 
 	/* fetch ring->cons far ahead before needing it to avoid stall */
-	ring_cons = ACCESS_ONCE(ring->cons);
+	ring_cons = READ_ONCE(ring->cons);
 
 	real_size = get_real_size(skb, shinfo, dev, &lso_header_size,
 				  &inline_ok, &fragptr);
@@ -1066,7 +1066,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		 */
 		smp_rmb();
 
-		ring_cons = ACCESS_ONCE(ring->cons);
+		ring_cons = READ_ONCE(ring->cons);
 		if (unlikely(!mlx4_en_is_tx_ring_full(ring))) {
 			netif_tx_wake_queue(ring->tx_queue);
 			ring->wake_queue++;
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-main.c b/drivers/net/ethernet/neterion/vxge/vxge-main.c
index 50ea69d88480..5dd5f61e1114 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-main.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-main.c
@@ -2629,7 +2629,7 @@ static void vxge_poll_vp_lockup(unsigned long data)
 		ring = &vdev->vpaths[i].ring;
 
 		/* Truncated to machine word size number of frames */
-		rx_frms = ACCESS_ONCE(ring->stats.rx_frms);
+		rx_frms = READ_ONCE(ring->stats.rx_frms);
 
 		/* Did this vpath received any packets */
 		if (ring->stats.prev_rx_frms == rx_frms) {
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 13f72f5b18d2..a95a46bcd339 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -2073,7 +2073,7 @@ static irqreturn_t efx_ef10_msi_interrupt(int irq, void *dev_id)
 	netif_vdbg(efx, intr, efx->net_dev,
 		   "IRQ %d on CPU %d\n", irq, raw_smp_processor_id());
 
-	if (likely(ACCESS_ONCE(efx->irq_soft_enabled))) {
+	if (likely(READ_ONCE(efx->irq_soft_enabled))) {
 		/* Note test interrupts */
 		if (context->index == efx->irq_level)
 			efx->last_irq_cpu = raw_smp_processor_id();
@@ -2088,7 +2088,7 @@ static irqreturn_t efx_ef10_msi_interrupt(int irq, void *dev_id)
 static irqreturn_t efx_ef10_legacy_interrupt(int irq, void *dev_id)
 {
 	struct efx_nic *efx = dev_id;
-	bool soft_enabled = ACCESS_ONCE(efx->irq_soft_enabled);
+	bool soft_enabled = READ_ONCE(efx->irq_soft_enabled);
 	struct efx_channel *channel;
 	efx_dword_t reg;
 	u32 queues;
@@ -3291,7 +3291,7 @@ static int efx_ef10_handle_rx_event(struct efx_channel *channel,
 	bool rx_cont;
 	u16 flags = 0;
 
-	if (unlikely(ACCESS_ONCE(efx->reset_pending)))
+	if (unlikely(READ_ONCE(efx->reset_pending)))
 		return 0;
 
 	/* Basic packet information */
@@ -3428,7 +3428,7 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 	unsigned int tx_ev_q_label;
 	int tx_descs = 0;
 
-	if (unlikely(ACCESS_ONCE(efx->reset_pending)))
+	if (unlikely(READ_ONCE(efx->reset_pending)))
 		return 0;
 
 	if (unlikely(EFX_QWORD_FIELD(*event, ESF_DZ_TX_DROP_EVENT)))
@@ -5316,7 +5316,7 @@ static void efx_ef10_filter_remove_old(struct efx_nic *efx)
 	int i;
 
 	for (i = 0; i < HUNT_FILTER_TBL_ROWS; i++) {
-		if (ACCESS_ONCE(table->entry[i].spec) &
+		if (READ_ONCE(table->entry[i].spec) &
 		    EFX_EF10_FILTER_FLAG_AUTO_OLD) {
 			rc = efx_ef10_filter_remove_internal(efx,
 					1U << EFX_FILTER_PRI_AUTO, i, true);
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index b9cb697b2818..016616a63880 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -2809,7 +2809,7 @@ static void efx_reset_work(struct work_struct *data)
 	unsigned long pending;
 	enum reset_type method;
 
-	pending = ACCESS_ONCE(efx->reset_pending);
+	pending = READ_ONCE(efx->reset_pending);
 	method = fls(pending) - 1;
 
 	if (method == RESET_TYPE_MC_BIST)
@@ -2874,7 +2874,7 @@ void efx_schedule_reset(struct efx_nic *efx, enum reset_type type)
 	/* If we're not READY then just leave the flags set as the cue
 	 * to abort probing or reschedule the reset later.
 	 */
-	if (ACCESS_ONCE(efx->state) != STATE_READY)
+	if (READ_ONCE(efx->state) != STATE_READY)
 		return;
 
 	/* efx_process_channel() will no longer read events once a
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 29614da91cbf..7263275fde4a 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -2545,7 +2545,7 @@ static void ef4_reset_work(struct work_struct *data)
 	unsigned long pending;
 	enum reset_type method;
 
-	pending = ACCESS_ONCE(efx->reset_pending);
+	pending = READ_ONCE(efx->reset_pending);
 	method = fls(pending) - 1;
 
 	if ((method == RESET_TYPE_RECOVER_OR_DISABLE ||
@@ -2605,7 +2605,7 @@ void ef4_schedule_reset(struct ef4_nic *efx, enum reset_type type)
 	/* If we're not READY then just leave the flags set as the cue
 	 * to abort probing or reschedule the reset later.
 	 */
-	if (ACCESS_ONCE(efx->state) != STATE_READY)
+	if (READ_ONCE(efx->state) != STATE_READY)
 		return;
 
 	queue_work(reset_workqueue, &efx->reset_work);
diff --git a/drivers/net/ethernet/sfc/falcon/falcon.c b/drivers/net/ethernet/sfc/falcon/falcon.c
index 93c713c1f627..cd8bb472d758 100644
--- a/drivers/net/ethernet/sfc/falcon/falcon.c
+++ b/drivers/net/ethernet/sfc/falcon/falcon.c
@@ -452,7 +452,7 @@ static irqreturn_t falcon_legacy_interrupt_a1(int irq, void *dev_id)
 		   "IRQ %d on CPU %d status " EF4_OWORD_FMT "\n",
 		   irq, raw_smp_processor_id(), EF4_OWORD_VAL(*int_ker));
 
-	if (!likely(ACCESS_ONCE(efx->irq_soft_enabled)))
+	if (!likely(READ_ONCE(efx->irq_soft_enabled)))
 		return IRQ_HANDLED;
 
 	/* Check to see if we have a serious error condition */
@@ -1372,7 +1372,7 @@ static void falcon_reconfigure_mac_wrapper(struct ef4_nic *efx)
 	ef4_oword_t reg;
 	int link_speed, isolate;
 
-	isolate = !!ACCESS_ONCE(efx->reset_pending);
+	isolate = !!READ_ONCE(efx->reset_pending);
 
 	switch (link_state->speed) {
 	case 10000: link_speed = 3; break;
diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
index 05916c710d8c..494884f6af4a 100644
--- a/drivers/net/ethernet/sfc/falcon/farch.c
+++ b/drivers/net/ethernet/sfc/falcon/farch.c
@@ -834,7 +834,7 @@ ef4_farch_handle_tx_event(struct ef4_channel *channel, ef4_qword_t *event)
 	struct ef4_nic *efx = channel->efx;
 	int tx_packets = 0;
 
-	if (unlikely(ACCESS_ONCE(efx->reset_pending)))
+	if (unlikely(READ_ONCE(efx->reset_pending)))
 		return 0;
 
 	if (likely(EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_COMP))) {
@@ -990,7 +990,7 @@ ef4_farch_handle_rx_event(struct ef4_channel *channel, const ef4_qword_t *event)
 	struct ef4_rx_queue *rx_queue;
 	struct ef4_nic *efx = channel->efx;
 
-	if (unlikely(ACCESS_ONCE(efx->reset_pending)))
+	if (unlikely(READ_ONCE(efx->reset_pending)))
 		return;
 
 	rx_ev_cont = EF4_QWORD_FIELD(*event, FSF_AZ_RX_EV_JUMBO_CONT);
@@ -1504,7 +1504,7 @@ irqreturn_t ef4_farch_fatal_interrupt(struct ef4_nic *efx)
 irqreturn_t ef4_farch_legacy_interrupt(int irq, void *dev_id)
 {
 	struct ef4_nic *efx = dev_id;
-	bool soft_enabled = ACCESS_ONCE(efx->irq_soft_enabled);
+	bool soft_enabled = READ_ONCE(efx->irq_soft_enabled);
 	ef4_oword_t *int_ker = efx->irq_status.addr;
 	irqreturn_t result = IRQ_NONE;
 	struct ef4_channel *channel;
@@ -1596,7 +1596,7 @@ irqreturn_t ef4_farch_msi_interrupt(int irq, void *dev_id)
 		   "IRQ %d on CPU %d status " EF4_OWORD_FMT "\n",
 		   irq, raw_smp_processor_id(), EF4_OWORD_VAL(*int_ker));
 
-	if (!likely(ACCESS_ONCE(efx->irq_soft_enabled)))
+	if (!likely(READ_ONCE(efx->irq_soft_enabled)))
 		return IRQ_HANDLED;
 
 	/* Handle non-event-queue sources */
diff --git a/drivers/net/ethernet/sfc/falcon/nic.h b/drivers/net/ethernet/sfc/falcon/nic.h
index a4c4592f6023..54ca457cdb15 100644
--- a/drivers/net/ethernet/sfc/falcon/nic.h
+++ b/drivers/net/ethernet/sfc/falcon/nic.h
@@ -83,7 +83,7 @@ static inline struct ef4_tx_queue *ef4_tx_queue_partner(struct ef4_tx_queue *tx_
 static inline bool __ef4_nic_tx_is_empty(struct ef4_tx_queue *tx_queue,
 					 unsigned int write_count)
 {
-	unsigned int empty_read_count = ACCESS_ONCE(tx_queue->empty_read_count);
+	unsigned int empty_read_count = READ_ONCE(tx_queue->empty_read_count);
 
 	if (empty_read_count == 0)
 		return false;
@@ -464,11 +464,11 @@ irqreturn_t ef4_farch_fatal_interrupt(struct ef4_nic *efx);
 
 static inline int ef4_nic_event_test_irq_cpu(struct ef4_channel *channel)
 {
-	return ACCESS_ONCE(channel->event_test_cpu);
+	return READ_ONCE(channel->event_test_cpu);
 }
 static inline int ef4_nic_irq_test_irq_cpu(struct ef4_nic *efx)
 {
-	return ACCESS_ONCE(efx->last_irq_cpu);
+	return READ_ONCE(efx->last_irq_cpu);
 }
 
 /* Global Resources */
diff --git a/drivers/net/ethernet/sfc/falcon/tx.c b/drivers/net/ethernet/sfc/falcon/tx.c
index 6a75f4140a4b..6486814e97dc 100644
--- a/drivers/net/ethernet/sfc/falcon/tx.c
+++ b/drivers/net/ethernet/sfc/falcon/tx.c
@@ -134,8 +134,8 @@ static void ef4_tx_maybe_stop_queue(struct ef4_tx_queue *txq1)
 	 */
 	netif_tx_stop_queue(txq1->core_txq);
 	smp_mb();
-	txq1->old_read_count = ACCESS_ONCE(txq1->read_count);
-	txq2->old_read_count = ACCESS_ONCE(txq2->read_count);
+	txq1->old_read_count = READ_ONCE(txq1->read_count);
+	txq2->old_read_count = READ_ONCE(txq2->read_count);
 
 	fill_level = max(txq1->insert_count - txq1->old_read_count,
 			 txq2->insert_count - txq2->old_read_count);
@@ -524,7 +524,7 @@ void ef4_xmit_done(struct ef4_tx_queue *tx_queue, unsigned int index)
 
 	/* Check whether the hardware queue is now empty */
 	if ((int)(tx_queue->read_count - tx_queue->old_write_count) >= 0) {
-		tx_queue->old_write_count = ACCESS_ONCE(tx_queue->write_count);
+		tx_queue->old_write_count = READ_ONCE(tx_queue->write_count);
 		if (tx_queue->read_count == tx_queue->old_write_count) {
 			smp_mb();
 			tx_queue->empty_read_count =
diff --git a/drivers/net/ethernet/sfc/farch.c b/drivers/net/ethernet/sfc/farch.c
index ba45150f53c7..86454d25a405 100644
--- a/drivers/net/ethernet/sfc/farch.c
+++ b/drivers/net/ethernet/sfc/farch.c
@@ -827,7 +827,7 @@ efx_farch_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 	struct efx_nic *efx = channel->efx;
 	int tx_packets = 0;
 
-	if (unlikely(ACCESS_ONCE(efx->reset_pending)))
+	if (unlikely(READ_ONCE(efx->reset_pending)))
 		return 0;
 
 	if (likely(EFX_QWORD_FIELD(*event, FSF_AZ_TX_EV_COMP))) {
@@ -979,7 +979,7 @@ efx_farch_handle_rx_event(struct efx_channel *channel, const efx_qword_t *event)
 	struct efx_rx_queue *rx_queue;
 	struct efx_nic *efx = channel->efx;
 
-	if (unlikely(ACCESS_ONCE(efx->reset_pending)))
+	if (unlikely(READ_ONCE(efx->reset_pending)))
 		return;
 
 	rx_ev_cont = EFX_QWORD_FIELD(*event, FSF_AZ_RX_EV_JUMBO_CONT);
@@ -1520,7 +1520,7 @@ irqreturn_t efx_farch_fatal_interrupt(struct efx_nic *efx)
 irqreturn_t efx_farch_legacy_interrupt(int irq, void *dev_id)
 {
 	struct efx_nic *efx = dev_id;
-	bool soft_enabled = ACCESS_ONCE(efx->irq_soft_enabled);
+	bool soft_enabled = READ_ONCE(efx->irq_soft_enabled);
 	efx_oword_t *int_ker = efx->irq_status.addr;
 	irqreturn_t result = IRQ_NONE;
 	struct efx_channel *channel;
@@ -1612,7 +1612,7 @@ irqreturn_t efx_farch_msi_interrupt(int irq, void *dev_id)
 		   "IRQ %d on CPU %d status " EFX_OWORD_FMT "\n",
 		   irq, raw_smp_processor_id(), EFX_OWORD_VAL(*int_ker));
 
-	if (!likely(ACCESS_ONCE(efx->irq_soft_enabled)))
+	if (!likely(READ_ONCE(efx->irq_soft_enabled)))
 		return IRQ_HANDLED;
 
 	/* Handle non-event-queue sources */
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index 4d7fb8af880d..7b51b6371724 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -81,7 +81,7 @@ static struct efx_tx_queue *efx_tx_queue_partner(struct efx_tx_queue *tx_queue)
 static inline bool __efx_nic_tx_is_empty(struct efx_tx_queue *tx_queue,
 					 unsigned int write_count)
 {
-	unsigned int empty_read_count = ACCESS_ONCE(tx_queue->empty_read_count);
+	unsigned int empty_read_count = READ_ONCE(tx_queue->empty_read_count);
 
 	if (empty_read_count == 0)
 		return false;
@@ -617,11 +617,11 @@ irqreturn_t efx_farch_fatal_interrupt(struct efx_nic *efx);
 
 static inline int efx_nic_event_test_irq_cpu(struct efx_channel *channel)
 {
-	return ACCESS_ONCE(channel->event_test_cpu);
+	return READ_ONCE(channel->event_test_cpu);
 }
 static inline int efx_nic_irq_test_irq_cpu(struct efx_nic *efx)
 {
-	return ACCESS_ONCE(efx->last_irq_cpu);
+	return READ_ONCE(efx->last_irq_cpu);
 }
 
 /* Global Resources */
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 60cdb97f58e2..56c2db398def 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -658,7 +658,7 @@ static void efx_ptp_send_times(struct efx_nic *efx,
 
 	/* Write host time for specified period or until MC is done */
 	while ((timespec64_compare(&now.ts_real, &limit) < 0) &&
-	       ACCESS_ONCE(*mc_running)) {
+	       READ_ONCE(*mc_running)) {
 		struct timespec64 update_time;
 		unsigned int host_time;
 
@@ -668,7 +668,7 @@ static void efx_ptp_send_times(struct efx_nic *efx,
 		do {
 			pps_get_ts(&now);
 		} while ((timespec64_compare(&now.ts_real, &update_time) < 0) &&
-			 ACCESS_ONCE(*mc_running));
+			 READ_ONCE(*mc_running));
 
 		/* Synchronise NIC with single word of time only */
 		host_time = (now.ts_real.tv_sec << MC_NANOSECOND_BITS |
@@ -832,14 +832,14 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
 		       ptp->start.dma_addr);
 
 	/* Clear flag that signals MC ready */
-	ACCESS_ONCE(*start) = 0;
+	WRITE_ONCE(*start, 0);
 	rc = efx_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
 				MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
 	EFX_WARN_ON_ONCE_PARANOID(rc);
 
 	/* Wait for start from MCDI (or timeout) */
 	timeout = jiffies + msecs_to_jiffies(MAX_SYNCHRONISE_WAIT_MS);
-	while (!ACCESS_ONCE(*start) && (time_before(jiffies, timeout))) {
+	while (!READ_ONCE(*start) && (time_before(jiffies, timeout))) {
 		udelay(20);	/* Usually start MCDI execution quickly */
 		loops++;
 	}
@@ -849,7 +849,7 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
 	if (!time_before(jiffies, timeout))
 		++ptp->sync_timeouts;
 
-	if (ACCESS_ONCE(*start))
+	if (READ_ONCE(*start))
 		efx_ptp_send_times(efx, &last_time);
 
 	/* Collect results */
diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
index 32bf1fecf864..efb66ea21f27 100644
--- a/drivers/net/ethernet/sfc/tx.c
+++ b/drivers/net/ethernet/sfc/tx.c
@@ -136,8 +136,8 @@ static void efx_tx_maybe_stop_queue(struct efx_tx_queue *txq1)
 	 */
 	netif_tx_stop_queue(txq1->core_txq);
 	smp_mb();
-	txq1->old_read_count = ACCESS_ONCE(txq1->read_count);
-	txq2->old_read_count = ACCESS_ONCE(txq2->read_count);
+	txq1->old_read_count = READ_ONCE(txq1->read_count);
+	txq2->old_read_count = READ_ONCE(txq2->read_count);
 
 	fill_level = max(txq1->insert_count - txq1->old_read_count,
 			 txq2->insert_count - txq2->old_read_count);
@@ -752,7 +752,7 @@ void efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
 
 	/* Check whether the hardware queue is now empty */
 	if ((int)(tx_queue->read_count - tx_queue->old_write_count) >= 0) {
-		tx_queue->old_write_count = ACCESS_ONCE(tx_queue->write_count);
+		tx_queue->old_write_count = READ_ONCE(tx_queue->write_count);
 		if (tx_queue->read_count == tx_queue->old_write_count) {
 			smp_mb();
 			tx_queue->empty_read_count =
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 6a4e8e1bbd90..8ab0fb6892d5 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6245,7 +6245,7 @@ static void niu_get_rx_stats(struct niu *np,
 
 	pkts = dropped = errors = bytes = 0;
 
-	rx_rings = ACCESS_ONCE(np->rx_rings);
+	rx_rings = READ_ONCE(np->rx_rings);
 	if (!rx_rings)
 		goto no_rings;
 
@@ -6276,7 +6276,7 @@ static void niu_get_tx_stats(struct niu *np,
 
 	pkts = errors = bytes = 0;
 
-	tx_rings = ACCESS_ONCE(np->tx_rings);
+	tx_rings = READ_ONCE(np->tx_rings);
 	if (!tx_rings)
 		goto no_rings;
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 21b71ae947fd..b55b29b90b88 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -257,7 +257,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 	 * and validate that the result isn't NULL - in case we are
 	 * racing against queue removal.
 	 */
-	int numvtaps = ACCESS_ONCE(tap->numvtaps);
+	int numvtaps = READ_ONCE(tap->numvtaps);
 	__u32 rxq;
 
 	if (!numvtaps)
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5ce580f413b9..6aee2afb1f69 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -469,7 +469,7 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u32 numqueues = 0;
 
 	rcu_read_lock();
-	numqueues = ACCESS_ONCE(tun->numqueues);
+	numqueues = READ_ONCE(tun->numqueues);
 
 	txq = __skb_get_hash_symmetric(skb);
 	if (txq) {
@@ -864,7 +864,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	rcu_read_lock();
 	tfile = rcu_dereference(tun->tfiles[txq]);
-	numqueues = ACCESS_ONCE(tun->numqueues);
+	numqueues = READ_ONCE(tun->numqueues);
 
 	/* Drop packet if interface is not attached */
 	if (txq >= numqueues)
diff --git a/drivers/net/wireless/ath/ath5k/desc.c b/drivers/net/wireless/ath/ath5k/desc.c
index bd8d4392d68b..80f75139495f 100644
--- a/drivers/net/wireless/ath/ath5k/desc.c
+++ b/drivers/net/wireless/ath/ath5k/desc.c
@@ -500,13 +500,13 @@ ath5k_hw_proc_4word_tx_status(struct ath5k_hw *ah,
 
 	tx_status = &desc->ud.ds_tx5212.tx_stat;
 
-	txstat1 = ACCESS_ONCE(tx_status->tx_status_1);
+	txstat1 = READ_ONCE(tx_status->tx_status_1);
 
 	/* No frame has been send or error */
 	if (unlikely(!(txstat1 & AR5K_DESC_TX_STATUS1_DONE)))
 		return -EINPROGRESS;
 
-	txstat0 = ACCESS_ONCE(tx_status->tx_status_0);
+	txstat0 = READ_ONCE(tx_status->tx_status_0);
 
 	/*
 	 * Get descriptor status
@@ -700,14 +700,14 @@ ath5k_hw_proc_5212_rx_status(struct ath5k_hw *ah,
 	u32 rxstat0, rxstat1;
 
 	rx_status = &desc->ud.ds_rx.rx_stat;
-	rxstat1 = ACCESS_ONCE(rx_status->rx_status_1);
+	rxstat1 = READ_ONCE(rx_status->rx_status_1);
 
 	/* No frame received / not ready */
 	if (unlikely(!(rxstat1 & AR5K_5212_RX_DESC_STATUS1_DONE)))
 		return -EINPROGRESS;
 
 	memset(rs, 0, sizeof(struct ath5k_rx_status));
-	rxstat0 = ACCESS_ONCE(rx_status->rx_status_0);
+	rxstat0 = READ_ONCE(rx_status->rx_status_0);
 
 	/*
 	 * Frame receive status
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 613caca7dc02..785a0f33b7e6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3628,7 +3628,7 @@ static void brcmf_sdio_dataworker(struct work_struct *work)
 
 	bus->dpc_running = true;
 	wmb();
-	while (ACCESS_ONCE(bus->dpc_triggered)) {
+	while (READ_ONCE(bus->dpc_triggered)) {
 		bus->dpc_triggered = false;
 		brcmf_sdio_dpc(bus);
 		bus->idlecount = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 231878969332..0f45f34e39d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1118,7 +1118,7 @@ void iwl_mvm_set_hw_ctkill_state(struct iwl_mvm *mvm, bool state)
 static bool iwl_mvm_set_hw_rfkill_state(struct iwl_op_mode *op_mode, bool state)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-	bool calibrating = ACCESS_ONCE(mvm->calibrating);
+	bool calibrating = READ_ONCE(mvm->calibrating);
 
 	if (state)
 		set_bit(IWL_MVM_STATUS_HW_RFKILL, &mvm->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6f2e2af23219..6e9d3289b9d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -652,7 +652,7 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 				return -1;
 		} else if (info.control.vif->type == NL80211_IFTYPE_STATION &&
 			   is_multicast_ether_addr(hdr->addr1)) {
-			u8 ap_sta_id = ACCESS_ONCE(mvmvif->ap_sta_id);
+			u8 ap_sta_id = READ_ONCE(mvmvif->ap_sta_id);
 
 			if (ap_sta_id != IWL_MVM_INVALID_STA)
 				sta_id = ap_sta_id;
@@ -700,7 +700,7 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	snap_ip_tcp = 8 + skb_transport_header(skb) - skb_network_header(skb) +
 		tcp_hdrlen(skb);
 
-	dbg_max_amsdu_len = ACCESS_ONCE(mvm->max_amsdu_len);
+	dbg_max_amsdu_len = READ_ONCE(mvm->max_amsdu_len);
 
 	if (!sta->max_amsdu_len ||
 	    !ieee80211_is_data_qos(hdr->frame_control) ||
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index a06b6612b658..f25ce3a1ea50 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1247,7 +1247,7 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
 	spin_lock(&rxq->lock);
 	/* uCode's read index (stored in shared DRAM) indicates the last Rx
 	 * buffer that the driver may process (last buffer filled by ucode). */
-	r = le16_to_cpu(ACCESS_ONCE(rxq->rb_stts->closed_rb_num)) & 0x0FFF;
+	r = le16_to_cpu(READ_ONCE(rxq->rb_stts->closed_rb_num)) & 0x0FFF;
 	i = rxq->read;
 
 	/* W/A 9000 device step A0 wrap-around bug */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2e3e013ec95a..9ad3f4fe5894 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2076,12 +2076,12 @@ static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 
 	IWL_DEBUG_TX_QUEUES(trans, "Emptying queue %d...\n", txq_idx);
 	txq = trans_pcie->txq[txq_idx];
-	wr_ptr = ACCESS_ONCE(txq->write_ptr);
+	wr_ptr = READ_ONCE(txq->write_ptr);
 
-	while (txq->read_ptr != ACCESS_ONCE(txq->write_ptr) &&
+	while (txq->read_ptr != READ_ONCE(txq->write_ptr) &&
 	       !time_after(jiffies,
 			   now + msecs_to_jiffies(IWL_FLUSH_WAIT_MS))) {
-		u8 write_ptr = ACCESS_ONCE(txq->write_ptr);
+		u8 write_ptr = READ_ONCE(txq->write_ptr);
 
 		if (WARN_ONCE(wr_ptr != write_ptr,
 			      "WR pointer moved while flushing %d -> %d\n",
@@ -2553,7 +2553,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 
 	spin_lock(&rxq->lock);
 
-	r = le16_to_cpu(ACCESS_ONCE(rxq->rb_stts->closed_rb_num)) & 0x0FFF;
+	r = le16_to_cpu(READ_ONCE(rxq->rb_stts->closed_rb_num)) & 0x0FFF;
 
 	for (i = rxq->read, j = 0;
 	     i != r && j < allocated_rb_nums;
@@ -2814,7 +2814,7 @@ static struct iwl_trans_dump_data
 		/* Dump RBs is supported only for pre-9000 devices (1 queue) */
 		struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 		/* RBs */
-		num_rbs = le16_to_cpu(ACCESS_ONCE(rxq->rb_stts->closed_rb_num))
+		num_rbs = le16_to_cpu(READ_ONCE(rxq->rb_stts->closed_rb_num))
 				      & 0x0FFF;
 		num_rbs = (num_rbs - rxq->read) & RX_QUEUE_MASK;
 		len += num_rbs * (sizeof(*data) +
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 6467ffac9811..d2b3d6177a55 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1380,7 +1380,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	mac80211_hwsim_monitor_rx(hw, skb, channel);
 
 	/* wmediumd mode check */
-	_portid = ACCESS_ONCE(data->wmediumd);
+	_portid = READ_ONCE(data->wmediumd);
 
 	if (_portid)
 		return mac80211_hwsim_tx_frame_nl(hw, skb, _portid);
@@ -1477,7 +1477,7 @@ static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 				    struct ieee80211_channel *chan)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
-	u32 _pid = ACCESS_ONCE(data->wmediumd);
+	u32 _pid = READ_ONCE(data->wmediumd);
 
 	if (ieee80211_hw_check(hw, SUPPORTS_RC_TABLE)) {
 		struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index f05cfc83c9c8..f946bf889015 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -996,7 +996,7 @@ static void qlt_free_session_done(struct work_struct *work)
 	if (logout_started) {
 		bool traced = false;
 
-		while (!ACCESS_ONCE(sess->logout_completed)) {
+		while (!READ_ONCE(sess->logout_completed)) {
 			if (!traced) {
 				ql_dbg(ql_dbg_tgt_mgt, vha, 0xf086,
 					"%s: waiting for sess %p logout\n",
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 942d094269fb..9469695f5871 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -985,7 +985,7 @@ static unsigned int tcmu_handle_completions(struct tcmu_dev *udev)
 	mb = udev->mb_addr;
 	tcmu_flush_dcache_range(mb, sizeof(*mb));
 
-	while (udev->cmdr_last_cleaned != ACCESS_ONCE(mb->cmd_tail)) {
+	while (udev->cmdr_last_cleaned != READ_ONCE(mb->cmd_tail)) {
 
 		struct tcmu_cmd_entry *entry = (void *) mb + CMDR_OFF + udev->cmdr_last_cleaned;
 		struct tcmu_cmd *cmd;
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 3e865dbf878c..fbaa2a90d25d 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -483,7 +483,7 @@ static ssize_t wdm_read
 	if (rv < 0)
 		return -ERESTARTSYS;
 
-	cntr = ACCESS_ONCE(desc->length);
+	cntr = READ_ONCE(desc->length);
 	if (cntr == 0) {
 		desc->read = 0;
 retry:
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 4664e543cf2f..07cd2d245e65 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -150,7 +150,7 @@ static int usbfs_increase_memory_usage(u64 amount)
 {
 	u64 lim;
 
-	lim = ACCESS_ONCE(usbfs_memory_mb);
+	lim = READ_ONCE(usbfs_memory_mb);
 	lim <<= 20;
 
 	atomic64_add(amount, &usbfs_memory_usage);
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index d930bfda4010..58d59c5f8592 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -973,7 +973,7 @@ static ssize_t interface_show(struct device *dev, struct device_attribute *attr,
 	char *string;
 
 	intf = to_usb_interface(dev);
-	string = ACCESS_ONCE(intf->cur_altsetting->string);
+	string = READ_ONCE(intf->cur_altsetting->string);
 	if (!string)
 		return 0;
 	return sprintf(buf, "%s\n", string);
@@ -989,7 +989,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 
 	intf = to_usb_interface(dev);
 	udev = interface_to_usbdev(intf);
-	alt = ACCESS_ONCE(intf->cur_altsetting);
+	alt = READ_ONCE(intf->cur_altsetting);
 
 	return sprintf(buf, "usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02X"
 			"ic%02Xisc%02Xip%02Xin%02X\n",
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 1f9941145746..0b59fa50aa30 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -1261,7 +1261,7 @@ static int gr_handle_in_ep(struct gr_ep *ep)
 	if (!req->last_desc)
 		return 0;
 
-	if (ACCESS_ONCE(req->last_desc->ctrl) & GR_DESC_IN_CTRL_EN)
+	if (READ_ONCE(req->last_desc->ctrl) & GR_DESC_IN_CTRL_EN)
 		return 0; /* Not put in hardware buffers yet */
 
 	if (gr_read32(&ep->regs->epstat) & (GR_EPSTAT_B1 | GR_EPSTAT_B0))
@@ -1290,7 +1290,7 @@ static int gr_handle_out_ep(struct gr_ep *ep)
 	if (!req->curr_desc)
 		return 0;
 
-	ctrl = ACCESS_ONCE(req->curr_desc->ctrl);
+	ctrl = READ_ONCE(req->curr_desc->ctrl);
 	if (ctrl & GR_DESC_OUT_CTRL_EN)
 		return 0; /* Not received yet */
 
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 44924824fa41..c86f89babd57 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -785,7 +785,7 @@ static void io_watchdog_func(unsigned long _ohci)
 		}
 
 		/* find the last TD processed by the controller. */
-		head = hc32_to_cpu(ohci, ACCESS_ONCE(ed->hwHeadP)) & TD_MASK;
+		head = hc32_to_cpu(ohci, READ_ONCE(ed->hwHeadP)) & TD_MASK;
 		td_start = td;
 		td_next = list_prepare_entry(td, &ed->td_list, td_list);
 		list_for_each_entry_continue(td_next, &ed->td_list, td_list) {
diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
index 91b22b2ea3aa..09a2a259941b 100644
--- a/drivers/usb/host/uhci-hcd.h
+++ b/drivers/usb/host/uhci-hcd.h
@@ -186,7 +186,7 @@ struct uhci_qh {
  * We need a special accessor for the element pointer because it is
  * subject to asynchronous updates by the controller.
  */
-#define qh_element(qh)		ACCESS_ONCE((qh)->element)
+#define qh_element(qh)		READ_ONCE((qh)->element)
 
 #define LINK_TO_QH(uhci, qh)	(UHCI_PTR_QH((uhci)) | \
 				cpu_to_hc32((uhci), (qh)->dma_handle))
@@ -274,7 +274,7 @@ struct uhci_td {
  * subject to asynchronous updates by the controller.
  */
 #define td_status(uhci, td)		hc32_to_cpu((uhci), \
-						ACCESS_ONCE((td)->status))
+						READ_ONCE((td)->status))
 
 #define LINK_TO_TD(uhci, td)		(cpu_to_hc32((uhci), (td)->dma_handle))
 
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index f5a86f651f38..2bc3705a99bd 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -665,7 +665,7 @@ static int vfio_dev_viable(struct device *dev, void *data)
 {
 	struct vfio_group *group = data;
 	struct vfio_device *device;
-	struct device_driver *drv = ACCESS_ONCE(dev->driver);
+	struct device_driver *drv = READ_ONCE(dev->driver);
 	struct vfio_unbound_dev *unbound;
 	int ret = -EINVAL;
 
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 046f6d280af5..35e929f132e8 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -929,7 +929,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 			continue;
 		}
 
-		tpg = ACCESS_ONCE(vs_tpg[*target]);
+		tpg = READ_ONCE(vs_tpg[*target]);
 		if (unlikely(!tpg)) {
 			/* Target does not exist, fail the request */
 			vhost_scsi_send_bad_target(vs, vq, head, out);
diff --git a/fs/aio.c b/fs/aio.c
index 5a2487217072..e6de7715228c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -576,7 +576,7 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
 	 * actually has a cancel function, hence the cmpxchg()
 	 */
 
-	cancel = ACCESS_ONCE(kiocb->ki_cancel);
+	cancel = READ_ONCE(kiocb->ki_cancel);
 	do {
 		if (!cancel || cancel == KIOCB_CANCELLED)
 			return -EINVAL;
diff --git a/fs/buffer.c b/fs/buffer.c
index 170df856bdb9..32ce01f0f95f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1692,7 +1692,8 @@ static struct buffer_head *create_page_buffers(struct page *page, struct inode *
 	BUG_ON(!PageLocked(page));
 
 	if (!page_has_buffers(page))
-		create_empty_buffers(page, 1 << ACCESS_ONCE(inode->i_blkbits), b_state);
+		create_empty_buffers(page, 1 << READ_ONCE(inode->i_blkbits),
+				     b_state);
 	return page_buffers(page);
 }
 
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 018c588c7ac3..768263c2d077 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -368,7 +368,7 @@ void fscrypt_put_encryption_info(struct inode *inode, struct fscrypt_info *ci)
 	struct fscrypt_info *prev;
 
 	if (ci == NULL)
-		ci = ACCESS_ONCE(inode->i_crypt_info);
+		ci = READ_ONCE(inode->i_crypt_info);
 	if (ci == NULL)
 		return;
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 62cf812ed0e5..066cf268694f 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1140,7 +1140,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		      get_block_t get_block, dio_iodone_t end_io,
 		      dio_submit_t submit_io, int flags)
 {
-	unsigned i_blkbits = ACCESS_ONCE(inode->i_blkbits);
+	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);
 	unsigned blkbits = i_blkbits;
 	unsigned blocksize_mask = (1 << blkbits) - 1;
 	ssize_t retval = -EINVAL;
diff --git a/fs/exec.c b/fs/exec.c
index 5470d3c1892a..13331bc42454 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1910,7 +1910,7 @@ void set_dumpable(struct mm_struct *mm, int value)
 		return;
 
 	do {
-		old = ACCESS_ONCE(mm->flags);
+		old = READ_ONCE(mm->flags);
 		new = (old & ~MMF_DUMPABLE_MASK) | value;
 	} while (cmpxchg(&mm->flags, old, new) != old);
 }
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 448a1119f0be..57bf2964bb83 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -724,7 +724,7 @@ static void send_sigio_to_task(struct task_struct *p,
 	 * F_SETSIG can change ->signum lockless in parallel, make
 	 * sure we read it once and use the same value throughout.
 	 */
-	int signum = ACCESS_ONCE(fown->signum);
+	int signum = READ_ONCE(fown->signum);
 
 	if (!sigio_perm(p, fown, signum))
 		return;
diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index e747b3d720ee..2d07f292b625 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -78,7 +78,7 @@ void mnt_pin_kill(struct mount *m)
 	while (1) {
 		struct hlist_node *p;
 		rcu_read_lock();
-		p = ACCESS_ONCE(m->mnt_pins.first);
+		p = READ_ONCE(m->mnt_pins.first);
 		if (!p) {
 			rcu_read_unlock();
 			break;
@@ -92,7 +92,7 @@ void group_pin_kill(struct hlist_head *p)
 	while (1) {
 		struct hlist_node *q;
 		rcu_read_lock();
-		q = ACCESS_ONCE(p->first);
+		q = READ_ONCE(p->first);
 		if (!q) {
 			rcu_read_unlock();
 			break;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 13c65dd2d37d..a42d89371748 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -33,7 +33,7 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
 	 * Lockless access is OK, because file->private data is set
 	 * once during mount and is valid until the file is released.
 	 */
-	return ACCESS_ONCE(file->private_data);
+	return READ_ONCE(file->private_data);
 }
 
 static void fuse_request_init(struct fuse_req *req, struct page **pages,
diff --git a/fs/inode.c b/fs/inode.c
index d1e35b53bb23..fd401028a309 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2090,7 +2090,7 @@ void inode_set_flags(struct inode *inode, unsigned int flags,
 
 	WARN_ON_ONCE(flags & ~mask);
 	do {
-		old_flags = ACCESS_ONCE(inode->i_flags);
+		old_flags = READ_ONCE(inode->i_flags);
 		new_flags = (old_flags & ~mask) | flags;
 	} while (unlikely(cmpxchg(&inode->i_flags, old_flags,
 				  new_flags) != old_flags));
diff --git a/fs/namei.c b/fs/namei.c
index c75ea03ca147..40a0f34bf990 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1209,7 +1209,7 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 	/* Given that we're not holding a lock here, we retain the value in a
 	 * local variable for each dentry as we look at it so that we don't see
 	 * the components of that value change under us */
-	while (managed = ACCESS_ONCE(path->dentry->d_flags),
+	while (managed = READ_ONCE(path->dentry->d_flags),
 	       managed &= DCACHE_MANAGED_DENTRY,
 	       unlikely(managed != 0)) {
 		/* Allow the filesystem to manage the transit without i_mutex
@@ -1394,7 +1394,7 @@ int follow_down(struct path *path)
 	unsigned managed;
 	int ret;
 
-	while (managed = ACCESS_ONCE(path->dentry->d_flags),
+	while (managed = READ_ONCE(path->dentry->d_flags),
 	       unlikely(managed & DCACHE_MANAGED_DENTRY)) {
 		/* Allow the filesystem to manage the transit without i_mutex
 		 * being held.
diff --git a/fs/namespace.c b/fs/namespace.c
index 3b601f115b6c..f65f2dc786cf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -353,7 +353,7 @@ int __mnt_want_write(struct vfsmount *m)
 	 * incremented count after it has set MNT_WRITE_HOLD.
 	 */
 	smp_mb();
-	while (ACCESS_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD)
+	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD)
 		cpu_relax();
 	/*
 	 * After the slowpath clears MNT_WRITE_HOLD, mnt_is_readonly will
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5ceaeb1f6fb6..f439f1c45008 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1081,7 +1081,7 @@ static int nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	int error;
 
 	if (flags & LOOKUP_RCU) {
-		parent = ACCESS_ONCE(dentry->d_parent);
+		parent = READ_ONCE(dentry->d_parent);
 		dir = d_inode_rcu(parent);
 		if (!dir)
 			return -ECHILD;
@@ -1168,7 +1168,7 @@ static int nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
  out_valid:
 	if (flags & LOOKUP_RCU) {
-		if (parent != ACCESS_ONCE(dentry->d_parent))
+		if (parent != READ_ONCE(dentry->d_parent))
 			return -ECHILD;
 	} else
 		dput(parent);
@@ -1582,7 +1582,7 @@ static int nfs4_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 		struct inode *dir;
 
 		if (flags & LOOKUP_RCU) {
-			parent = ACCESS_ONCE(dentry->d_parent);
+			parent = READ_ONCE(dentry->d_parent);
 			dir = d_inode_rcu(parent);
 			if (!dir)
 				return -ECHILD;
@@ -1596,7 +1596,7 @@ static int nfs4_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 			ret = -ECHILD;
 		if (!(flags & LOOKUP_RCU))
 			dput(parent);
-		else if (parent != ACCESS_ONCE(dentry->d_parent))
+		else if (parent != READ_ONCE(dentry->d_parent))
 			return -ECHILD;
 		goto out;
 	}
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 77a8eacbe032..375e8bf0dd24 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -453,7 +453,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		cutime = sig->cutime;
 		cstime = sig->cstime;
 		cgtime = sig->cgtime;
-		rsslim = ACCESS_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
+		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
 		/* add up live thread stats at the group level */
 		if (whole) {
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 99dff222fe67..03afd5150916 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -27,7 +27,7 @@ static unsigned mounts_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &p->ns->poll, wait);
 
-	event = ACCESS_ONCE(ns->event);
+	event = READ_ONCE(ns->event);
 	if (m->poll_event != event) {
 		m->poll_event = event;
 		res |= POLLERR | POLLPRI;
diff --git a/fs/splice.c b/fs/splice.c
index f3084cce0ea6..39e2dc01ac12 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -253,7 +253,7 @@ EXPORT_SYMBOL(add_to_pipe);
  */
 int splice_grow_spd(const struct pipe_inode_info *pipe, struct splice_pipe_desc *spd)
 {
-	unsigned int buffers = ACCESS_ONCE(pipe->buffers);
+	unsigned int buffers = READ_ONCE(pipe->buffers);
 
 	spd->nr_pages_max = buffers;
 	if (buffers <= PIPE_DEF_BUFFERS)
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 1c713fd5b3e6..f46d133c0949 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -381,7 +381,7 @@ int handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * in __get_user_pages if userfaultfd_release waits on the
 	 * caller of handle_userfault to release the mmap_sem.
 	 */
-	if (unlikely(ACCESS_ONCE(ctx->released))) {
+	if (unlikely(READ_ONCE(ctx->released))) {
 		/*
 		 * Don't return VM_FAULT_SIGBUS in this case, so a non
 		 * cooperative manager can close the uffd after the
@@ -477,7 +477,7 @@ int handle_userfault(struct vm_fault *vmf, unsigned long reason)
 						       vmf->flags, reason);
 	up_read(&mm->mmap_sem);
 
-	if (likely(must_wait && !ACCESS_ONCE(ctx->released) &&
+	if (likely(must_wait && !READ_ONCE(ctx->released) &&
 		   (return_to_userland ? !signal_pending(current) :
 		    !fatal_signal_pending(current)))) {
 		wake_up_poll(&ctx->fd_wqh, POLLIN);
@@ -586,7 +586,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		set_current_state(TASK_KILLABLE);
 		if (ewq->msg.event == 0)
 			break;
-		if (ACCESS_ONCE(ctx->released) ||
+		if (READ_ONCE(ctx->released) ||
 		    fatal_signal_pending(current)) {
 			/*
 			 * &ewq->wq may be queued in fork_event, but
@@ -833,7 +833,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	struct userfaultfd_wake_range range = { .len = 0, };
 	unsigned long new_flags;
 
-	ACCESS_ONCE(ctx->released) = true;
+	WRITE_ONCE(ctx->released, true);
 
 	if (!mmget_not_zero(mm))
 		goto wakeup;
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 51bf7b827387..129975970d99 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -592,9 +592,9 @@ xlog_valid_lsn(
 	 * a transiently forward state. Instead, we can see the LSN in a
 	 * transiently behind state if we happen to race with a cycle wrap.
 	 */
-	cur_cycle = ACCESS_ONCE(log->l_curr_cycle);
+	cur_cycle = READ_ONCE(log->l_curr_cycle);
 	smp_rmb();
-	cur_block = ACCESS_ONCE(log->l_curr_block);
+	cur_block = READ_ONCE(log->l_curr_block);
 
 	if ((CYCLE_LSN(lsn) > cur_cycle) ||
 	    (CYCLE_LSN(lsn) == cur_cycle && BLOCK_LSN(lsn) > cur_block)) {
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 8fbe259b197c..0a7ce668f8e0 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -236,7 +236,7 @@ static inline unsigned long __ffs64(u64 word)
 	typeof(*ptr) old, new;					\
 								\
 	do {							\
-		old = ACCESS_ONCE(*ptr);			\
+		old = READ_ONCE(*ptr);			\
 		new = (old & ~mask) | bits;			\
 	} while (cmpxchg(ptr, old, new) != old);		\
 								\
@@ -251,7 +251,7 @@ static inline unsigned long __ffs64(u64 word)
 	typeof(*ptr) old, new;					\
 								\
 	do {							\
-		old = ACCESS_ONCE(*ptr);			\
+		old = READ_ONCE(*ptr);			\
 		new = old & ~clear;				\
 	} while (!(old & test) &&				\
 		 cmpxchg(ptr, old, new) != old);		\
diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index a4be70398ce1..36dd4ffb5715 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -88,7 +88,7 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
 /* Returns how many objects can be queued, < 0 indicates over limit. */
 static inline int dql_avail(const struct dql *dql)
 {
-	return ACCESS_ONCE(dql->adj_limit) - ACCESS_ONCE(dql->num_queued);
+	return READ_ONCE(dql->adj_limit) - READ_ONCE(dql->num_queued);
 }
 
 /* Record number of completed objects and recalculate the limit. */
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 14bc21c2ee7f..785a00ca4628 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -221,7 +221,7 @@ extern struct page *huge_zero_page;
 
 static inline bool is_huge_zero_page(struct page *page)
 {
-	return ACCESS_ONCE(huge_zero_page) == page;
+	return READ_ONCE(huge_zero_page) == page;
 }
 
 static inline bool is_huge_zero_pmd(pmd_t pmd)
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 30294603526f..d95cae09dea0 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -247,7 +247,7 @@ static inline struct team_port *team_get_port_by_index(struct team *team,
 
 static inline int team_num_to_port_index(struct team *team, unsigned int num)
 {
-	int en_port_count = ACCESS_ONCE(team->en_port_count);
+	int en_port_count = READ_ONCE(team->en_port_count);
 
 	if (unlikely(!en_port_count))
 		return 0;
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 1957635e6d5f..85abc2915e8d 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -198,7 +198,7 @@ static inline void init_llist_head(struct llist_head *list)
  */
 static inline bool llist_empty(const struct llist_head *head)
 {
-	return ACCESS_ONCE(head->first) == NULL;
+	return READ_ONCE(head->first) == NULL;
 }
 
 static inline struct llist_node *llist_next(struct llist_node *node)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 2efb08a60e63..f0fc4700b6ff 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	ACCESS_ONCE(dev->power.last_busy) = jiffies;
+	WRITE_ONCE(dev->power.last_busy, jiffies);
 }
 
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 4f4f786255ef..3fadb6f9982b 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -983,12 +983,12 @@ static inline int sysctl_sync_threshold(struct netns_ipvs *ipvs)
 
 static inline int sysctl_sync_period(struct netns_ipvs *ipvs)
 {
-	return ACCESS_ONCE(ipvs->sysctl_sync_threshold[1]);
+	return READ_ONCE(ipvs->sysctl_sync_threshold[1]);
 }
 
 static inline unsigned int sysctl_sync_refresh_period(struct netns_ipvs *ipvs)
 {
-	return ACCESS_ONCE(ipvs->sysctl_sync_refresh_period);
+	return READ_ONCE(ipvs->sysctl_sync_refresh_period);
 }
 
 static inline int sysctl_sync_retries(struct netns_ipvs *ipvs)
@@ -1013,7 +1013,7 @@ static inline int sysctl_sloppy_sctp(struct netns_ipvs *ipvs)
 
 static inline int sysctl_sync_ports(struct netns_ipvs *ipvs)
 {
-	return ACCESS_ONCE(ipvs->sysctl_sync_ports);
+	return READ_ONCE(ipvs->sysctl_sync_ports);
 }
 
 static inline int sysctl_sync_persist_mode(struct netns_ipvs *ipvs)
diff --git a/kernel/acct.c b/kernel/acct.c
index 5e72af29ab73..21eedd0dd81a 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -146,7 +146,7 @@ static struct bsd_acct_struct *acct_get(struct pid_namespace *ns)
 again:
 	smp_rmb();
 	rcu_read_lock();
-	res = to_acct(ACCESS_ONCE(ns->bacct));
+	res = to_acct(READ_ONCE(ns->bacct));
 	if (!res) {
 		rcu_read_unlock();
 		return NULL;
@@ -158,7 +158,7 @@ static struct bsd_acct_struct *acct_get(struct pid_namespace *ns)
 	}
 	rcu_read_unlock();
 	mutex_lock(&res->lock);
-	if (res != to_acct(ACCESS_ONCE(ns->bacct))) {
+	if (res != to_acct(READ_ONCE(ns->bacct))) {
 		mutex_unlock(&res->lock);
 		acct_put(res);
 		goto again;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 417812ce0099..a1322e855e9f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1200,7 +1200,7 @@ perf_event_ctx_lock_nested(struct perf_event *event, int nesting)
 
 again:
 	rcu_read_lock();
-	ctx = ACCESS_ONCE(event->ctx);
+	ctx = READ_ONCE(event->ctx);
 	if (!atomic_inc_not_zero(&ctx->refcount)) {
 		rcu_read_unlock();
 		goto again;
@@ -5302,8 +5302,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		if (!rb)
 			goto aux_unlock;
 
-		aux_offset = ACCESS_ONCE(rb->user_page->aux_offset);
-		aux_size = ACCESS_ONCE(rb->user_page->aux_size);
+		aux_offset = READ_ONCE(rb->user_page->aux_offset);
+		aux_size = READ_ONCE(rb->user_page->aux_size);
 
 		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
 			goto aux_unlock;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index f684d8e5fa2b..f3e37971c842 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -381,7 +381,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	 * (B) <-> (C) ordering is still observed by the pmu driver.
 	 */
 	if (!rb->aux_overwrite) {
-		aux_tail = ACCESS_ONCE(rb->user_page->aux_tail);
+		aux_tail = READ_ONCE(rb->user_page->aux_tail);
 		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;
 		if (aux_head - aux_tail < perf_aux_size(rb))
 			handle->size = CIRC_SPACE(aux_head, aux_tail, perf_aux_size(rb));
diff --git a/kernel/exit.c b/kernel/exit.c
index f2cd53e92147..e4fee98803b3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1339,7 +1339,7 @@ static int wait_consider_task(struct wait_opts *wo, int ptrace,
 	 * Ensure that EXIT_ZOMBIE -> EXIT_DEAD/EXIT_TRACE transition
 	 * can't confuse the checks below.
 	 */
-	int exit_state = ACCESS_ONCE(p->exit_state);
+	int exit_state = READ_ONCE(p->exit_state);
 	int ret;
 
 	if (unlikely(exit_state == EXIT_DEAD))
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 81279c6602ff..845f3805c73d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2724,7 +2724,7 @@ rb_reserve_next_event(struct ring_buffer *buffer,
 	 * if it happened, we have to fail the write.
 	 */
 	barrier();
-	if (unlikely(ACCESS_ONCE(cpu_buffer->buffer) != buffer)) {
+	if (unlikely(READ_ONCE(cpu_buffer->buffer) != buffer)) {
 		local_dec(&cpu_buffer->committing);
 		local_dec(&cpu_buffer->commits);
 		return NULL;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 652c682707cd..9050c8b3ccde 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1459,7 +1459,7 @@ extern struct trace_event_file *find_event_file(struct trace_array *tr,
 
 static inline void *event_file_data(struct file *filp)
 {
-	return ACCESS_ONCE(file_inode(filp)->i_private);
+	return READ_ONCE(file_inode(filp)->i_private);
 }
 
 extern struct mutex event_mutex;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 49cb41412eec..780262210c9a 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -77,7 +77,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 {
 	unsigned long this_size, flags; unsigned long *p, *top, *start;
 	static int tracer_frame;
-	int frame_size = ACCESS_ONCE(tracer_frame);
+	int frame_size = READ_ONCE(tracer_frame);
 	int i, x;
 
 	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index c490f1e4313b..d32b45662fb6 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -894,7 +894,7 @@ static bool new_idmap_permitted(const struct file *file,
 int proc_setgroups_show(struct seq_file *seq, void *v)
 {
 	struct user_namespace *ns = seq->private;
-	unsigned long userns_flags = ACCESS_ONCE(ns->flags);
+	unsigned long userns_flags = READ_ONCE(ns->flags);
 
 	seq_printf(seq, "%s\n",
 		   (userns_flags & USERNS_SETGROUPS_ALLOWED) ?
diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 155c55d8db5f..fe7953aead82 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -39,7 +39,7 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 		/* Descend through a shortcut */
 		shortcut = assoc_array_ptr_to_shortcut(cursor);
 		smp_read_barrier_depends();
-		cursor = ACCESS_ONCE(shortcut->next_node);
+		cursor = READ_ONCE(shortcut->next_node);
 	}
 
 	node = assoc_array_ptr_to_node(cursor);
@@ -55,7 +55,7 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 	 */
 	has_meta = 0;
 	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
-		ptr = ACCESS_ONCE(node->slots[slot]);
+		ptr = READ_ONCE(node->slots[slot]);
 		has_meta |= (unsigned long)ptr;
 		if (ptr && assoc_array_ptr_is_leaf(ptr)) {
 			/* We need a barrier between the read of the pointer
@@ -89,7 +89,7 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 	smp_read_barrier_depends();
 
 	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
-		ptr = ACCESS_ONCE(node->slots[slot]);
+		ptr = READ_ONCE(node->slots[slot]);
 		if (assoc_array_ptr_is_meta(ptr)) {
 			cursor = ptr;
 			goto begin_node;
@@ -98,7 +98,7 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 
 finished_node:
 	/* Move up to the parent (may need to skip back over a shortcut) */
-	parent = ACCESS_ONCE(node->back_pointer);
+	parent = READ_ONCE(node->back_pointer);
 	slot = node->parent_slot;
 	if (parent == stop)
 		return 0;
@@ -107,7 +107,7 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 		shortcut = assoc_array_ptr_to_shortcut(parent);
 		smp_read_barrier_depends();
 		cursor = parent;
-		parent = ACCESS_ONCE(shortcut->back_pointer);
+		parent = READ_ONCE(shortcut->back_pointer);
 		slot = shortcut->parent_slot;
 		if (parent == stop)
 			return 0;
@@ -147,7 +147,7 @@ int assoc_array_iterate(const struct assoc_array *array,
 					void *iterator_data),
 			void *iterator_data)
 {
-	struct assoc_array_ptr *root = ACCESS_ONCE(array->root);
+	struct assoc_array_ptr *root = READ_ONCE(array->root);
 
 	if (!root)
 		return 0;
@@ -194,7 +194,7 @@ assoc_array_walk(const struct assoc_array *array,
 
 	pr_devel("-->%s()\n", __func__);
 
-	cursor = ACCESS_ONCE(array->root);
+	cursor = READ_ONCE(array->root);
 	if (!cursor)
 		return assoc_array_walk_tree_empty;
 
@@ -220,7 +220,7 @@ assoc_array_walk(const struct assoc_array *array,
 
 	slot = segments >> (level & ASSOC_ARRAY_KEY_CHUNK_MASK);
 	slot &= ASSOC_ARRAY_FAN_MASK;
-	ptr = ACCESS_ONCE(node->slots[slot]);
+	ptr = READ_ONCE(node->slots[slot]);
 
 	pr_devel("consider slot %x [ix=%d type=%lu]\n",
 		 slot, level, (unsigned long)ptr & 3);
@@ -294,7 +294,7 @@ assoc_array_walk(const struct assoc_array *array,
 	} while (sc_level < shortcut->skip_to_level);
 
 	/* The shortcut matches the leaf's index to this point. */
-	cursor = ACCESS_ONCE(shortcut->next_node);
+	cursor = READ_ONCE(shortcut->next_node);
 	if (((level ^ sc_level) & ~ASSOC_ARRAY_KEY_CHUNK_MASK) != 0) {
 		level = sc_level;
 		goto jumped;
@@ -337,7 +337,7 @@ void *assoc_array_find(const struct assoc_array *array,
 	 * the terminal node.
 	 */
 	for (slot = 0; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
-		ptr = ACCESS_ONCE(node->slots[slot]);
+		ptr = READ_ONCE(node->slots[slot]);
 		if (ptr && assoc_array_ptr_is_leaf(ptr)) {
 			/* We need a barrier between the read of the pointer
 			 * and dereferencing the pointer - but only if we are
diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index f346715e2255..81770a55cb16 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -20,7 +20,7 @@ void dql_completed(struct dql *dql, unsigned int count)
 	unsigned int ovlimit, completed, num_queued;
 	bool all_prev_completed;
 
-	num_queued = ACCESS_ONCE(dql->num_queued);
+	num_queued = READ_ONCE(dql->num_queued);
 
 	/* Can't complete more than what's in queue */
 	BUG_ON(count > num_queued - dql->num_completed);
diff --git a/lib/llist.c b/lib/llist.c
index ae5872b1df0c..7062e931a7bb 100644
--- a/lib/llist.c
+++ b/lib/llist.c
@@ -41,7 +41,7 @@ bool llist_add_batch(struct llist_node *new_first, struct llist_node *new_last,
 	struct llist_node *first;
 
 	do {
-		new_last->next = first = ACCESS_ONCE(head->first);
+		new_last->next = first = READ_ONCE(head->first);
 	} while (cmpxchg(&head->first, first, new_first) != first);
 
 	return !first;
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 86c3385b9eb3..1746bae94d41 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -620,8 +620,8 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 
 	rcu_read_lock();
 	for (i = 0; i < depth; i++, d = p) {
-		p = ACCESS_ONCE(d->d_parent);
-		array[i] = ACCESS_ONCE(d->d_name.name);
+		p = READ_ONCE(d->d_parent);
+		array[i] = READ_ONCE(d->d_name.name);
 		if (p == d) {
 			if (i)
 				array[i] = "";
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 269b5df58543..c3bf907a03ee 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2715,7 +2715,7 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
 	struct pglist_data *pgdata = NODE_DATA(sc->nid);
-	return ACCESS_ONCE(pgdata->split_queue_len);
+	return READ_ONCE(pgdata->split_queue_len);
 }
 
 static unsigned long deferred_split_scan(struct shrinker *shrink,
diff --git a/net/core/dev.c b/net/core/dev.c
index 588b473194a8..648be63520c6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3725,7 +3725,7 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 	flow_table = rcu_dereference(rxqueue->rps_flow_table);
 	if (flow_table && flow_id <= flow_table->mask) {
 		rflow = &flow_table->flows[flow_id];
-		cpu = ACCESS_ONCE(rflow->cpu);
+		cpu = READ_ONCE(rflow->cpu);
 		if (rflow->filter == filter_id && cpu < nr_cpu_ids &&
 		    ((int)(per_cpu(softnet_data, cpu).input_queue_head -
 			   rflow->last_qtail) <
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 6e1e10ff433a..3b2034f6d49d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3377,7 +3377,7 @@ static void pktgen_wait_for_skb(struct pktgen_dev *pkt_dev)
 
 static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 {
-	unsigned int burst = ACCESS_ONCE(pkt_dev->burst);
+	unsigned int burst = READ_ONCE(pkt_dev->burst);
 	struct net_device *odev = pkt_dev->odev;
 	struct netdev_queue *txq;
 	struct sk_buff *skb;
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index af74d0433453..f9597ba26599 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -164,7 +164,7 @@ static void inet_frag_worker(struct work_struct *work)
 
 	local_bh_disable();
 
-	for (i = ACCESS_ONCE(f->next_bucket); budget; --budget) {
+	for (i = READ_ONCE(f->next_bucket); budget; --budget) {
 		evicted += inet_evict_bucket(f, &f->hash[i]);
 		i = (i + 1) & (INETFRAGS_HASHSZ - 1);
 		if (evicted > INETFRAGS_EVICT_MAX)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ac6fde5d45f1..ea67e330be9e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -495,7 +495,7 @@ u32 ip_idents_reserve(u32 hash, int segs)
 {
 	u32 *p_tstamp = ip_tstamps + hash % IP_IDENTS_SZ;
 	atomic_t *p_id = ip_idents + hash % IP_IDENTS_SZ;
-	u32 old = ACCESS_ONCE(*p_tstamp);
+	u32 old = READ_ONCE(*p_tstamp);
 	u32 now = (u32)jiffies;
 	u32 new, delta = 0;
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0bc9e46a5369..48531da1aba6 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1908,7 +1908,7 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	if ((skb != tcp_write_queue_tail(sk)) && (limit >= skb->len))
 		goto send_now;
 
-	win_divisor = ACCESS_ONCE(sysctl_tcp_tso_win_divisor);
+	win_divisor = READ_ONCE(sysctl_tcp_tso_win_divisor);
 	if (win_divisor) {
 		u32 chunk = min(tp->snd_wnd, tp->snd_cwnd * tp->mss_cache);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5676237d2b0f..1049347f2fbc 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1856,7 +1856,7 @@ static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 */
 
 		/* if we're overly short, let UDP handle it */
-		encap_rcv = ACCESS_ONCE(up->encap_rcv);
+		encap_rcv = READ_ONCE(up->encap_rcv);
 		if (encap_rcv) {
 			int ret;
 
@@ -2305,7 +2305,7 @@ void udp_destroy_sock(struct sock *sk)
 	unlock_sock_fast(sk, slow);
 	if (static_key_false(&udp_encap_needed) && up->encap_type) {
 		void (*encap_destroy)(struct sock *sk);
-		encap_destroy = ACCESS_ONCE(up->encap_destroy);
+		encap_destroy = READ_ONCE(up->encap_destroy);
 		if (encap_destroy)
 			encap_destroy(sk);
 	}
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a1c24443cd9e..dab946554157 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -490,7 +490,7 @@ ip6_tnl_err(struct sk_buff *skb, __u8 ipproto, struct inet6_skb_parm *opt,
 	if (!t)
 		goto out;
 
-	tproto = ACCESS_ONCE(t->parms.proto);
+	tproto = READ_ONCE(t->parms.proto);
 	if (tproto != ipproto && tproto != 0)
 		goto out;
 
@@ -899,7 +899,7 @@ static int ipxip6_rcv(struct sk_buff *skb, u8 ipproto,
 	t = ip6_tnl_lookup(dev_net(skb->dev), &ipv6h->saddr, &ipv6h->daddr);
 
 	if (t) {
-		u8 tproto = ACCESS_ONCE(t->parms.proto);
+		u8 tproto = READ_ONCE(t->parms.proto);
 
 		if (tproto != ipproto && tproto != 0)
 			goto drop;
@@ -1233,7 +1233,7 @@ ip4ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
-	tproto = ACCESS_ONCE(t->parms.proto);
+	tproto = READ_ONCE(t->parms.proto);
 	if (tproto != IPPROTO_IPIP && tproto != 0)
 		return -1;
 
@@ -1303,7 +1303,7 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 	u8 tproto;
 	int err;
 
-	tproto = ACCESS_ONCE(t->parms.proto);
+	tproto = READ_ONCE(t->parms.proto);
 	if ((tproto != IPPROTO_IPV6 && tproto != 0) ||
 	    ip6_tnl_addr_conflict(t, ipv6h))
 		return -1;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 40d7234c27b9..3f30fa313bf2 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -606,7 +606,7 @@ static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 */
 
 		/* if we're overly short, let UDP handle it */
-		encap_rcv = ACCESS_ONCE(up->encap_rcv);
+		encap_rcv = READ_ONCE(up->encap_rcv);
 		if (encap_rcv) {
 			int ret;
 
@@ -1432,7 +1432,7 @@ void udpv6_destroy_sock(struct sock *sk)
 
 	if (static_key_false(&udpv6_encap_needed) && up->encap_type) {
 		void (*encap_destroy)(struct sock *sk);
-		encap_destroy = ACCESS_ONCE(up->encap_destroy);
+		encap_destroy = READ_ONCE(up->encap_destroy);
 		if (encap_destroy)
 			encap_destroy(sk);
 	}
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index dd3e83328ad5..82cb93f66b9b 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -193,7 +193,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	rcv = rcu_dereference(sap->rcv_func);
 	dest = llc_pdu_type(skb);
-	sap_handler = dest ? ACCESS_ONCE(llc_type_handlers[dest - 1]) : NULL;
+	sap_handler = dest ? READ_ONCE(llc_type_handlers[dest - 1]) : NULL;
 	if (unlikely(!sap_handler)) {
 		if (rcv)
 			rcv(skb, dev, pt, orig_dev);
@@ -214,7 +214,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 	goto out;
 handle_station:
-	sta_handler = ACCESS_ONCE(llc_station_handler);
+	sta_handler = READ_ONCE(llc_station_handler);
 	if (!sta_handler)
 		goto drop;
 	sta_handler(skb);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 69615016d5bf..214d2ba02877 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2008,7 +2008,7 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u16 rate,
 
 static int sta_set_rate_info_rx(struct sta_info *sta, struct rate_info *rinfo)
 {
-	u16 rate = ACCESS_ONCE(sta_get_last_rx_stats(sta)->last_rate);
+	u16 rate = READ_ONCE(sta_get_last_rx_stats(sta)->last_rate);
 
 	if (rate == STA_STATS_RATE_INVALID)
 		return -EINVAL;
diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calipso.c
index d177dd066504..4d748975117d 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -393,7 +393,7 @@ EXPORT_SYMBOL(netlbl_calipso_ops_register);
 
 static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
 {
-	return ACCESS_ONCE(calipso_ops);
+	return READ_ONCE(calipso_ops);
 }
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 690874293cfc..fe63060e8c1b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14191,7 +14191,7 @@ static bool __nl80211_unexpected_frame(struct net_device *dev, u8 cmd,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct sk_buff *msg;
 	void *hdr;
-	u32 nlportid = ACCESS_ONCE(wdev->ap_unexpected_nlportid);
+	u32 nlportid = READ_ONCE(wdev->ap_unexpected_nlportid);
 
 	if (!nlportid)
 		return false;
diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index 23ccddb20de1..4210e5c6262e 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -247,7 +247,7 @@ void amdtp_am824_midi_trigger(struct amdtp_stream *s, unsigned int port,
 	struct amdtp_am824 *p = s->protocol;
 
 	if (port < p->midi_ports)
-		ACCESS_ONCE(p->midi[port]) = midi;
+		WRITE_ONCE(p->midi[port], midi);
 }
 EXPORT_SYMBOL_GPL(amdtp_am824_midi_trigger);
 
@@ -336,7 +336,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s, __be32 *buffe
 					   unsigned int data_blocks, unsigned int *syt)
 {
 	struct amdtp_am824 *p = s->protocol;
-	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
 	unsigned int pcm_frames;
 
 	if (pcm) {
@@ -357,7 +357,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s, __be32 *buffe
 					   unsigned int data_blocks, unsigned int *syt)
 {
 	struct amdtp_am824 *p = s->protocol;
-	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
 	unsigned int pcm_frames;
 
 	if (pcm) {
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 3fc581a5ad62..4a1dc145327b 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -376,7 +376,7 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 	ptr = s->pcm_buffer_pointer + frames;
 	if (ptr >= pcm->runtime->buffer_size)
 		ptr -= pcm->runtime->buffer_size;
-	ACCESS_ONCE(s->pcm_buffer_pointer) = ptr;
+	WRITE_ONCE(s->pcm_buffer_pointer, ptr);
 
 	s->pcm_period_pointer += frames;
 	if (s->pcm_period_pointer >= pcm->runtime->period_size) {
@@ -388,7 +388,7 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 static void pcm_period_tasklet(unsigned long data)
 {
 	struct amdtp_stream *s = (void *)data;
-	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
 
 	if (pcm)
 		snd_pcm_period_elapsed(pcm);
@@ -453,7 +453,7 @@ static int handle_out_packet(struct amdtp_stream *s,
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
 
-	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
+	buffer[0] = cpu_to_be32(READ_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
 				((s->sph << CIP_SPH_SHIFT) & CIP_SPH_MASK) |
 				s->data_block_counter);
@@ -472,7 +472,7 @@ static int handle_out_packet(struct amdtp_stream *s,
 	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm && pcm_frames > 0)
 		update_pcm_pointers(s, pcm, pcm_frames);
 
@@ -504,7 +504,7 @@ static int handle_out_packet_without_header(struct amdtp_stream *s,
 	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm && pcm_frames > 0)
 		update_pcm_pointers(s, pcm, pcm_frames);
 
@@ -621,7 +621,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 	if (queue_in_packet(s) < 0)
 		return -EIO;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm && pcm_frames > 0)
 		update_pcm_pointers(s, pcm, pcm_frames);
 
@@ -649,7 +649,7 @@ static int handle_in_packet_without_header(struct amdtp_stream *s,
 	if (queue_in_packet(s) < 0)
 		return -EIO;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm && pcm_frames > 0)
 		update_pcm_pointers(s, pcm, pcm_frames);
 
@@ -947,7 +947,7 @@ unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s)
 	if (!in_interrupt() && amdtp_stream_running(s))
 		fw_iso_context_flush_completions(s->context);
 
-	return ACCESS_ONCE(s->pcm_buffer_pointer);
+	return READ_ONCE(s->pcm_buffer_pointer);
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_pointer);
 
@@ -977,9 +977,8 @@ EXPORT_SYMBOL(amdtp_stream_pcm_ack);
 void amdtp_stream_update(struct amdtp_stream *s)
 {
 	/* Precomputing. */
-	ACCESS_ONCE(s->source_node_id_field) =
-		(fw_parent_device(s->unit)->card->node_id << CIP_SID_SHIFT) &
-								CIP_SID_MASK;
+	WRITE_ONCE(s->source_node_id_field,
+                   (fw_parent_device(s->unit)->card->node_id << CIP_SID_SHIFT) & CIP_SID_MASK);
 }
 EXPORT_SYMBOL(amdtp_stream_update);
 
@@ -1022,7 +1021,7 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s)
 {
 	struct snd_pcm_substream *pcm;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm)
 		snd_pcm_stop_xrun(pcm);
 }
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index ed6eafd10992..f9abd8b07ce6 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -220,7 +220,7 @@ static inline bool amdtp_stream_pcm_running(struct amdtp_stream *s)
 static inline void amdtp_stream_pcm_trigger(struct amdtp_stream *s,
 					    struct snd_pcm_substream *pcm)
 {
-	ACCESS_ONCE(s->pcm) = pcm;
+	WRITE_ONCE(s->pcm, pcm);
 }
 
 static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index 1453c34ce99f..4a884a335248 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -327,7 +327,7 @@ void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
 	struct amdtp_dot *p = s->protocol;
 
 	if (port < MAX_MIDI_PORTS)
-		ACCESS_ONCE(p->midi[port]) = midi;
+		WRITE_ONCE(p->midi[port], midi);
 }
 
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
@@ -338,7 +338,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm) {
 		read_pcm_s32(s, pcm, buffer, data_blocks);
 		pcm_frames = data_blocks;
@@ -359,7 +359,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm) {
 		write_pcm_s32(s, pcm, buffer, data_blocks);
 		pcm_frames = data_blocks;
diff --git a/sound/firewire/fireface/amdtp-ff.c b/sound/firewire/fireface/amdtp-ff.c
index 780da9deb2f0..77c7598b61ab 100644
--- a/sound/firewire/fireface/amdtp-ff.c
+++ b/sound/firewire/fireface/amdtp-ff.c
@@ -108,7 +108,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   unsigned int data_blocks,
 					   unsigned int *syt)
 {
-	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
 	unsigned int pcm_frames;
 
 	if (pcm) {
@@ -127,7 +127,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   unsigned int data_blocks,
 					   unsigned int *syt)
 {
-	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
 	unsigned int pcm_frames;
 
 	if (pcm) {
diff --git a/sound/firewire/fireface/ff-midi.c b/sound/firewire/fireface/ff-midi.c
index 949ee56b4e0e..6a49611ee462 100644
--- a/sound/firewire/fireface/ff-midi.c
+++ b/sound/firewire/fireface/ff-midi.c
@@ -22,7 +22,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	ff->running_status[substream->number] = 0;
 	ff->rx_midi_error[substream->number] = false;
 
-	ACCESS_ONCE(ff->rx_midi_substreams[substream->number]) = substream;
+	WRITE_ONCE(ff->rx_midi_substreams[substream->number], substream);
 
 	return 0;
 }
@@ -38,7 +38,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 	struct snd_ff *ff = substream->rmidi->private_data;
 
 	cancel_work_sync(&ff->rx_midi_work[substream->number]);
-	ACCESS_ONCE(ff->rx_midi_substreams[substream->number]) = NULL;
+	WRITE_ONCE(ff->rx_midi_substreams[substream->number], NULL);
 
 	return 0;
 }
@@ -52,10 +52,10 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substream,
 	spin_lock_irqsave(&ff->lock, flags);
 
 	if (up)
-		ACCESS_ONCE(ff->tx_midi_substreams[substream->number]) =
-								substream;
+		WRITE_ONCE(ff->tx_midi_substreams[substream->number],
+			   substream);
 	else
-		ACCESS_ONCE(ff->tx_midi_substreams[substream->number]) = NULL;
+		WRITE_ONCE(ff->tx_midi_substreams[substream->number], NULL);
 
 	spin_unlock_irqrestore(&ff->lock, flags);
 }
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index dd6c8e839647..332b29f8ed75 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -12,7 +12,7 @@ static void finish_transmit_midi_msg(struct snd_ff *ff, unsigned int port,
 				     int rcode)
 {
 	struct snd_rawmidi_substream *substream =
-				ACCESS_ONCE(ff->rx_midi_substreams[port]);
+				READ_ONCE(ff->rx_midi_substreams[port]);
 
 	if (rcode_is_permanent_error(rcode)) {
 		ff->rx_midi_error[port] = true;
@@ -60,7 +60,7 @@ static inline void fill_midi_buf(struct snd_ff *ff, unsigned int port,
 static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
 {
 	struct snd_rawmidi_substream *substream =
-			ACCESS_ONCE(ff->rx_midi_substreams[port]);
+			READ_ONCE(ff->rx_midi_substreams[port]);
 	u8 *buf = (u8 *)ff->msg_buf[port];
 	int i, len;
 
@@ -159,7 +159,7 @@ static void handle_midi_msg(struct fw_card *card, struct fw_request *request,
 		 */
 		index = (quad >> 8) & 0xff;
 		if (index > 0) {
-			substream = ACCESS_ONCE(ff->tx_midi_substreams[0]);
+			substream = READ_ONCE(ff->tx_midi_substreams[0]);
 			if (substream != NULL) {
 				byte = quad & 0xff;
 				snd_rawmidi_receive(substream, &byte, 1);
@@ -169,7 +169,7 @@ static void handle_midi_msg(struct fw_card *card, struct fw_request *request,
 		/* Message in second port. */
 		index = (quad >> 24) & 0xff;
 		if (index > 0) {
-			substream = ACCESS_ONCE(ff->tx_midi_substreams[1]);
+			substream = READ_ONCE(ff->tx_midi_substreams[1]);
 			if (substream != NULL) {
 				byte = (quad >> 16) & 0xff;
 				snd_rawmidi_receive(substream, &byte, 1);
diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 5826aa8362f1..46092fa3ff9b 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -96,7 +96,7 @@ static void isight_update_pointers(struct isight *isight, unsigned int count)
 	ptr += count;
 	if (ptr >= runtime->buffer_size)
 		ptr -= runtime->buffer_size;
-	ACCESS_ONCE(isight->buffer_pointer) = ptr;
+	WRITE_ONCE(isight->buffer_pointer, ptr);
 
 	isight->period_counter += count;
 	if (isight->period_counter >= runtime->period_size) {
@@ -111,7 +111,7 @@ static void isight_samples(struct isight *isight,
 	struct snd_pcm_runtime *runtime;
 	unsigned int count1;
 
-	if (!ACCESS_ONCE(isight->pcm_running))
+	if (!READ_ONCE(isight->pcm_running))
 		return;
 
 	runtime = isight->pcm->runtime;
@@ -131,7 +131,7 @@ static void isight_samples(struct isight *isight,
 
 static void isight_pcm_abort(struct isight *isight)
 {
-	if (ACCESS_ONCE(isight->pcm_active))
+	if (READ_ONCE(isight->pcm_active))
 		snd_pcm_stop_xrun(isight->pcm);
 }
 
@@ -141,7 +141,7 @@ static void isight_dropped_samples(struct isight *isight, unsigned int total)
 	u32 dropped;
 	unsigned int count1;
 
-	if (!ACCESS_ONCE(isight->pcm_running))
+	if (!READ_ONCE(isight->pcm_running))
 		return;
 
 	runtime = isight->pcm->runtime;
@@ -293,7 +293,7 @@ static int isight_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
-	ACCESS_ONCE(isight->pcm_active) = true;
+	WRITE_ONCE(isight->pcm_active, true);
 
 	return 0;
 }
@@ -331,7 +331,7 @@ static int isight_hw_free(struct snd_pcm_substream *substream)
 {
 	struct isight *isight = substream->private_data;
 
-	ACCESS_ONCE(isight->pcm_active) = false;
+	WRITE_ONCE(isight->pcm_active, false);
 
 	mutex_lock(&isight->mutex);
 	isight_stop_streaming(isight);
@@ -424,10 +424,10 @@ static int isight_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		ACCESS_ONCE(isight->pcm_running) = true;
+		WRITE_ONCE(isight->pcm_running, true);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		ACCESS_ONCE(isight->pcm_running) = false;
+		WRITE_ONCE(isight->pcm_running, false);
 		break;
 	default:
 		return -EINVAL;
@@ -439,7 +439,7 @@ static snd_pcm_uframes_t isight_pointer(struct snd_pcm_substream *substream)
 {
 	struct isight *isight = substream->private_data;
 
-	return ACCESS_ONCE(isight->buffer_pointer);
+	return READ_ONCE(isight->buffer_pointer);
 }
 
 static int isight_create_pcm(struct isight *isight)
diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 96f0091144bb..f0555a24d90e 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -310,7 +310,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 	if (p->midi_ports)
 		read_midi_messages(s, buffer, data_blocks);
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (data_blocks > 0 && pcm)
 		read_pcm_s32(s, pcm->runtime, buffer, data_blocks);
 
@@ -374,7 +374,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 	if (p->midi_ports)
 		write_midi_messages(s, buffer, data_blocks);
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm)
 		write_pcm_s32(s, pcm->runtime, buffer, data_blocks);
 	else
diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 02d595665898..f33497cdc706 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -112,7 +112,7 @@ static void handle_hss(struct fw_card *card, struct fw_request *request,
 	}
 
 	if (length >= 1) {
-		stream = ACCESS_ONCE(scs->input);
+		stream = READ_ONCE(scs->input);
 		if (stream)
 			midi_input_packet(scs, stream, data, length);
 	}
@@ -183,7 +183,7 @@ static void scs_output_work(struct work_struct *work)
 	if (scs->transaction_running)
 		return;
 
-	stream = ACCESS_ONCE(scs->output);
+	stream = READ_ONCE(scs->output);
 	if (!stream || scs->error) {
 		scs->output_idle = true;
 		wake_up(&scs->idle_wait);
@@ -291,9 +291,9 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *stream, int up)
 
 	if (up) {
 		scs->input_escape_count = 0;
-		ACCESS_ONCE(scs->input) = stream;
+		WRITE_ONCE(scs->input, stream);
 	} else {
-		ACCESS_ONCE(scs->input) = NULL;
+		WRITE_ONCE(scs->input, NULL);
 	}
 }
 
@@ -319,10 +319,10 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *stream, int up)
 		scs->transaction_bytes = 0;
 		scs->error = false;
 
-		ACCESS_ONCE(scs->output) = stream;
+		WRITE_ONCE(scs->output, stream);
 		schedule_work(&scs->work);
 	} else {
-		ACCESS_ONCE(scs->output) = NULL;
+		WRITE_ONCE(scs->output, NULL);
 	}
 }
 static void midi_playback_drain(struct snd_rawmidi_substream *stream)
diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index 6aff1fc1c72d..ab482423c165 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -124,7 +124,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 {
 	struct snd_pcm_substream *pcm;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (data_blocks > 0 && pcm)
 		read_pcm_s32(s, pcm, buffer, data_blocks);
 
@@ -143,7 +143,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 	/* This field is not used. */
 	*syt = 0x0000;
 
-	pcm = ACCESS_ONCE(s->pcm);
+	pcm = READ_ONCE(s->pcm);
 	if (pcm)
 		write_pcm_s32(s, pcm, buffer, data_blocks);
 	else
diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 8967c52f5032..2ad692dd4b13 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -148,7 +148,7 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 				     void *callback_data)
 {
 	struct snd_fw_async_midi_port *port = callback_data;
-	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
+	struct snd_rawmidi_substream *substream = READ_ONCE(port->substream);
 
 	/* This port is closed. */
 	if (substream == NULL)
@@ -173,7 +173,7 @@ static void midi_port_work(struct work_struct *work)
 {
 	struct snd_fw_async_midi_port *port =
 			container_of(work, struct snd_fw_async_midi_port, work);
-	struct snd_rawmidi_substream *substream = ACCESS_ONCE(port->substream);
+	struct snd_rawmidi_substream *substream = READ_ONCE(port->substream);
 	int generation;
 
 	/* Under transacting or error state. */
@@ -282,7 +282,7 @@ static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
 				bytes = 3;
 		}
 
-		substream = ACCESS_ONCE(tscm->tx_midi_substreams[port]);
+		substream = READ_ONCE(tscm->tx_midi_substreams[port]);
 		if (substream != NULL)
 			snd_rawmidi_receive(substream, b + 1, bytes);
 	}
diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 8382ffa3bcaf..2472144b329e 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -165,7 +165,7 @@ static bool xtfpga_pcm_push_tx(struct xtfpga_i2s *i2s)
 	tx_substream = rcu_dereference(i2s->tx_substream);
 	tx_active = tx_substream && snd_pcm_running(tx_substream);
 	if (tx_active) {
-		unsigned tx_ptr = ACCESS_ONCE(i2s->tx_ptr);
+		unsigned tx_ptr = READ_ONCE(i2s->tx_ptr);
 		unsigned new_tx_ptr = i2s->tx_fn(i2s, tx_substream->runtime,
 						 tx_ptr);
 
@@ -437,7 +437,7 @@ static int xtfpga_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ACCESS_ONCE(i2s->tx_ptr) = 0;
+		WRITE_ONCE(i2s->tx_ptr, 0);
 		rcu_assign_pointer(i2s->tx_substream, substream);
 		xtfpga_pcm_refill_fifo(i2s);
 		break;
@@ -459,7 +459,7 @@ static snd_pcm_uframes_t xtfpga_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct xtfpga_i2s *i2s = runtime->private_data;
-	snd_pcm_uframes_t pos = ACCESS_ONCE(i2s->tx_ptr);
+	snd_pcm_uframes_t pos = READ_ONCE(i2s->tx_ptr);
 
 	return pos < runtime->buffer_size ? pos : 0;
 }
diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 7371e5b06035..fc579f330601 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -108,7 +108,7 @@ static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
 	unsigned int payload_length, tocopy;
 	struct snd_rawmidi_substream *midi_receive_substream;
 
-	midi_receive_substream = ACCESS_ONCE(bcd2k->midi_receive_substream);
+	midi_receive_substream = READ_ONCE(bcd2k->midi_receive_substream);
 	if (!midi_receive_substream)
 		return;
 
@@ -139,7 +139,7 @@ static void bcd2000_midi_send(struct bcd2000 *bcd2k)
 
 	BUILD_BUG_ON(sizeof(device_cmd_prefix) >= BUFSIZE);
 
-	midi_out_substream = ACCESS_ONCE(bcd2k->midi_out_substream);
+	midi_out_substream = READ_ONCE(bcd2k->midi_out_substream);
 	if (!midi_out_substream)
 		return;
 
diff --git a/tools/arch/x86/include/asm/atomic.h b/tools/arch/x86/include/asm/atomic.h
index 328eeceec709..96e2d06cb031 100644
--- a/tools/arch/x86/include/asm/atomic.h
+++ b/tools/arch/x86/include/asm/atomic.h
@@ -24,7 +24,7 @@
  */
 static inline int atomic_read(const atomic_t *v)
 {
-	return ACCESS_ONCE((v)->counter);
+	return READ_ONCE((v)->counter);
 }
 
 /**
diff --git a/tools/include/asm-generic/atomic-gcc.h b/tools/include/asm-generic/atomic-gcc.h
index 5e9738f97bf3..97427e700e3b 100644
--- a/tools/include/asm-generic/atomic-gcc.h
+++ b/tools/include/asm-generic/atomic-gcc.h
@@ -21,7 +21,7 @@
  */
 static inline int atomic_read(const atomic_t *v)
 {
-	return ACCESS_ONCE((v)->counter);
+	return READ_ONCE((v)->counter);
 }
 
 /**
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 33b5e6cdf38c..d19e11b68de7 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -378,7 +378,7 @@ struct addr_filters {
 static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-	u64 head = ACCESS_ONCE(pc->aux_head);
+	u64 head = READ_ONCE(pc->aux_head);
 
 	/* Ensure all reads are done after we read the head */
 	rmb();
@@ -389,7 +389,7 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
 #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	u64 head = ACCESS_ONCE(pc->aux_head);
+	u64 head = READ_ONCE(pc->aux_head);
 #else
 	u64 head = __sync_val_compare_and_swap(&pc->aux_head, 0, 0);
 #endif
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bf2c4936e35f..b6767855d916 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -288,7 +288,7 @@ int perf_evlist__strerror_mmap(struct perf_evlist *evlist, int err, char *buf, s
 static inline u64 perf_mmap__read_head(struct perf_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->base;
-	u64 head = ACCESS_ONCE(pc->data_head);
+	u64 head = READ_ONCE(pc->data_head);
 	rmb();
 	return head;
 }
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 47b5e7dbcb18..aae9645c7122 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -113,7 +113,7 @@ int __perf_session__set_tracepoints_handlers(struct perf_session *session,
 
 extern volatile int session_done;
 
-#define session_done()	ACCESS_ONCE(session_done)
+#define session_done()	READ_ONCE(session_done)
 
 int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9deb5a245b83..ce507ae1d4f5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2302,7 +2302,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 				continue;
 			} else if (pass && i > last_boosted_vcpu)
 				break;
-			if (!ACCESS_ONCE(vcpu->preempted))
+			if (!READ_ONCE(vcpu->preempted))
 				continue;
 			if (vcpu == me)
 				continue;
-- 
2.5.2
