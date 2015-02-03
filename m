From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: [RFC] change non-atomic bitops method
Date: Tue, 3 Feb 2015 16:42:14 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1044A02027E0E@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
	<20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
	<20150203011730.GA15653@node.dhcp.inet.fi>
	<35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
 <20150202223851.f30768d0.akpm@linux-foundation.org>
 <35FD53F367049845BC99AC72306C23D1044A02027E0D@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cnbjrel01.sonyericsson.com ([219.141.167.165]:15266 "EHLO
	cnbjrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752168AbbBCImT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Feb 2015 03:42:19 -0500
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0D@CNBJMBX05.corpusers.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: "'Kirill A. Shutemov'" <kirill@shutemov.name>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Wang, Yalin
> Sent: Tuesday, February 03, 2015 3:04 PM
> To: 'Andrew Morton'
> Cc: 'Kirill A. Shutemov'; 'arnd@arndb.de'; 'linux-arch@vger.kernel.org';
> 'linux-kernel@vger.kernel.org'; 'linux@arm.linux.org.uk'; 'linux-arm-
> kernel@lists.infradead.org'
> Subject: RE: [RFC] change non-atomic bitops method
> 
> > -----Original Message-----
> > From: Andrew Morton [mailto:akpm@linux-foundation.org]
> > Sent: Tuesday, February 03, 2015 2:39 PM
> > To: Wang, Yalin
> > Cc: 'Kirill A. Shutemov'; 'arnd@arndb.de'; 'linux-arch@vger.kernel.org';
> > 'linux-kernel@vger.kernel.org'; 'linux@arm.linux.org.uk'; 'linux-arm-
> > kernel@lists.infradead.org'
> > Subject: Re: [RFC] change non-atomic bitops method
> >
> > On Tue, 3 Feb 2015 13:42:45 +0800 "Wang, Yalin"
> <Yalin.Wang@sonymobile.com>
> > wrote:
> > >
> > > ...
> > >
> > > #ifdef CHECK_BEFORE_SET
> > > 			if (p[i] != times)
> > > #endif
> > >
> > > ...
> > >
> > > ----
> > > One run on CPU0, reader thread run on CPU1,
> > > Test result:
> > > sudo ./cache_test
> > > reader:8.426228173
> > > 8.672198335
> > >
> > > With -DCHECK_BEFORE_SET
> > > sudo ./cache_test_check
> > > reader:7.537036819
> > > 10.799746531
> > >
> >
> > You aren't measuring the right thing.  You should compare
> >
> > 	if (p[i] != x)
> > 		p[i] = x;
> >
> > versus
> >
> > 	p[i] = x;
> >
> > and you should do this for two cases:
> >
> > a) p[i] == x
> >
> > b) p[i] != x
> >
> >
> > The first code sequence will be slower when (p[i] != x) and faster when
> > (p[i] == x).
> >
> >
> > Next, we should instrument the kernel to work out the frequency of
> > set_bit on an already-set bit.
> >
> > It is only with both these ratios that we can work out whether the
> > patch is a net gain.  My suspicion is that set_bit on an already-set
> > bit is so rare that the patch will be a loss.
> I see, let's change the test a little:
> 1)
> 	memset(p, 0, SIZE);
> 	if (p[i] != 0)
> 		p[i] = 0;  // never called
> 
> 	#sudo ./cache_test_check
> 	6.698153838
> 	reader:7.529402625
> 
> 
> 2)
> 	memset(p, 0, SIZE);
> 	if (p[i] == 0)
> 		p[i] = 0; // always called
> 	#sudo ./cache_test_check
> 	reader:7.895421311
> 	9.000889973
> 
> Thanks
> 
> 
I make a change in kernel to test hit/miss ratio:
---
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 80e4645..a82937b 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -2,6 +2,7 @@
 #include <linux/hugetlb.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/mmzone.h>
@@ -15,6 +16,41 @@
 #include <asm/pgtable.h>
 #include "internal.h"
 
