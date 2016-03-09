From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: slub: Ensure that slab_unlock() is atomic
Date: Wed, 9 Mar 2016 12:40:54 +0100
Message-ID: <20160309114054.GJ6356@twins.programming.kicks-ass.net>
References: <1457447457-25878-1-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1603080857360.4047@east.gentwo.org>
 <56DEF3D3.6080008@synopsys.com>
 <alpine.DEB.2.20.1603081438020.4268@east.gentwo.org>
 <56DFC604.6070407@synopsys.com>
 <20160309101349.GJ6344@twins.programming.kicks-ass.net>
 <56E0024F.4070401@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56E0024F.4070401@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-parisc@vger.kernel, Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Noam Camus <noamc@ezchip.com>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Christoph Lameter <cl@linux.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 09, 2016 at 04:30:31PM +0530, Vineet Gupta wrote:
> FWIW, could we add some background to commit log, specifically what prompted this.
> Something like below...

Sure.. find below.

> > +++ b/include/asm-generic/bitops/lock.h
> > @@ -29,16 +29,16 @@ do {					\
> >   * @nr: the bit to set
> >   * @addr: the address to start counting from
> >   *
> > + * A weaker form of clear_bit_unlock() as used by __bit_lock_unlock(). If all
> > + * the bits in the word are protected by this lock some archs can use weaker
> > + * ops to safely unlock.
> > + *
> > + * See for example x86's implementation.
> >   */
> 
> To be able to override/use-generic don't we need #ifndef ....

I did not follow through the maze, I think the few archs implementing
this simply do not include this file at all.

I'll let the first person that cares about this worry about that :-)

---
Subject: bitops: Do not default to __clear_bit() for __clear_bit_unlock()

__clear_bit_unlock() is a special little snowflake. While it carries the
non-atomic '__' prefix, it is specifically documented to pair with
test_and_set_bit() and therefore should be 'somewhat' atomic.

Therefore the generic implementation of __clear_bit_unlock() cannot use
the fully non-atomic __clear_bit() as a default.

If an arch is able to do better; is must provide an implementation of
__clear_bit_unlock() itself.

Specifically, this came up as a result of hackbench livelock'ing in
slab_lock() on ARC with SMP + SLUB + !LLSC.

The issue was incorrect pairing of atomic ops.

slab_lock() -> bit_spin_lock() -> test_and_set_bit()
slab_unlock() -> __bit_spin_unlock() -> __clear_bit()

The non serializing __clear_bit() was getting "lost"

80543b8e:	ld_s       r2,[r13,0] <--- (A) Finds PG_locked is set
80543b90:	or         r3,r2,1    <--- (B) other core unlocks right here
80543b94:	st_s       r3,[r13,0] <--- (C) sets PG_locked (overwrites unlock)

Fixes ARC STAR 9000817404 (and probably more).

Cc: stable@vger.kernel.org
Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/bitops/lock.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index c30266e94806..8ef0ccbf8167 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -29,16 +29,16 @@ do {					\
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
- * This operation is like clear_bit_unlock, however it is not atomic.
- * It does provide release barrier semantics so it can be used to unlock
- * a bit lock, however it would only be used if no other CPU can modify
- * any bits in the memory until the lock is released (a good example is
- * if the bit lock itself protects access to the other bits in the word).
+ * A weaker form of clear_bit_unlock() as used by __bit_lock_unlock(). If all
+ * the bits in the word are protected by this lock some archs can use weaker
+ * ops to safely unlock.
+ *
+ * See for example x86's implementation.
  */
 #define __clear_bit_unlock(nr, addr)	\
 do {					\
-	smp_mb();			\
-	__clear_bit(nr, addr);		\
+	smp_mb__before_atomic();	\
+	clear_bit(nr, addr);		\
 } while (0)
 
 #endif /* _ASM_GENERIC_BITOPS_LOCK_H_ */
