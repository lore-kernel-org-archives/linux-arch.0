From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] change non-atomic bitops method
Date: Mon, 9 Feb 2015 12:34:02 -0800
Message-ID: <20150209123402.1759cb791113cc64483579c5@linux-foundation.org>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
	<20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
	<20150203011730.GA15653@node.dhcp.inet.fi>
	<35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
	<20150202223851.f30768d0.akpm@linux-foundation.org>
	<35FD53F367049845BC99AC72306C23D1044A02027E0D@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0E@CNBJMBX05.corpusers.net>
	<20150203025925.d1c95fb8.akpm@linux-foundation.org>
	<35FD53F367049845BC99AC72306C23D1044A02027E12@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54597 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbbBIUeE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Feb 2015 15:34:04 -0500
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E12@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'Kirill A. Shutemov'" <kirill@shutemov.name>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Mon, 9 Feb 2015 16:18:10 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:

> > That we're running clear_bit against a cleared bit 10% of the time is a
> > bit alarming.  I wonder where that's coming from.
> > 
> > The enormous miss count in test_and_clear_bit() might indicate an
> > inefficiency somewhere.
> I te-test the patch on 3.10 kernel.
> The result like this:
> 
> VmallocChunk:   251498164 kB
> __set_bit_miss_count:11730 __set_bit_success_count:1036316
> __clear_bit_miss_count:209640 __clear_bit_success_count:4806556
> __test_and_set_bit_miss_count:0 __test_and_set_bit_success_count:121
> __test_and_clear_bit_miss_count:0 __test_and_clear_bit_success_count:445
> 
> __clear_bit miss rate is a little high,
> I check the log, and most miss coming from this code:
> 
> <6>[  442.701798] [<ffffffc00021d084>] warn_slowpath_fmt+0x4c/0x58
> <6>[  442.701805] [<ffffffc0002461a8>] __clear_bit+0x98/0xa4
> <6>[  442.701813] [<ffffffc0003126ac>] __alloc_fd+0xc8/0x124
> <6>[  442.701821] [<ffffffc000312768>] get_unused_fd_flags+0x28/0x34
> <6>[  442.701828] [<ffffffc0002f9370>] do_sys_open+0x10c/0x1c0
> <6>[  442.701835] [<ffffffc0002f9458>] SyS_openat+0xc/0x18
> In __clear_close_on_exec(fd, fdt);
> 
> 
> 
> <6>[  442.695354] [<ffffffc00021d084>] warn_slowpath_fmt+0x4c/0x58
> <6>[  442.695359] [<ffffffc0002461a8>] __clear_bit+0x98/0xa4
> <6>[  442.695367] [<ffffffc000312340>] dup_fd+0x1d4/0x280
> <6>[  442.695375] [<ffffffc00021b07c>] copy_process.part.56+0x42c/0xe38
> <6>[  442.695382] [<ffffffc00021bb9c>] do_fork+0xe0/0x360
> <6>[  442.695389] [<ffffffc00021beb4>] SyS_clone+0x10/0x1c
> In __clear_open_fd(open_files - i, new_fdt);
> 
> Do we need test_bit() before clear_bit()at these 2 place?

I don't know.  I was happily typing in this:

diff -puN include/linux/bitops.h~a include/linux/bitops.h
--- a/include/linux/bitops.h~a
+++ a/include/linux/bitops.h
@@ -226,5 +226,37 @@ extern unsigned long find_last_bit(const
 				   unsigned long size);
 #endif
 
+/**
+ * __set_clear_bit - non-atomically set a bit if it is presently clear
+ * @nr: The bit number
+ * @addr: The base address of the operation
+ *
+ * __set_clear_bit() and similar functions avoid unnecessarily dirtying a
+ * cacheline when the operation will have no effect.
+ */
+static inline void __set_clear_bit(unsigned nr, volatile unsigned long *addr)
+{
+	if (!test_bit(nr, addr))
+		__set_bit(nr, addr);
+}
+
+static inline void __clear_set_bit(unsigned nr, volatile unsigned long *addr)
+{
+	if (test_bit(nr, addr))
+		__clear_bit(nr, addr);
+}
+
+static inline void set_clear_bit(unsigned nr, volatile unsigned long *addr)
+{
+	if (!test_bit(nr, addr))
+		set_bit(nr, addr);
+}
+
+static inline void clear_set_bit(unsigned nr, volatile unsigned long *addr)
+{
+	if (test_bit(nr, addr))
+		clear_bit(nr, addr);
+}
+
 #endif /* __KERNEL__ */
 #endif

(maybe __set_bit_if_clear would be a better name)

But I don't know if it will do anything useful.  The CPU *should* be
able to avoid dirtying the cacheline on its own: it has all the info it
needs to know that no writeback will be needed.  But I don't know which
(if any) CPUs perform this optimisation.
