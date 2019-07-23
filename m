Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731025AbfGWV1u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jul 2019 17:27:50 -0400
Date: Tue, 23 Jul 2019 14:27:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Message-ID: <20190723142747.8efd9ab06518470ec8067306@linux-foundation.org>
In-Reply-To: <1563914986-26502-1-git-send-email-cai@lca.pw>
References: <1563914986-26502-1-git-send-email-cai@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: davem@davemloft.net, arnd@arndb.de, dhowells@redhat.com, jakub@redhat.com, ndesaulniers@google.com, morbo@google.com, jyknight@google.com, natechancellor@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190723212747.xXN8EpumtZWpuvr82vn42JyE8AOhYyuFUH1GeotYO4A@z>

On Tue, 23 Jul 2019 16:49:46 -0400 Qian Cai <cai@lca.pw> wrote:

> The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
> compilation warning because "rx_frag_size" is an "ushort" while
> PAGE_SHIFT here is 16. The commit changed the get_order() to be a
> multi-line macro where compilers insist to check all statements in the
> macro even when __builtin_constant_p(rx_frag_size) will return false as
> "rx_frag_size" is a module parameter.
> 
> In file included from ./arch/powerpc/include/asm/page_64.h:107,
>                  from ./arch/powerpc/include/asm/page.h:242,
>                  from ./arch/powerpc/include/asm/mmu.h:132,
>                  from ./arch/powerpc/include/asm/lppaca.h:47,
>                  from ./arch/powerpc/include/asm/paca.h:17,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/thread_info.h:21,
>                  from ./arch/powerpc/include/asm/processor.h:39,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
> drivers/net/ethernet/emulex/benet/be_main.c: In function
> 'be_rx_cqs_create':
> ./include/asm-generic/getorder.h:54:9: warning: comparison is always
> true due to limited range of data type [-Wtype-limits]
>    (((n) < (1UL << PAGE_SHIFT)) ? 0 :  \
>          ^
> drivers/net/ethernet/emulex/benet/be_main.c:3138:33: note: in expansion
> of macro 'get_order'
>   adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
>                                  ^~~~~~~~~
> 
> Fix it by moving almost all of this multi-line macro into a proper
> function __get_order(), and leave get_order() as a single-line macro in
> order to avoid compilation errors.
> 
> ...
>
> --- a/include/asm-generic/getorder.h
> +++ b/include/asm-generic/getorder.h
> @@ -15,6 +15,16 @@ int __get_order(unsigned long size)
>  {
>  	int order;
>  
> +	if (__builtin_constant_p(size)) {
> +		if (!size)
> +			return BITS_PER_LONG - PAGE_SHIFT;
> +
> +		if (size < (1UL << PAGE_SHIFT))
> +			return 0;
> +
> +		return ilog2((size) - 1) - PAGE_SHIFT + 1;
> +	}
> +
>  	size--;
>  	size >>= PAGE_SHIFT;
>  #if BITS_PER_LONG == 32
> @@ -49,11 +59,6 @@ int __get_order(unsigned long size)
>   */
>  #define get_order(n)						\
>  (								\
> -	__builtin_constant_p(n) ? (				\
> -		((n) == 0UL) ? BITS_PER_LONG - PAGE_SHIFT :	\
> -		(((n) < (1UL << PAGE_SHIFT)) ? 0 :		\
> -		 ilog2((n) - 1) - PAGE_SHIFT + 1)		\
> -	) :							\
>  	__get_order(n)						\
>  )

So we can remove __get_order() altogether now?

--- a/include/asm-generic/getorder.h~asm-generic-fix-wtype-limits-compiler-warnings-fix
+++ a/include/asm-generic/getorder.h
@@ -7,11 +7,29 @@
 #include <linux/compiler.h>
 #include <linux/log2.h>
 
-/*
- * Runtime evaluation of get_order()
+/**
+ * get_order - Determine the allocation order of a memory size
+ * @size: The size for which to get the order
+ *
+ * Determine the allocation order of a particular sized block of memory.  This
+ * is on a logarithmic scale, where:
+ *
+ *	0 -> 2^0 * PAGE_SIZE and below
+ *	1 -> 2^1 * PAGE_SIZE to 2^0 * PAGE_SIZE + 1
+ *	2 -> 2^2 * PAGE_SIZE to 2^1 * PAGE_SIZE + 1
+ *	3 -> 2^3 * PAGE_SIZE to 2^2 * PAGE_SIZE + 1
+ *	4 -> 2^4 * PAGE_SIZE to 2^3 * PAGE_SIZE + 1
+ *	...
+ *
+ * The order returned is used to find the smallest allocation granule required
+ * to hold an object of the specified size.
+ *
+ * The result is undefined if the size is 0.
+ *
+ * This function may be used to initialise variables with compile time
+ * evaluations of constants.
  */
-static inline __attribute_const__
-int __get_order(unsigned long size)
+static inline __attribute_const__ int get_order(unsigned long size)
 {
 	int order;
 
@@ -35,33 +53,6 @@ int __get_order(unsigned long size)
 	return order;
 }
 
-/**
- * get_order - Determine the allocation order of a memory size
- * @size: The size for which to get the order
- *
- * Determine the allocation order of a particular sized block of memory.  This
- * is on a logarithmic scale, where:
- *
- *	0 -> 2^0 * PAGE_SIZE and below
- *	1 -> 2^1 * PAGE_SIZE to 2^0 * PAGE_SIZE + 1
- *	2 -> 2^2 * PAGE_SIZE to 2^1 * PAGE_SIZE + 1
- *	3 -> 2^3 * PAGE_SIZE to 2^2 * PAGE_SIZE + 1
- *	4 -> 2^4 * PAGE_SIZE to 2^3 * PAGE_SIZE + 1
- *	...
- *
- * The order returned is used to find the smallest allocation granule required
- * to hold an object of the specified size.
- *
- * The result is undefined if the size is 0.
- *
- * This function may be used to initialise variables with compile time
- * evaluations of constants.
- */
-#define get_order(n)						\
-(								\
-	__get_order(n)						\
-)
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_GENERIC_GETORDER_H */
_
