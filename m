From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize
 for_each_set_clump macro
Date: Tue, 2 Oct 2018 09:00:45 +0200
Message-ID: <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>, linus.walleij@linaro.org, akpm@linux-foundation.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On 2018-10-02 03:14, William Breathitt Gray wrote:
>  	/* clear bits array to a clean slate */
>  	bitmap_zero(bits, chip->ngpio);
>  
> -	/* get bits are evaluated a gpio port register at a time */
> -	for (i = 0; i < ARRAY_SIZE(ports); i++) {
> -		/* gpio offset in bits array */
> -		bits_offset = i * gpio_reg_size;
> -
> -		/* word index for bits array */
> -		word_index = BIT_WORD(bits_offset);
> -
> -		/* gpio offset within current word of bits array */
> -		word_offset = bits_offset % BITS_PER_LONG;
> -
> -		/* mask of get bits for current gpio within current word */
> -		word_mask = mask[word_index] & (port_mask << word_offset);
> -		if (!word_mask) {
> -			/* no get bits in this port so skip to next one */
> -			continue;
> -		}
> -
> -		/* read bits from current gpio port */
> +	for_each_set_clump(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
>  		port_state = inb(dio48egpio->base + ports[i]);
> -
> -		/* store acquired bits at respective bits array offset */
> -		bits[word_index] |= port_state << word_offset;
> +		bits[word] |= port_state << offset;

Somewhat unrelated to this series, but is the existing code correct? I'd
expect the RHS to be masked by word_mask; otherwise we might set bits in
bits[] that were not requested? And if one does that, the !word_mask
test is merely an optimization to avoid reading the gpios when the
result would be ignored anyway. Perhaps no caller cares.

Rasmus
