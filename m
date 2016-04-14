From: Romain Perier <romain.perier@free-electrons.com>
Subject: [PATCH] asm-generic/futex: Properly re-enable preemption in futex_atomic_cmpxchg_inatomic()
Date: Thu, 14 Apr 2016 15:36:03 +0200
Message-ID: <1460640963-690-1-git-send-email-romain.perier@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-arch.vger.kernel.org

The futex subsystem relies on futex_atomic_cmpxchg_inatomic() to
perform an atomic cmpxchg. Most architectures provide their own
implementation. For those who do not, <asm-generic/futex.h> provides a
generic software implementations that works on !SMP platforms.

To provide an atomicity guarantee on !SMP plaforms, the generic
implementation simply disables preemption.
However it is not properly re-enabled from conditional branches.

The observed consequence of this bug is that the preemption counter is
not well balanced. It can be seen at boot time :

[    8.148000] futex hash table entries: 256 (order: -1, 3072 bytes)
[    8.156000] ------------[ cut here ]------------
[    8.164000] WARNING: CPU: 0 PID: 1 at init/main.c:806 do_one_initcall+0x1ac/0x1d0()
[    8.172000] initcall futex_init+0x0/0xd8 returned with preemption imbalance
[    8.180000] Modules linked in:
[    8.184000] CPU: 0 PID: 1 Comm: swapper Not tainted 4.5.0 #72
[    8.192000] Stack from d1c1deb8:
[    8.196000]
[    8.196000]         d1c1debc
[    8.204000]  d1c1defc 00000009
[    8.204000]  d04d8b90 00000326
[    8.208000]  d0000380 d0136484
[    8.212000]  d00093b4

[    8.216000]  00000326 d0000380
[    8.220000]  d1c1c000 00000000
[    8.224000]  d026c64c 00000000
[    8.228000]  d0515004 d0009410
[    8.232000]
[    8.232000]         d1c1defc
[    8.236000]  d04d8d8c d1c1df08
[    8.240000]  d0000380 d026c64c
[    8.244000]  d1c1df10 65657270
[    8.248000]  6974706d

[    8.252000]  69206e6f 6c61626d
[    8.256000]  65636e61 d0780020
[    8.260000]  d05108a0 00000001
[    8.264000]  d00225c8 00000000
[    8.268000]
[    8.268000]         d05103c8
[    8.272000]  0000003f 00060006
[    8.276000]  d05108a0 00000006
[    8.280000]  0000003f 00000007
[    8.284000]  0000003f

[    8.288000]  d052501c d0525024
[    8.288000]  d027d480 d0266c78
[    8.292000]  00000006 00000006
[    8.296000]  00000000 d026627c
[    8.300000]
[    8.300000] Call Trace:

[    8.308000]  [<d025fc58>] [<d025fc68>]
[    8.312000]  [<d025fc58>] [<d000130c>]
[    8.316000]
[    8.316000]

---[ end trace 2d3fe47ac46f91f6 ]---

Before commit 8222dbe21e79
("sched/preempt, mm/fault: Decouple preemption from the page fault logic")
, the preemption was disabled/re-enabled by the
pagefault_disable()/pagefault_enable() functions. It is no longer the
case.

Which means that cmpxchg_futex_value_locked(), in kernel/futex.c, no
longer disables preemption before calling futex_atomic_cmpxchg_inatomic.
Disabling preemption in the generic implementation was added by commit
d9b9ff8c1889 ("sched/preempt, futex: Disable preemption in UP futex_atomic_cmpxchg_inatomic() explicitly").
However, this change is bogus: preemption is not re-enabled in the two failure cases.

Indeed, At boot time futex_detect_cmpxchg(), in kernel/futex.c, checks if
futex_atomic_cmpxchg_inatomic() operation is provided by the current
architecture. To do so, it calls futex_atomic_cmpxchg_inatomic() with a
NULL pointer as the futex, and expects -EFAULT as a return value. The
reasoning if that if -EFAULT is returned, then there is a valid
futex_atomic_cmpxchg_inatomic() implementation, while if -ENOSYS is
returned, then it means that there is no implementation of this function
for the current architecture.

By doing this test based on a NULL pointer, we fall into the case where
the get_user() in the asm-generic version of
futex_atomic_cmpxchg_inatomic() fails, and returns -EFAULT without
re-enabling the preemption, causing the preemption unbalance in the
futex_init() initcall.

This bug was not found, because most of the architectures in the kernel
use their own implementation. This is not the case for the nios2 platform.
By using a nios2 board without SMP support, this bug can be easily
reproduced.

Fixes: d9b9ff8c1889 ("sched/preempt, futex: Disable preemption in UP futex_atomic_cmpxchg_inatomic() explicitly")
Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 include/asm-generic/futex.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index e56272c..bf2d34c 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -108,11 +108,15 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	u32 val;
 
 	preempt_disable();
-	if (unlikely(get_user(val, uaddr) != 0))
+	if (unlikely(get_user(val, uaddr) != 0)) {
+		preempt_enable();
 		return -EFAULT;
+	}
 
-	if (val == oldval && unlikely(put_user(newval, uaddr) != 0))
+	if (val == oldval && unlikely(put_user(newval, uaddr) != 0)) {
+		preempt_enable();
 		return -EFAULT;
+	}
 
 	*uval = val;
 	preempt_enable();
-- 
2.8.0
