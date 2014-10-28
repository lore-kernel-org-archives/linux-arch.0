Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50993 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbaJ1Nah (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Oct 2014 09:30:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 07/29] nios2: I/O Mapping
Date: Tue, 28 Oct 2014 14:30:25 +0100
Message-ID: <3089586.phhm8NvmXk@wuerfel>
In-Reply-To: <1414139071-3818-8-git-send-email-lftan@altera.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com> <1414139071-3818-8-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20141028133025.MAE090tsbJVRB2plMehh7y-0W5IefWVxzbJ1SmxC9Gk@z>

On Friday 24 October 2014 16:24:09 Ley Foon Tan wrote:

> +/* PCI is not supported in nios2, set this to 0. */
> +#define IO_SPACE_LIMIT 0
> +
> +extern void outsb(unsigned long addr, const void *buf, int len);
> +extern void outsw(unsigned long addr, const void *buf, int len);
> +extern void outsl(unsigned long addr, const void *buf, int len);
> +extern void insb(unsigned long addr, void *buf, int len);
> +extern void insw(unsigned long addr, void *buf, int len);
> +extern void insl(unsigned long addr, void *buf, int len);
> +#define outsb outsb
> +#define outsw outsw
> +#define outsl outsl
> +#define insb insb
> +#define insw insw
> +#define insl insl

You don't have inb/outb, so you shouldn't have these either.

> +/*
> + * PCI is not enabled in nios2. Provide dummy implementation to get 'allyesconfig'
> + * to build successfully.
> + */
> +#define inb(addr)	({ 0; })
> +#define inw(addr)	({ 0; })
> +#define inl(addr)	({ 0; })
> +#define outb(x, addr)	do { } while (0)
> +#define outw(x, addr)	do { } while (0)
> +#define outl(x, addr)	do { } while (0)

What fails if you take these out?

> +
> +/* Use "Duff's Device" to unroll the loops. */
> +#define __IO_OUT_LOOP(a, b, l)				\
> +	do {						\
> +		if (l > 0) {				\
> +			int _n = (l + 7) / 8;		\
> +			switch (l % 8) {		\
> +			case 0:				\
> +				do {			\
> +					*a = *b++;	\
> +			case 7:				\
> +					*a = *b++;	\
> +			case 6:				\
> +					*a = *b++;	\
> +			case 5:				\
> +					*a = *b++;	\
> +			case 4:				\
> +					*a = *b++;	\
> +			case 3:				\
> +					*a = *b++;	\
> +			case 2:				\
> +					*a = *b++;	\
> +			case 1:				\
> +					*a = *b++;	\
> +				} while (--_n > 0);	\
> +			}				\
> +		}					\
> +	} while (0)
> +
> +#define __IO_IN_LOOP(a, b, l)				\
> +	do {						\
> +		if (l > 0) {				\
> +			int _n = (l + 7) / 8;		\
> +			switch (l % 8) {		\
> +			case 0:				\
> +				do {			\
> +					*b++ = *a;	\
> +			case 7:				\
> +					*b++ = *a;	\
> +			case 6:				\
> +					*b++ = *a;	\
> +			case 5:				\
> +					*b++ = *a;	\
> +			case 4:				\
> +					*b++ = *a;	\
> +			case 3:				\
> +					*b++ = *a;	\
> +			case 2:				\
> +					*b++ = *a;	\
> +			case 1:				\
> +					*b++ = *a;	\
> +				} while (--_n > 0);	\
> +			}				\
> +		}					\
> +	} while (0)
> +
> +#else /* __IO_USE_DUFFS */
> +
> +/* Use simple loops. */
> +#define __IO_OUT_LOOP(a, b, l)				\
> +	do {						\
> +		while (l--)				\
> +			*a = *b++;			\
> +	} while (0)
> +
> +#define __IO_IN_LOOP(a, b, l)				\
> +	do {						\
> +		while (l--)				\
> +			*b++ = *a;			\
> +	} while (0)
> +
> +#endif /* __IO_USE_DUFFS */
> +
> +void outsb(unsigned long addr, const void *buf, int len)
> +{
> +	volatile unsigned char *ap = (volatile unsigned char *)addr;
> +	unsigned char *bp = (unsigned char *)buf;
> +	__IO_OUT_LOOP(ap, bp, len);
> +}
> +EXPORT_SYMBOL(outsb);
> +
> +void outsw(unsigned long addr, const void *buf, int len)
> +{
> +	volatile unsigned short *ap = (volatile unsigned short *)addr;
> +	unsigned short *bp = (unsigned short *)buf;
> +	__IO_OUT_LOOP(ap, bp, len);
> +}
> +EXPORT_SYMBOL(outsw);

This implementation makes no sense, so definitely remove them.


	Arnd

