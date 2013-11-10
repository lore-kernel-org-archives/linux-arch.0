Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:38511 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752390Ab3KJWzH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Nov 2013 17:55:07 -0500
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave05.hostedemail.com (Postfix) with ESMTP id AEE5F183F39
	for <linux-arch@vger.kernel.org>; Sun, 10 Nov 2013 22:45:06 +0000 (UTC)
Message-ID: <1384123457.3081.33.camel@joe-AO722>
Subject: Re: [tip:x86/asm] x86, bitops:  Change bitops to be native operand
 size
From: Joe Perches <joe@perches.com>
Date: Sun, 10 Nov 2013 14:44:17 -0800
In-Reply-To: <5ac67859-a0b2-47f5-bdc2-c2a52b8d6885@email.android.com>
References: <tip-z61ofiwe90xeyb461o72h8ya@git.kernel.org>
	 <1384117768.3081.10.camel@joe-AO722>
	 <5ac67859-a0b2-47f5-bdc2-c2a52b8d6885@email.android.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, james.t.kukunas@intel.com, hpa@linux.intel.com, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>
Message-ID: <20131110224417.RZsKkq1KVfmDibjdNHxzPoXli9-ANND9crwomc2xM0A@z>

(adding linux-arch, and possible patch below)

On Sun, 2013-11-10 at 14:10 -0800, H. Peter Anvin wrote:
> Yes, on the generic it is int.
> 
> The problem is in part that some architectures have bitop
> instructions with specific behavior.

I think that all bitop indices should be changed
to unsigned (int or long, probably long) for all
arches.

Is there any impediment to that?

I didn't find a negative index used anywhere
but I didn't do an exhaustive search.

There are many different arch specific declarations
of <foo>_bit functions.

For instance:

$ git grep -w clear_bit arch|grep "bitops\.h.*static"
arch/arc/include/asm/bitops.h:static inline void clear_bit(unsigned long nr, volatile unsigned long *m)
arch/arc/include/asm/bitops.h:static inline void clear_bit(unsigned long nr, volatile unsigned long *m)
arch/avr32/include/asm/bitops.h:static inline void clear_bit(int nr, volatile void * addr)
arch/blackfin/include/asm/bitops.h:static inline void clear_bit(int nr, volatile unsigned long *addr)
arch/frv/include/asm/bitops.h:static inline void clear_bit(unsigned long nr, volatile void *addr)
arch/hexagon/include/asm/bitops.h:static inline void clear_bit(int nr, volatile void *addr)
arch/m32r/include/asm/bitops.h:static __inline__ void clear_bit(int nr, volatile void * addr)
arch/metag/include/asm/bitops.h:static inline void clear_bit(unsigned int bit, volatile unsigned long *p)
arch/mips/include/asm/bitops.h:static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
arch/parisc/include/asm/bitops.h:static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
arch/powerpc/include/asm/bitops.h:static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
arch/s390/include/asm/bitops.h:static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
arch/xtensa/include/asm/bitops.h:static inline void clear_bit(unsigned int bit, volatile unsigned long *p)

> Joe Perches <joe@perches.com> wrote:
> >On Tue, 2013-07-16 at 18:15 -0700, tip-bot for H. Peter Anvin wrote:
> >> Commit-ID:  9b710506a03b01a9fdd83962912bc9d8237b82e8
> >[]
> >> x86, bitops: Change bitops to be native operand size
> >> 
> >> Change the bitops operation to be naturally "long", i.e. 63 bits on
> >> the 64-bit kernel.  Additional bugs are likely to crop up in the
> >> future.
> >
> >> We already have bugs which machines with > 16 TiB of memory in a
> >> single node, as can happen if memory is interleaved.  The x86 bitop
> >> operations take a signed index, so using an unsigned type is not an
> >> option.
> >
> >I think it odd that any bitop index nr should be
> >anything other than unsigned long for any arch.
> >
> >Why should this arch be any different than the
> >defined type in Documentation/atomic_ops.txt?
> >
> >What value is a negative index when the bitmap
> >array address passed is the starting 0th bit?
> >
> >btw: asm-generic/bitops.h doesn't match
> >Documentation/atomic_ops.txt either.

---

 include/asm-generic/bitops/atomic.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index 9ae6c34..e4feee5 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -62,7 +62,7 @@ extern arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void set_bit(int nr, volatile unsigned long *addr)
+static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -83,7 +83,7 @@ static inline void set_bit(int nr, volatile unsigned long *addr)
  * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
  * in order to ensure changes are visible on other processors.
  */
-static inline void clear_bit(int nr, volatile unsigned long *addr)
+static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -104,7 +104,7 @@ static inline void clear_bit(int nr, volatile unsigned long *addr)
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void change_bit(int nr, volatile unsigned long *addr)
+static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -124,7 +124,8 @@ static inline void change_bit(int nr, volatile unsigned long *addr)
  * It may be reordered on other architectures than x86.
  * It also implies a memory barrier.
  */
-static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_set_bit(unsigned long nr,
+				   volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -148,7 +149,8 @@ static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
  * It can be reorderdered on other architectures other than x86.
  * It also implies a memory barrier.
  */
-static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_clear_bit(unsigned long nr,
+				     volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -171,7 +173,8 @@ static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+static inline int test_and_change_bit(unsigned long nr,
+				      volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);