+atomic_t __set_bit_success_count = ATOMIC_INIT(0);
+atomic_t __set_bit_miss_count = ATOMIC_INIT(0);
+EXPORT_SYMBOL_GPL(__set_bit_success_count);
+EXPORT_SYMBOL_GPL(__set_bit_miss_count);
+
+atomic_t __clear_bit_success_count = ATOMIC_INIT(0);
+atomic_t __clear_bit_miss_count = ATOMIC_INIT(0);
+EXPORT_SYMBOL_GPL(__clear_bit_success_count);
+EXPORT_SYMBOL_GPL(__clear_bit_miss_count);
+
+atomic_t __test_and_set_bit_success_count = ATOMIC_INIT(0);
+atomic_t __test_and_set_bit_miss_count = ATOMIC_INIT(0);
+EXPORT_SYMBOL_GPL(__test_and_set_bit_success_count);
+EXPORT_SYMBOL_GPL(__test_and_set_bit_miss_count);
+
+atomic_t __test_and_clear_bit_success_count = ATOMIC_INIT(0);
+atomic_t __test_and_clear_bit_miss_count = ATOMIC_INIT(0);
+EXPORT_SYMBOL_GPL(__test_and_clear_bit_success_count);
+EXPORT_SYMBOL_GPL(__test_and_clear_bit_miss_count);
+
+/*
+ * atomic bitops
+ */
+atomic_t set_bit_success_count = ATOMIC_INIT(0);
+atomic_t set_bit_miss_count = ATOMIC_INIT(0);
+
+atomic_t clear_bit_success_count = ATOMIC_INIT(0);
+atomic_t clear_bit_miss_count = ATOMIC_INIT(0);
+
+atomic_t test_and_set_bit_success_count = ATOMIC_INIT(0);
+atomic_t test_and_set_bit_miss_count = ATOMIC_INIT(0);
+
+atomic_t test_and_clear_bit_success_count = ATOMIC_INIT(0);
+atomic_t test_and_clear_bit_miss_count = ATOMIC_INIT(0);
+
 void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
 {
 }
@@ -165,6 +201,18 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		   HPAGE_PMD_NR)
 #endif
 		);
+	seq_printf(m,   "__set_bit_miss_count:%d __set_bit_success_count:%d\n"
+			"__clear_bit_miss_count:%d __clear_bit_success_count:%d\n"
+			"__test_and_set_bit_miss_count:%d __test_and_set_bit_success_count:%d\n"
+			"__test_and_clear_bit_miss_count:%d __test_and_clear_bit_success_count:%d\n",
+			atomic_read(&__set_bit_miss_count), atomic_read(&__set_bit_success_count),
+			atomic_read(&__clear_bit_miss_count), atomic_read(&__clear_bit_success_count),
+
+			atomic_read(&__test_and_set_bit_miss_count),
+			atomic_read(&__test_and_set_bit_success_count),
+
+			atomic_read(&__test_and_clear_bit_miss_count),
+			atomic_read(&__test_and_clear_bit_success_count));
 
 	hugetlb_report_meminfo(m);
 
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index 697cc2b..1895133 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -2,7 +2,18 @@
 #define _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
 
 #include <asm/types.h>
+#include <asm/atomic.h>
+extern atomic_t __set_bit_success_count;
+extern atomic_t __set_bit_miss_count;
 
+extern atomic_t __clear_bit_success_count;
+extern atomic_t __clear_bit_miss_count;
+
+extern atomic_t __test_and_set_bit_success_count;
+extern atomic_t __test_and_set_bit_miss_count;
+
+extern atomic_t __test_and_clear_bit_success_count;
+extern atomic_t __test_and_clear_bit_miss_count;
 /**
  * __set_bit - Set a bit in memory
  * @nr: the bit to set
@@ -17,7 +28,13 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 
-	*p  |= mask;
+	if ((*p & mask) == 0) {
+		atomic_inc(&__set_bit_success_count);
+		*p  |= mask;
+	} else {
+		atomic_inc(&__set_bit_miss_count);
+	}
+
 }
 
 static inline void __clear_bit(int nr, volatile unsigned long *addr)
@@ -25,7 +42,12 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 
-	*p &= ~mask;
+	if ((*p & mask) != 0) {
+		atomic_inc(&__clear_bit_success_count);
+		*p &= ~mask;
+	} else {
+		atomic_inc(&__clear_bit_miss_count);
+	}
 }
 
 /**
@@ -60,7 +82,12 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 	unsigned long old = *p;
 
-	*p = old | mask;
+	if ((old & mask) == 0) {
+		atomic_inc(&__test_and_set_bit_success_count);
+		*p = old | mask;
+	} else {
+		atomic_inc(&__test_and_set_bit_miss_count);
+	}
 	return (old & mask) != 0;
 }
 
@@ -79,7 +106,12 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 	unsigned long old = *p;
 
-	*p = old & ~mask;
+	if ((old & mask) != 0) {
+		atomic_inc(&__test_and_clear_bit_success_count);
+		*p = old & ~mask;
+	} else {
+		atomic_inc(&__test_and_clear_bit_miss_count);
+	}
 	return (old & mask) != 0;
 }
---
After use the phone some time:
root@D5303:/ # cat /proc/meminfo
VmallocUsed:       10348 kB
VmallocChunk:      75632 kB
__set_bit_miss_count:10002 __set_bit_success_count:1096661
__clear_bit_miss_count:359484 __clear_bit_success_count:3674617
__test_and_set_bit_miss_count:7 __test_and_set_bit_success_count:221
__test_and_clear_bit_miss_count:924611 __test_and_clear_bit_success_count:193

__test_and_clear_bit_miss_count has a very high miss rate.
In fact, I think set/clear/test_and_set(clear)_bit atomic version can also
Be investigated to see its miss ratio,
I have not tested the atomic version,
Because it reside in different architectures.

Thanks
