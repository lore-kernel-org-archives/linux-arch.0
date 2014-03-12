From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v6 04/11] qspinlock: Optimized code path for 2 contending
	tasks
Date: Wed, 12 Mar 2014 15:08:24 -0400
Message-ID: <5320B0A8.8030805@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-5-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1394650498-30118-5-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu>
List-Id: linux-arch.vger.kernel.org

On 03/12/2014 02:54 PM, Waiman Long wrote:
> +
> +		/*
> +		 * Now wait until the lock bit is cleared
> +		 */
> +		while (smp_load_acquire(&qlock->qlcode)&  _QSPINLOCK_LOCKED)
> +			arch_mutex_cpu_relax();
> +
> +		/*
> +		 * Set the lock bit&  clear the waiting bit simultaneously
> +		 * It is assumed that there is no lock stealing with this
> +		 * quick path active.
> +		 *
> +		 * A direct memory store of _QSPINLOCK_LOCKED into the
> +		 * lock_wait field causes problem with the lockref code, e.g.
> +		 *   ACCESS_ONCE(qlock->lock_wait) = _QSPINLOCK_LOCKED;
> +		 *
> +		 * It is not currently clear why this happens. A workaround
> +		 * is to use atomic instruction to store the new value.
> +		 */
> +		{
> +			u16 lw = xchg(&qlock->lock_wait, _QSPINLOCK_LOCKED);
> +			BUG_ON(lw != _QSPINLOCK_WAITING);
> +		}
> +		return 1;
>

It was found that when I used a direct memory store instead of an atomic 
op, the following kernel crash might happen at filesystem dismount time:

Red Hat Enterprise Linux Server 7.0 (Maipo)
Kernel 3.14.0-rc6-qlock on an x86_64

h11-kvm20 login: [ 1529.934047] BUG: Dentry 
ffff883f4c048480{i=30181e9e,n=libopc
odes-2.23.52.0.1-15.el7.so} still in use (-1) [unmount of xfs dm-1]
[ 1529.935762] ------------[ cut here ]------------
[ 1529.936331] kernel BUG at fs/dcache.c:1343!
[ 1529.936714] invalid opcode: 0000 [#1] SMP
[ 1529.936714] Modules linked in: ext4 mbcache jbd2 binfmt_misc brd 
ip6t_rpfilte
r cfg80211 ip6t_REJECT rfkill ipt_REJECT xt_conntrack ebtable_nat 
ebtable_broute
  bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 
nf_defrag
_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw 
ip6table_filter
  ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 
nf_nat nf_c
onntrack iptable_mangle iptable_security iptable_raw iptable_filter 
ip_tables sg
  ppdev snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hwdep 
snd_seq snd_s
eq_device snd_pcm snd_timer snd parport_pc parport soundcore serio_raw 
i2c_piix4
  virtio_console virtio_balloon microcode pcspkr nfsd auth_rpcgss 
nfs_acl lockd s
unrpc uinput xfs libcrc32c sr_mod cdrom ata_generic pata_acpi qxl 
virtio_blk vir
tio_net drm_kms_helper ttm drm ata_piix libata virtio_pci virtio_ring 
floppy i2c
_core virtio dm_mirror dm_region_hash dm_log dm_mod
[ 1529.936714] CPU: 12 PID: 11106 Comm: umount Not tainted 
3.14.0-rc6-qlock #1
[ 1529.936714] Hardware name: Red Hat KVM, BIOS Bochs 01/01/2011
[ 1529.936714] task: ffff881f9183b540 ti: ffff881f920fa000 task.ti: 
ffff881f920f
a000
[ 1529.936714] RIP: 0010:[<ffffffff811c185c>]  [<ffffffff811c185c>] 
umount_colle
ct+0xec/0x110
[ 1529.936714] RSP: 0018:ffff881f920fbdc8  EFLAGS: 00010282
[ 1529.936714] RAX: 0000000000000073 RBX: ffff883f4c048480 RCX: 
0000000000000000
[ 1529.936714] RDX: 0000000000000001 RSI: 0000000000000046 RDI: 
0000000000000246
[ 1529.936714] RBP: ffff881f920fbde0 R08: ffffffff819e42e0 R09: 
0000000000000396
[ 1529.936714] R10: 0000000000000000 R11: ffff881f920fbb06 R12: 
ffff881f920fbe60
[ 1529.936714] R13: ffff883f8d458460 R14: ffff883f4c048480 R15: 
ffff883f8d4583c0
[ 1529.936714] FS:  00007f6027b0c880(0000) GS:ffff88403fc40000(0000) 
knlGS:00000
00000000000
[ 1529.936714] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1529.936714] CR2: 00007f60276c4900 CR3: 0000003f421c0000 CR4: 
00000000000006e0
[ 1529.936714] Stack:
[ 1529.936714]  ffff883f8edf4ac8 ffff883f4c048510 ffff883f910a02d0 
ffff881f920fb
e50
[ 1529.936714]  ffffffff811c2d03 0000000000000000 00ff881f920fbe50 
0000896600000
000
[ 1529.936714]  ffff883f8d4587d8 ffff883f8d458780 ffffffff811c1770 
ffff881f920fb
e60
[ 1529.936714] Call Trace:
[ 1529.936714]  [<ffffffff811c2d03>] d_walk+0xc3/0x260
[ 1529.936714]  [<ffffffff811c1770>] ? check_and_collect+0x30/0x30
[ 1529.936714]  [<ffffffff811c3985>] shrink_dcache_for_umount+0x75/0x120
[ 1529.936714]  [<ffffffff811adf21>] generic_shutdown_super+0x21/0xf0
[ 1529.936714]  [<ffffffff811ae207>] kill_block_super+0x27/0x70
[ 1529.936714]  [<ffffffff811ae4ed>] deactivate_locked_super+0x3d/0x60
[ 1529.936714]  [<ffffffff811aea96>] deactivate_super+0x46/0x60
[ 1529.936714]  [<ffffffff811ca277>] mntput_no_expire+0xa7/0x140
[ 1529.936714]  [<ffffffff811cb6ce>] SyS_umount+0x8e/0x100
[ 1529.936714]  [<ffffffff815d2c29>] system_call_fastpath+0x16/0x1b
[ 1529.936714] Code: 00 00 48 8b 40 28 4c 8b 08 48 8b 43 30 48 85 c0 74 
2a 48 8b
  50 40 48 89 34 24 48 c7 c7 e0 4a 7f 81 48 89 de 31 c0 e8 03 cb 3f 00 
<0f> 0b 66
  90 48 89 f7 e8 c8 fc ff ff e9 66 ff ff ff 31 d2 90 eb
[ 1529.936714] RIP  [<ffffffff811c185c>] umount_collect+0xec/0x110
[ 1529.936714]  RSP <ffff881f920fbdc8>
[ 1529.976523] ---[ end trace 6c8ce7cee0969bbb ]---
[ 1529.977137] Kernel panic - not syncing: Fatal exception
[ 1529.978119] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation 
range: 0xf
fffffff80000000-0xffffffff9fffffff)
[ 1529.978119] drm_kms_helper: panic occurred, switching back to text 
console

It was more readily reproducible in a KVM guest. It was harder to 
reproduce in a bare metal machine, but kernel crash still happened after 
several tries.

I am not sure what exactly cause this crash, but it will have something 
to do with the interaction between the lockref and the qspinlock code. I 
would like more eyes on that to find the root cause of it.

-Longman
