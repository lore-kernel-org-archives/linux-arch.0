From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] locking/qrwlock: Let qrwlock has same layout
 regardless of the endian
Date: Thu, 14 Jul 2016 11:37:33 +0200
Message-ID: <20160714093733.GF30909@twins.programming.kicks-ass.net>
References: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160713195423.GD30921@twins.programming.kicks-ass.net>
 <578742EA.7060108@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45869 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcGNJhm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2016 05:37:42 -0400
Content-Disposition: inline
In-Reply-To: <578742EA.7060108@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, arnd@arndb.de, Waiman.Long@hpe.com

On Thu, Jul 14, 2016 at 03:44:42PM +0800, xinhui wrote:
> >OK, so I poked at this a bit and I ended up with the below; but now
> >qrwlock and qspinlock are inconsistent; although I suspect qspinlock is
> >similarly busted wrt endian muck.
> >
> >Not sure what to do..
> >
> Lets talk about the qspinlock.
> 
> for x86, We has already assumed that ->locked sit at the low 8 bits, as is
> smp_store_release((u8 *)lock, 0);

Right, true on x86 though :-) I noticed your PPC patches have a +3 in
there conditional on __BIG_ENDIAN.

> Then we can do a favor, export ->locked but other fields as reserved.
> say
> 
> struct __qspinlock_unlcok_interface {/* what name is better?*/
> #ifdef __LITTLE_ENDIAN
> 		u8      locked;
> 		u8      reserved[3]; /* do not touch it, internally use only  */
> #else
> 		u8      reserved[3];
> 		u8      locked;
> #endif
> };

Right, maybe, although something like:

static inline u8 *__qspinlock_lock_byte(struct qspinlock *lock)
{
	return (u8 *)lock + 3 * IS_BUILTIN(__BIG_ENDIAN);
}

static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
{
	return (u8 *)lock + 3 * IS_BUILTIN(__BIG_ENDIAN);
}

is shorter?


> >  /*
> >+ * Writer states & reader shift and bias.
> >+ *
> >+ *       | +0 | +1 | +2 | +3 |
> >+ *   ----+----+----+----+----+
> >+ *    LE | 12 | 34 | 56 | 78 | 0x12345678
> >+ *   ----+----+----+----+----+
> >+ *    BE | 78 | 56 | 34 | 12 | 0x12345678
> >+ *   ----+----+----+----+----+
> >+ *       | wr |      rd      |
> >+ *       +----+----+----+----+
> >+ *
> >   */
> 
> very clearly. :)

I did one for the qspinlock code too..

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b2caec7315af..9191dc454e96 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -120,6 +120,23 @@ static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
  *
  * This internal structure is also used by the set_locked function which
  * is not restricted to _Q_PENDING_BITS == 8.
+ *
+ *       | +0 | +1 | +2 | +3 |
+ *   ----+----+----+----+----+
+ *    LE | 78 | 56 | 34 | 12 |	val = 0x12345678
+ *   ----+----+----+----+----+
+ *    LE | 34 | 12 |		locked_pending = 0x1234
+ *   ----+----+----+----+----+
+ *       | L  | P  |  tail   |
+ *       +----+----+----+----+
+ *
+ *   ----+----+----+----+----+
+ *    BE | 12 | 34 | 56 | 78 |	val = 0x12345678
+ *   ----+----+----+----+----+
+ *    BE           | 12 | 34 |	locked_pending = 0x1234
+ *   ----+----+----+----+----+
+ *       |  tail   | P  | L  |
+ *       +----+----+----+----+
  */
 struct __qspinlock {
 	union {
