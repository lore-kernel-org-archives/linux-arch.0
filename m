From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 04/18] arm: implement nospec_ptr()
Date: Tue, 9 Jan 2018 18:04:49 -0800
Message-ID: <32f6f9de-1f8f-f459-d9e4-c9a7044cf8af@redhat.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520101463.32271.9320376934909324865.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34317 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933235AbeAJCEx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jan 2018 21:04:53 -0500
Received: by mail-qt0-f196.google.com with SMTP id 33so20304353qtv.1
        for <linux-arch@vger.kernel.org>; Tue, 09 Jan 2018 18:04:53 -0800 (PST)
In-Reply-To: <151520101463.32271.9320376934909324865.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com, Justin Forbes <jforbes@redhat.com>

On 01/05/2018 05:10 PM, Dan Williams wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> This patch implements nospec_ptr() for arm, following the recommended
> architectural sequences for the arm and thumb instruction sets.
> 

Fedora picked up the series and it fails on arm:

In file included from ./include/linux/compiler.h:242:0,
                  from ./include/uapi/linux/swab.h:6,
                  from ./include/linux/swab.h:5,
                  from ./arch/arm/include/asm/opcodes.h:89,
                  from ./arch/arm/include/asm/bug.h:7,
                  from ./include/linux/bug.h:5,
                  from ./include/linux/mmdebug.h:5,
                  from ./include/linux/gfp.h:5,
                  from ./include/linux/slab.h:15,
                  from kernel/fork.c:14:
./include/linux/fdtable.h: In function '__fcheck_files':
./arch/arm/include/asm/barrier.h:112:41: error: expected declaration specifiers or '...' before numeric constant
   __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
                                          ^
./arch/arm/include/asm/barrier.h:68:32: note: in definition of macro '__load_no_speculate_n'
    (typeof(*ptr)(unsigned long)(failval));  \
                                 ^~~~~~~
./arch/arm/include/asm/barrier.h:112:2: note: in expansion of macro '__load_no_speculate'
   __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
   ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/barrier.h:122:2: note: in expansion of macro 'nospec_ptr'
   nospec_ptr(__arr + __idx, __arr, __arr + __sz);   \
   ^~~~~~~~~~
./include/linux/fdtable.h:86:13: note: in expansion of macro 'nospec_array_ptr'
   if ((fdp = nospec_array_ptr(fdt->fd, fd, fdt->max_fds)))
              ^~~~~~~~~~~~~~~~
./arch/arm/include/asm/barrier.h:112:41: error: expected declaration specifiers or '...' before numeric constant
   __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
                                          ^
./arch/arm/include/asm/barrier.h:68:32: note: in definition of macro '__load_no_speculate_n'
    (typeof(*ptr)(unsigned long)(failval));  \
                                 ^~~~~~~
./arch/arm/include/asm/barrier.h:112:2: note: in expansion of macro '__load_no_speculate'
   __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
   ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/barrier.h:122:2: note: in expansion of macro 'nospec_ptr'
   nospec_ptr(__arr + __idx, __arr, __arr + __sz);   \
   ^~~~~~~~~~
./include/linux/fdtable.h:86:13: note: in expansion of macro 'nospec_array_ptr'
   if ((fdp = nospec_array_ptr(fdt->fd, fd, fdt->max_fds)))
              ^~~~~~~~~~~~~~~~
./arch/arm/include/asm/barrier.h:112:41: error: expected declaration specifiers or '...' before numeric constant
   __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
                                          ^
./arch/arm/include/asm/barrier.h:68:32: note: in definition of macro '__load_no_speculate_n'
    (typeof(*ptr)(unsigned long)(failval));  \
                                 ^~~~~~~
./arch/arm/include/asm/barrier.h:112:2: note: in expansion of macro '__load_no_speculate'
   __load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);  \
   ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/barrier.h:122:2: note: in expansion of macro 'nospec_ptr'
   nospec_ptr(__arr + __idx, __arr, __arr + __sz);   \
   ^~~~~~~~~~
