From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Fri, 05 Jan 2018 17:10:26 -0800
Message-ID: <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When access_ok fails we should always stop speculating.
Add the required barriers to the x86 access_ok macro.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/uaccess.h |   17 +++++++++++++----
 include/asm-generic/barrier.h  |    6 +++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 574dff4d2913..9b6f20cfaeb9 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -43,6 +43,8 @@ static inline void set_fs(mm_segment_t fs)
 /*
  * Test whether a block of memory is a valid user space address.
  * Returns 0 if the range is valid, nonzero otherwise.
+ *
+ * We also disable speculation when a check fails.
  */
 static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, unsigned long limit)
 {
@@ -53,14 +55,19 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 	 * important to subtract the size from the
 	 * limit, not add it to the address).
 	 */
-	if (__builtin_constant_p(size))
-		return unlikely(addr > limit - size);
+	if (__builtin_constant_p(size)) {
+		if (unlikely(addr > limit - size))
+			return true;
+		nospec_barrier();
+		return false;
+	}
 
 	/* Arbitrary sizes? Be careful about overflow */
 	addr += size;
-	if (unlikely(addr < size))
+	if (unlikely(addr < size || addr > limit))
 		return true;
-	return unlikely(addr > limit);
+	nospec_barrier();
+	return false;
 }
 
 #define __range_not_ok(addr, size, limit)				\
@@ -94,6 +101,8 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
  * Note that, depending on architecture, this function probably just
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
+ *
+ * Stops speculation automatically
  */
 #define access_ok(type, addr, size)					\
 ({									\
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 91c3071f49e5..a11765eba860 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -59,7 +59,9 @@
  *
  * Architectures with a suitable memory barrier should provide an
  * implementation. This is non-portable, and generic code should use
- * nospec_ptr().
+ * nospec_{array_ptr,ptr}. Arch-specific code should define and use
+ * nospec_barrier() for usages where nospec_{array_ptr,ptr} is
+ * unsuitable.
  */
 #ifndef __nospec_barrier
 #define __nospec_barrier()		do { } while (0)
@@ -120,8 +122,6 @@
 	nospec_ptr(__arr + __idx, __arr, __arr + __sz);			\
 })
 
-#undef __nospec_barrier
-
 #ifndef __smp_mb
 #define __smp_mb()	mb()
 #endif
