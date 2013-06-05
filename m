Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46606 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab3FEHTu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jun 2013 03:19:50 -0400
Date: Wed, 5 Jun 2013 09:19:15 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] arch/*/asm/include/bitops.h: api issue, find_*_bit()
 defination are different with each other
Message-ID: <20130605071915.GK23140@pengutronix.de>
References: <51AE8FEF.1020809@asianux.com>
 <51AE903C.6010806@asianux.com>
 <51AE909D.9080006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51AE909D.9080006@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20130605071915.ZS4wR8URNjL3T4I4vLQWb7xLszKsR-LzQ-KkhxlApDw@z>

Hello,

On Wed, Jun 05, 2013 at 09:13:01AM +0800, Chen Gang wrote:
> 
> For arm and m68k, they customize find_*_bit(), but the API is different
> with 'generic'.
> 
> avr32, s390, and unicore32 also customize find_*_bit(), but the API is
> the same with 'generic', and the left architectures all use 'generic'.
> 
> So need change arm and m68k related API to match the 'generic', then
> all another modules can face same public API for various architectures.
> 
> Also beautify code and comments to pass "./scripts/checkpatch.pl"
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/include/asm/bitops.h  |   26 ++++++++++++++++++--------
>  arch/arm/lib/findbit.S         |   14 ++++++++++----
>  arch/m68k/include/asm/bitops.h |   25 ++++++++++++++-----------
>  3 files changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index e691ec9..10566c8 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -161,18 +161,28 @@ extern int _test_and_change_bit(int nr, volatile unsigned long * p);
>  /*
>   * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
>   */
> -extern int _find_first_zero_bit_le(const void * p, unsigned size);
> -extern int _find_next_zero_bit_le(const void * p, int size, int offset);
> -extern int _find_first_bit_le(const unsigned long *p, unsigned size);
> -extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
> +extern unsigned long  _find_first_zero_bit_le(const void *p,
doesn't checkpatch critizise the double space in the line above?

> +						unsigned long size);
> +extern unsigned long _find_next_zero_bit_le(const void *p, unsigned long size,
> +						unsigned long offset);
> +extern unsigned long _find_first_bit_le(const unsigned long *p,
> +						unsigned long size);
> +extern unsigned long _find_next_bit_le(const unsigned long *p,
> +						unsigned long size,
> +						unsigned long offset);
>  
>  /*
>   * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
>   */
> -extern int _find_first_zero_bit_be(const void * p, unsigned size);
> -extern int _find_next_zero_bit_be(const void * p, int size, int offset);
> -extern int _find_first_bit_be(const unsigned long *p, unsigned size);
> -extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
> +extern unsigned long _find_first_zero_bit_be(const void *p,
> +						unsigned long size);
> +extern unsigned long _find_next_zero_bit_be(const void *p, unsigned long size,
> +						unsigned long offset);
> +extern unsigned long _find_first_bit_be(const unsigned long *p,
> +						unsigned long size);
> +extern unsigned long _find_next_bit_be(const unsigned long *p,
> +						unsigned long size,
> +						unsigned long offset);
>  
>  #ifndef CONFIG_SMP
>  /*
> diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
> index 64f6bc1..9e3263a 100644
> --- a/arch/arm/lib/findbit.S
> +++ b/arch/arm/lib/findbit.S
> @@ -19,7 +19,8 @@
>  
>  /*
>   * Purpose  : Find a 'zero' bit
> - * Prototype: int find_first_zero_bit(void *addr, unsigned int maxbit);
> + * Prototype: unsigned long  find_first_zero_bit(const void *p,
here is another one.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
