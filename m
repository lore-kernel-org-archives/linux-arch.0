From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 19/24] C6X: headers
Date: Wed, 28 Sep 2011 16:07:11 +0200
Message-ID: <201109281607.11228.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-20-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317155405-26235-20-git-send-email-msalter@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:

> +
> +static inline void __delay(unsigned long loops)
> +{
> +	uint32_t tmp;
> +
> +	/* 6 cycles per loop */
> +	asm volatile ("        mv    .s1  %0,%1\n"
> +		      "0: [%1] b     .s1  0b\n"
> +		      "        add   .l1  -6,%0,%0\n"
> +		      "        cmplt .l1  1,%0,%1\n"
> +		      "        nop   3\n"
> +		      : "+a"(loops), "=A"(tmp));
> +}
> +
> +static inline void _c6x_tickdelay(unsigned int x)
> +{
> +	uint32_t cnt, endcnt;
> +
> +	asm volatile ("        mvc   .s2   TSCL,%0\n"
> +		      "        add   .s2x  %0,%1,%2\n"
> +		      " ||     mvk   .l2   1,B0\n"
> +		      "0: [B0] b     .s2   0b\n"
> +		      "        mvc   .s2   TSCL,%0\n"
> +		      "        sub   .s2   %0,%2,%0\n"
> +		      "        cmpgt .l2   0,%0,B0\n"
> +		      "        nop   2\n"
> +		      : "=b"(cnt), "+a"(x), "=b"(endcnt) : : "B0");
> +}

Do you actually need to provide the __delay function here?
I think it's really only used by the calibrate_delay() function
that you don't need.

> diff --git a/arch/c6x/include/asm/unaligned.h b/arch/c6x/include/asm/unaligned.h
> new file mode 100644
> index 0000000..1dcb006
> --- /dev/null
> +++ b/arch/c6x/include/asm/unaligned.h
> @@ -0,0 +1,288 @@
> +/*
> + *  Port on Texas Instruments TMS320C6x architecture

This file basically just optimizes unaligned endianess conversion, but
you don't provide an optimized swab.h, which is the regular endianess
conversion.

I think it would less code and more useful to provide your own swab.h
and use the generic unaligned.h.

	Arnd
