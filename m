Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw1.cosmosbay.com ([62.23.185.226]:44247 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030188AbWBCLDB
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 3 Feb 2006 06:03:01 -0500
Message-ID: <43E33802.6090502@cosmosbay.com>
Date: Fri, 03 Feb 2006 12:01:22 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Subject: Re: percpu data changes
References: <20060203011748.6fe3fee3.akpm@osdl.org> <200602031051.49816.ak@suse.de>
In-Reply-To: <200602031051.49816.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------080506050702030302070900"
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Kyle McMartin <kyle@parisc-linux.org>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@muc.de>, Christian Zankel <chris@zankel.net>, Philippe Elie <phil.el@wanadoo.fr>, Nathan Scott <nathans@sgi.com>, Jens Axboe <axboe@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080506050702030302070900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andi Kleen a écrit :
> On Friday 03 February 2006 10:17, Andrew Morton wrote:
>> It seems that powerpc has gone and changed their implementation of percpu
>> data so that there is no memory allocated for not-possible CPUs.  To save a
>> bit of RAM.
>>
>> This means that any code which does
>>
>> 	for (i = 0; i < NR_CPUS; i++)
>> 		touch(percpudata(i))
>>
>> will explode on powerpc.
> 
> It also explodes since some time on x86-64.
> 
> But I added a workaround now (or rather sent one and Linus dropped it)
> to point the not possible CPUs to the reference data and not free it.
> With that violating that protocol is mostly harmless.
> 
> Later the plan was to point it to unmapped data to catch all users.

Maybe you can port the following i386 patch to x86_64 ? (I dont have a x86_64 
test machine at this moment)

(This was sent to Andrew Jan 29th, and is included in 2.6.16-rc1-mm5)

Eric


--------------080506050702030302070900
Content-Type: text/plain;
 name="i386_mm_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386_mm_init.patch"

--- a/arch/i386/Kconfig.debug	2006-01-29 22:30:10.000000000 +0100
+++ b/arch/i386/Kconfig.debug	2006-01-29 22:35:54.000000000 +0100
@@ -61,6 +61,18 @@
 	  portion of the kernel code won't be covered by a 2MB TLB anymore.
 	  If in doubt, say "N".
 
+config DEBUG_INITDATA
+	bool "Read/Write protect kernel init data structures"
+	depends on DEBUG_KERNEL
+	help
+	  The init data is normally freed when kernel has booted.
+	  Some code may still try to read or write to data in this area.
+	  If you say Y here, the kernel will mark this zone as not readable
+	  or writeable at all. Buggy code will then fault.
+	  This option may have a slight performance impact because a
+	  portion of the kernel code won't be covered by a 2MB TLB anymore.
+	  If in doubt, say "N".
+
 config 4KSTACKS
 	bool "Use 4Kb + 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL
 	default y
--- a/arch/i386/mm/init.c	2006-01-25 10:17:24.000000000 +0100
+++ b/arch/i386/mm/init.c	2006-01-29 22:38:53.000000000 +0100
@@ -750,11 +750,18 @@
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
+#ifdef CONFIG_DEBUG_INITDATA
+		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
+#else
 		memset((void *)addr, 0xcc, PAGE_SIZE);
+#endif
 		free_page(addr);
 		totalram_pages++;
 	}
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
+#ifdef CONFIG_DEBUG_INITDATA
+	global_flush_tlb();
+#endif
 }
 
 void free_initmem(void)

--------------080506050702030302070900--
