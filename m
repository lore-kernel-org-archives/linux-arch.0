From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: [PATCH 1/3] Make asm/word-at-a-time.h available on all architectures
Date: Thu, 30 Apr 2015 12:01:15 -0400
Message-ID: <1430409677-13284-2-git-send-email-cmetcalf@ezchip.com>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Added the x86 implementation of word-at-a-time to the
generic version, which previously only supported big-endian.

Omitted the x86-specific load_unaligned_zeropad(), which in
any case is also not present for the existing BE-only
implementation of a word-at-a-time, and is only used under
CONFIG_DCACHE_WORD_ACCESS.

Added as a "generic-y" to the Kbuilds of all architectures
that didn't previously have it.

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 arch/arc/include/asm/Kbuild          |  1 +
 arch/avr32/include/asm/Kbuild        |  1 +
 arch/blackfin/include/asm/Kbuild     |  1 +
 arch/c6x/include/asm/Kbuild          |  1 +
 arch/cris/include/asm/Kbuild         |  1 +
 arch/frv/include/asm/Kbuild          |  1 +
 arch/hexagon/include/asm/Kbuild      |  1 +
 arch/ia64/include/asm/Kbuild         |  1 +
 arch/m32r/include/asm/Kbuild         |  1 +
 arch/metag/include/asm/Kbuild        |  1 +
 arch/microblaze/include/asm/Kbuild   |  1 +
 arch/mips/include/asm/Kbuild         |  1 +
 arch/mn10300/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild        |  1 +
 arch/powerpc/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild         |  1 +
 arch/score/include/asm/Kbuild        |  1 +
 arch/tile/include/asm/Kbuild         |  1 +
 arch/um/include/asm/Kbuild           |  1 +
 arch/unicore32/include/asm/Kbuild    |  1 +
 arch/xtensa/include/asm/Kbuild       |  1 +
 include/asm-generic/word-at-a-time.h | 80 ++++++++++++++++++++++++++++++++----
 22 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index be0c39e76f7c..be895ef03a51 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -49,4 +49,5 @@ generic-y += types.h
 generic-y += ucontext.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/avr32/include/asm/Kbuild b/arch/avr32/include/asm/Kbuild
index 528d70d47a54..10dd6e8470bd 100644
--- a/arch/avr32/include/asm/Kbuild
+++ b/arch/avr32/include/asm/Kbuild
@@ -20,4 +20,5 @@ generic-y += sections.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
index 4bd3c3cfc9ab..9705a527b7b0 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -46,4 +46,5 @@ generic-y += types.h
 generic-y += ucontext.h
 generic-y += unaligned.h
 generic-y += user.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index ae0a51f5376c..535efdb0692d 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -59,4 +59,5 @@ generic-y += types.h
 generic-y += ucontext.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index 057e51859b0a..4991539a25f6 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -26,4 +26,5 @@ generic-y += sections.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
index e3f81b53578e..ca34d1cf2cdf 100644
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index c7a99f860b40..872920fba0a6 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -58,4 +58,5 @@ generic-y += types.h
 generic-y += ucontext.h
 generic-y += unaligned.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 9b41b4bcc073..614579fa1e49 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += trace_clock.h
 generic-y += vtime.h
+generic-y += word-at-a-time.h
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index 2edc793372fc..36f850dd4a1e 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
index 0bf5d525b945..a291b3b2529e 100644
--- a/arch/metag/include/asm/Kbuild
+++ b/arch/metag/include/asm/Kbuild
@@ -54,4 +54,5 @@ generic-y += ucontext.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index ab564a6db5c3..966f221b2d67 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -10,3 +10,4 @@ generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += syscalls.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 526539cbc99f..c3cfb83aca1d 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -18,4 +18,5 @@ generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += ucontext.h
 generic-y += user.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbuild
index f892d9de47d9..30a06e2d6e42 100644
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 24b3d8999ac7..bc87081c0669 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -61,4 +61,5 @@ generic-y += types.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 4b87205c230c..dfc61a151890 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y += rwsem.h
 generic-y += scatterlist.h
 generic-y += trace_clock.h
 generic-y += vtime.h
+generic-y += word-at-a-time.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index c631f98fd524..27c37b3d1dad 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
index 83ed116d414c..16958f529aa7 100644
--- a/arch/score/include/asm/Kbuild
+++ b/arch/score/include/asm/Kbuild
@@ -13,3 +13,4 @@ generic-y += sections.h
 generic-y += trace_clock.h
 generic-y += xor.h
 generic-y += serial.h
+generic-y += word-at-a-time.h
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index f5433e0e34e0..0804122e579a 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -39,4 +39,5 @@ generic-y += termbits.h
 generic-y += termios.h
 generic-y += trace_clock.h
 generic-y += types.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 9176fa11d49b..ee02364d8922 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -26,4 +26,5 @@ generic-y += sections.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 3e0c19d0f4c5..f456bfa1dd54 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -62,4 +62,5 @@ generic-y += ucontext.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 86a9ab2e2ca9..6ac0a9ab3ea3 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -29,4 +29,5 @@ generic-y += statfs.h
 generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/word-at-a-time.h
index 94f9ea8abcae..011dde083f23 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -1,15 +1,10 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-/*
- * This says "generic", but it's actually big-endian only.
- * Little-endian can use more efficient versions of these
- * interfaces, see for example
- *	 arch/x86/include/asm/word-at-a-time.h
- * for those.
- */
-
 #include <linux/kernel.h>
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN
 
 struct word_at_a_time {
 	const unsigned long high_bits, low_bits;
@@ -53,4 +48,73 @@ static inline bool has_zero(unsigned long val, unsigned long *data, const struct
 #define zero_bytemask(mask) (~1ul << __fls(mask))
 #endif
 
+#else
+
+/*
+ * The optimal byte mask counting is probably going to be something
+ * that is architecture-specific. If you have a reliably fast
+ * bit count instruction, that might be better than the multiply
+ * and shift, for example.
+ */
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+#ifdef CONFIG_64BIT
+
+/*
+ * Jan Achrenius on G+: microoptimized version of
+ * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
+ * that works for the bytemasks without having to
+ * mask them first.
+ */
+static inline long count_masked_bytes(unsigned long mask)
+{
+	return mask*0x0001020304050608ul >> 56;
+}
+
+#else	/* 32-bit case */
+
+/* Carl Chatfield / Jan Achrenius G+ version for 32-bit */
+static inline long count_masked_bytes(long mask)
+{
+	/* (000000 0000ff 00ffff ffffff) -> ( 1 1 2 3 ) */
+	long a = (0x0ff0001+mask) >> 23;
+	/* Fix the 1 for 00 case */
+	return a & mask;
+}
+
+#endif
+
+/* Return nonzero if it has a zero */
+static inline unsigned long has_zero(unsigned long a, unsigned long *bits, const struct word_at_a_time *c)
+{
+	unsigned long mask = ((a - c->one_bits) & ~a) & c->high_bits;
+	*bits = mask;
+	return mask;
+}
+
+static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits, const struct word_at_a_time *c)
+{
+	return bits;
+}
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+/* The mask we created is directly usable as a bytemask */
+#define zero_bytemask(mask) (mask)
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return count_masked_bytes(mask);
+}
+
+#endif /* __BIG_ENDIAN */
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
-- 
2.1.2
