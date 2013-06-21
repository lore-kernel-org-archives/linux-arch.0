From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drivers/block/xsysace - replace in(out)_8/in(out)_be16/in(out)_le16 with generic iowrite(read)8/16(be)
Date: Fri, 21 Jun 2013 16:23:05 +0200
Message-ID: <201306211623.06016.arnd@arndb.de>
References: <1371823336-19678-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54094 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161356Ab3FUOX0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2013 10:23:26 -0400
In-Reply-To: <1371823336-19678-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Friday 21 June 2013, Alexey Brodkin wrote:
> in(out)_8/in(out)_be16/in(out)_le16 are very powerpc/microblaze
> specific. To enable use of Xilinx System ACE driver build for other
> architectures (for example it's possible to use it on Xilinx ml-509
> board with ARC700 CPU in FPGA) we need to use generic implementation of
> accessors.
> 
> I posted this patch in January this year in general mailing list
> (linux-kernel@vger.kernel.org) and it got discussed. But with no
> conclusions/actions.
> 
> Now I'm sending it to arch list trying to resolve an issue above
> (dependency on another architecture - I'd like this driver to be
> arch-independent).
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> 
>  static void ace_datain_8(struct ace_device *ace)
> @@ -248,7 +248,7 @@ static void ace_datain_8(struct ace_device *ace)
>  	u8 *dst = ace->data_ptr;
>  	int i = ACE_FIFO_SIZE;
>  	while (i--)
> -		*dst++ = in_8(r++);
> +		*dst++ = ioread8(r++);
>  	ace->data_ptr = dst;
>  }

Why not just use ioread8_rep() to replace the loop?

> @@ -258,7 +258,7 @@ static void ace_dataout_8(struct ace_device *ace)
>  	u8 *src = ace->data_ptr;
>  	int i = ACE_FIFO_SIZE;
>  	while (i--)
> -		out_8(r++, *src++);
> +		iowrite8(*src++, r++);
>  	ace->data_ptr = src;
>  }

and iowrite_8

> @@ -285,7 +285,7 @@ static void ace_datain_be16(struct ace_device *ace)
>  	int i = ACE_FIFO_SIZE / 2;
>  	u16 *dst = ace->data_ptr;
>  	while (i--)
> -		*dst++ = in_le16(ace->baseaddr + 0x40);
> +		*dst++ = ioread16(ace->baseaddr + 0x40);
>  	ace->data_ptr = dst;
>  }
> @@ -294,19 +294,19 @@ static void ace_dataout_be16(struct ace_device *ace)
>  	int i = ACE_FIFO_SIZE / 2;
>  	u16 *src = ace->data_ptr;
>  	while (i--)
> -		out_le16(ace->baseaddr + 0x40, *src++);
> +		iowrite16(*src++, ace->baseaddr + 0x40);
>  	ace->data_ptr = src;
>  }

ioread16_rep/iowrite16_rep

>  static void ace_datain_le16(struct ace_device *ace)
> @@ -314,7 +314,7 @@ static void ace_datain_le16(struct ace_device *ace)
>  	int i = ACE_FIFO_SIZE / 2;
>  	u16 *dst = ace->data_ptr;
>  	while (i--)
> -		*dst++ = in_be16(ace->baseaddr + 0x40);
> +		*dst++ = ioread16be(ace->baseaddr + 0x40);
>  	ace->data_ptr = dst;
>  }
>  
> @@ -323,7 +323,7 @@ static void ace_dataout_le16(struct ace_device *ace)
>  	int i = ACE_FIFO_SIZE / 2;
>  	u16 *src = ace->data_ptr;
>  	while (i--)
> -		out_be16(ace->baseaddr + 0x40, *src++);
> +		iowrite16be(*src++, ace->baseaddr + 0x40);
>  	ace->data_ptr = src;
>  }

ioread16_rep/iowrite16_rep.

I guess the last two modifications are actually needed for correct
operation independent of CPU endianess. I don't what led to the
combination of big- and little-endian accessors, but my guess is
that it was trial-and-error together with cut-and-paste. The point
is that the single register access should match the endianess of
the device while the streaming access should match the endianess
of the CPU.

	Arnd
