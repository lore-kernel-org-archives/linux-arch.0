From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC][PATCH 23/24] atomic: Collapse all atomic_{set,clear}_mask definitions
Date: Fri, 10 Jul 2015 11:10:33 +0200
Message-ID: <CAMuHMdXePQF9BL7OfTz+=FN5Hg9C=E6hAO8MFQ9Eu_tiK_Q8OA@mail.gmail.com>
References: <20150709172855.564686637@infradead.org>
	<20150709175310.229218215@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34736 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbbGJJKe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 05:10:34 -0400
In-Reply-To: <20150709175310.229218215@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@ezchip.com>, Ingo Molnar <mingo@kernel.org>

Hi Peter,

On Thu, Jul 9, 2015 at 7:29 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -28,6 +28,23 @@ static inline int atomic_add_unless(atom
>  #define atomic_inc_not_zero(v)         atomic_add_unless((v), 1, 0)
>  #endif
>
> +#ifndef atomic_nand
> +static inline void atomic_nand(int i, atomic_t *v)
> +{
> +       atomic_and(~i, v);

That sounds like a misnomer...

Your NAND is "A & ~B", while my[*] NAND is "~(A & B)"?

[*] https://en.wikipedia.org/wiki/NAND_logic

What about atomic_clear()? (Is atomic_bic() too ARM-centric?)

> +}
> +#endif
> +
> +static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
> +{
> +       atomic_nand(mask, v);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
