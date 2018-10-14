From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize
 for_each_set_clump macro
Date: Sun, 14 Oct 2018 13:19:33 +0900
Message-ID: <20181014041933.GA7335@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
 <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 02, 2018 at 09:00:45AM +0200, Rasmus Villemoes wrote:
> On 2018-10-02 03:14, William Breathitt Gray wrote:
> >  	/* clear bits array to a clean slate */
> >  	bitmap_zero(bits, chip->ngpio);
> >  
> > -	/* get bits are evaluated a gpio port register at a time */
> > -	for (i = 0; i < ARRAY_SIZE(ports); i++) {
> > -		/* gpio offset in bits array */
> > -		bits_offset = i * gpio_reg_size;
> > -
> > -		/* word index for bits array */
> > -		word_index = BIT_WORD(bits_offset);
> > -
> > -		/* gpio offset within current word of bits array */
> > -		word_offset = bits_offset % BITS_PER_LONG;
> > -
> > -		/* mask of get bits for current gpio within current word */
> > -		word_mask = mask[word_index] & (port_mask << word_offset);
> > -		if (!word_mask) {
> > -			/* no get bits in this port so skip to next one */
> > -			continue;
> > -		}
> > -
> > -		/* read bits from current gpio port */
> > +	for_each_set_clump(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
> >  		port_state = inb(dio48egpio->base + ports[i]);
> > -
> > -		/* store acquired bits at respective bits array offset */
> > -		bits[word_index] |= port_state << word_offset;
> > +		bits[word] |= port_state << offset;
> 
> Somewhat unrelated to this series, but is the existing code correct? I'd
> expect the RHS to be masked by word_mask; otherwise we might set bits in
> bits[] that were not requested? And if one does that, the !word_mask
> test is merely an optimization to avoid reading the gpios when the
> result would be ignored anyway. Perhaps no caller cares.
> 
> Rasmus

I don't think the caller cares in this case. Take a look at the
gpiod_get_array_value_complex function: the desired inputs are collected
before gpio_chip_get_multiple is called and then looped through after --
unrequested bits are simply ignored.

This caller behavior also makes sense because a bit value of 0 in the
bits array does not necessarily mean the input was not requested, but
may instead mean that the value at the input is 0; therefore, the caller
must keep track of the requested inputs rather than try to deduce them
from the values in the bits array.

William Breathitt Gray