./include/linux/fdtable.h:86:13: note: in expansion of macro 'nospec_array_ptr'
   if ((fdp = nospec_array_ptr(fdt->fd, fd, fdt->max_fds)))

I can't puzzle out what exactly is the problem here, except that it really
does not seem to like that failval. Does the arm compiler not like doing
the typeof with the __arr + __idx?

Thanks,
Laura

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   arch/arm/include/asm/barrier.h |   75 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
> index 40f5c410fd8c..6384c90e4b72 100644
> --- a/arch/arm/include/asm/barrier.h
> +++ b/arch/arm/include/asm/barrier.h
> @@ -37,6 +37,81 @@
>   #define dmb(x) __asm__ __volatile__ ("" : : : "memory")
>   #endif
>   
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define __load_no_speculate_n(ptr, lo, hi, failval, cmpptr, sz)	\
> +({								\
> +	typeof(*ptr) __nln_val;					\
> +	typeof(*ptr) __failval =				\
> +		(typeof(*ptr)(unsigned long)(failval));		\
> +								\
> +	asm volatile (						\
> +	"	cmp	%[c], %[l]\n"				\
> +	"	it	hs\n"					\
> +	"	cmphs	%[h], %[c]\n"				\
> +	"	blo	1f\n"					\
> +	"	ld" #sz " %[v], %[p]\n"				\
> +	"1:	it	lo\n"					\
> +	"	movlo	%[v], %[f]\n"				\
> +	"	.inst 0xf3af8014 @ CSDB\n"			\
> +	: [v] "=&r" (__nln_val)					\
> +	: [p] "m" (*(ptr)), [l] "r" (lo), [h] "r" (hi),		\
> +	  [f] "r" (__failval), [c] "r" (cmpptr)			\
> +	: "cc");						\
> +								\
> +	__nln_val;						\
> +})
> +#else
> +#define __load_no_speculate_n(ptr, lo, hi, failval, cmpptr, sz)	\
> +({								\
> +	typeof(*ptr) __nln_val;					\
> +	typeof(*ptr) __failval =				\
> +		(typeof(*ptr)(unsigned long)(failval));		\
> +								\
> +	asm volatile (						\
> +	"	cmp	%[c], %[l]\n"				\
> +	"	cmphs	%[h], %[c]\n"				\
> +	"	ldr" #sz "hi %[v], %[p]\n"			\
> +	"	movls	%[v], %[f]\n"				\
> +	"	.inst 0xe320f014 @ CSDB\n"			\
> +	: [v] "=&r" (__nln_val)					\
> +	: [p] "m" (*(ptr)), [l] "r" (lo), [h] "r" (hi),		\
> +	  [f] "r" (__failval), [c] "r" (cmpptr)			\
> +	: "cc");						\
> +								\
> +	__nln_val;						\
> +})
> +#endif
> +
> +#define __load_no_speculate(ptr, lo, hi, failval, cmpptr)		\
> +({									\
> +	typeof(*(ptr)) __nl_val;					\
> +									\
> +	switch (sizeof(__nl_val)) {					\
> +	case 1:								\
> +		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
> +						 cmpptr, b);		\
> +		break;							\
> +	case 2:								\
> +		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
> +						 cmpptr, h);		\
> +		break;							\
> +	case 4:								\
> +		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
> +						 cmpptr, );		\
> +		break;							\
> +	default:							\
> +		BUILD_BUG();						\
> +	}								\
> +									\
> +	__nl_val;							\
> +})
> +
> +#define nospec_ptr(ptr, lo, hi)						\
> +({									\
> +	typeof(ptr) __np_ptr = (ptr);					\
> +	__load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);		\
> +})
> +
>   #ifdef CONFIG_ARM_HEAVY_MB
>   extern void (*soc_mb)(void);
>   extern void arm_heavy_mb(void);
> 
