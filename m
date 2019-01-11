From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v6 1/8] bitops: Introduce the for_each_set_clump8 macro
Date: Fri, 11 Jan 2019 10:00:46 +0100
Message-ID: <81f3038e-301b-7c0d-a6ef-90b9dadcab51@rasmusvillemoes.dk>
References: <cover.1545198260.git.vilhelm.gray@gmail.com>
 <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>, linus.walleij@linaro.org
Cc: akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On 19/12/2018 07.00, William Breathitt Gray wrote:
> +/**
> + * bitmap_set_value8 - set an 8-bit value within a memory region
> + * @bitmap: address to the bitmap memory region
> + * @value: the 8-bit value
> + * @start: bit offset of the 8-bit value
> + */
> +void bitmap_set_value8(unsigned long *const bitmap,
> +		       const unsigned long *const value,
> +		       const unsigned int start)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned int offset = start % BITS_PER_LONG;
> +	const unsigned long mask = GENMASK(7, offset);
> +
> +	bitmap[index] &= ~mask;
> +	bitmap[index] |= (*value << offset) & mask;
> +}

errh, why pass the value by reference? That seems rather odd. Also, if
anybody passes a value that doesn't fit in 8 bits, they get what they
deserve; IOW I don't see a reason for the masking in the last line, but
if its convenient for the users, keep it. In any case, please change the
type of value.

Rasmus
