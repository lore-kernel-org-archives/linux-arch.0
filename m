From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC][PATCH 23/24] atomic: Collapse all atomic_{set,clear}_mask
 definitions
Date: Fri, 10 Jul 2015 09:13:58 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665AD392@IN01WEMBXB.internal.synopsys.com>
References: <20150709172855.564686637@infradead.org>
	<20150709175310.229218215@infradead.org>
 <CAMuHMdXePQF9BL7OfTz+=FN5Hg9C=E6hAO8MFQ9Eu_tiK_Q8OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:58090 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbbGJJOH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 05:14:07 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, =?iso-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@ezchip.com>, Ingo Molnar <mingo@kernel.org>

On Friday 10 July 2015 02:40 PM, Geert Uytterhoeven wrote:
> Hi Peter,
>
> On Thu, Jul 9, 2015 at 7:29 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > --- a/include/linux/atomic.h
>> > +++ b/include/linux/atomic.h
>> > @@ -28,6 +28,23 @@ static inline int atomic_add_unless(atom
>> >  #define atomic_inc_not_zero(v)         atomic_add_unless((v), 1, 0)
>> >  #endif
>> >
>> > +#ifndef atomic_nand
>> > +static inline void atomic_nand(int i, atomic_t *v)
>> > +{
>> > +       atomic_and(~i, v);
> That sounds like a misnomer...
>
> Your NAND is "A & ~B", while my[*] NAND is "~(A & B)"?
>
> [*] https://en.wikipedia.org/wiki/NAND_logic
>
> What about atomic_clear()? (Is atomic_bic() too ARM-centric?)
>

ARM + ARC centric :-)

We have the BIC instruction as well which does the same: A & ~B

-Vineet
