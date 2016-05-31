From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 32/33] locking,qrwlock: Employ atomic_fetch_add_acquire()
Date: Tue, 31 May 2016 12:19:57 +0200
Message-ID: <20160531102643.459595230@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-locking-qspinlock-fetch-add.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

The only reason for the current code is to make GCC emit only the
"LOCK XADD" instruction on x86 (and not do a pointless extra ADD on
the result), do so nicer.

Acked-by: Waiman Long <waiman.long@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/qrwlock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -93,7 +93,7 @@ void queued_read_lock_slowpath(struct qr
 	 * that accesses can't leak upwards out of our subsequent critical
 	 * section in the case that the lock is currently held for write.
 	 */
-	cnts = atomic_add_return_acquire(_QR_BIAS, &lock->cnts) - _QR_BIAS;
+	cnts = atomic_fetch_add_acquire(_QR_BIAS, &lock->cnts);
 	rspin_until_writer_unlock(lock, cnts);
 
 	/*
