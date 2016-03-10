From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Thu, 10 Mar 2016 05:05:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37862 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbcCJFFt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2016 00:05:49 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Noam Camus <noamc@ezchip.com>

+CC Noam

On Wednesday 09 March 2016 10:51 PM, Lada Trimasova wrote:
> Memory access primitives should use cpu_to_le16, cpu_to_le32, le16_to_cpu
> and le32_to_cpu because it is not really guaranteed that drivers handles
> any ordering themselves.

That is the driver issue. readxx as API simply returns data in native endianness.
We've had EZChip running big endian and so far and they didn't need this change.

> For example, serial port driver doesn't work when kernel is build for
> arc big endian architecture.

Last I tested Big Endian on SDP with 8250 part + 8250 driver it was working fine.
I presume this is the systemC model for device and standard 8250 driver and very
likely the model is not fixed endian or something.

Alexey knows about this stuff - this was discussed on lkml back in 2013 when he
was fighting the Xilinx systemAce driver endian issues

> Signed-off-by: Lada Trimasova <ltrimas@synopsys.com>

Sorry NACK on this ! If you still think we need it I need more data / details on
what exactly is failing in 8250 and how !

-Vineet

> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/include/asm/io.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
> index 694ece8..0b3d5ea 100644
> --- a/arch/arc/include/asm/io.h
> +++ b/arch/arc/include/asm/io.h
> @@ -129,15 +129,17 @@ static inline void __raw_writel(u32 w, volatile void __iomem *addr)
>  #define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })
>  
>  /*
> - * Relaxed API for drivers which can handle any ordering themselves
> + * This are defined to perform little endian accesses
>   */
>  #define readb_relaxed(c)	__raw_readb(c)
> -#define readw_relaxed(c)	__raw_readw(c)
> -#define readl_relaxed(c)	__raw_readl(c)
> +#define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
> +					__raw_readw(c)); __r; })
> +#define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
> +					__raw_readl(c)); __r; })
>  
>  #define writeb_relaxed(v,c)	__raw_writeb(v,c)
> -#define writew_relaxed(v,c)	__raw_writew(v,c)
> -#define writel_relaxed(v,c)	__raw_writel(v,c)
> +#define writew_relaxed(v,c)	__raw_writew((__force u16) cpu_to_le16(v),c)
> +#define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)
>  
>  #include <asm-generic/io.h>
>  
