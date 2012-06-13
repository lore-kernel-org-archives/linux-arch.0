From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 13 Jun 2012 23:08:20 +1200
Message-ID: <4FD874A4.8060606@orcon.net.nz>
References: <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com> <20120523.132109.1153947222019508621.davem@davemloft.net> <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com> <20120523.141647.2252460119413470634.davem@davemloft.net> <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com> <32064.1337852416@redhat.com> <CA+55aFzwZ3mCeALQx7fXX_HO4GZF03q4gtZOFGmdWkJrvwjrJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from nctlincom01.orcon.net.nz ([60.234.4.74]:57868 "EHLO
	nctlincom01.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2FMLXQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2012 07:23:16 -0400
Received: from mx7.orcon.net.nz (mx7.orcon.net.nz [219.88.242.57])
	by nctlincom01.orcon.net.nz (8.14.3/8.14.3/Debian-9.4) with ESMTP id q5DBBTtL018997
	for <linux-arch@vger.kernel.org>; Wed, 13 Jun 2012 23:11:29 +1200
Received: from Debian-exim by mx7.orcon.net.nz with local (Exim 4.69)
	(envelope-from <mcree@orcon.net.nz>)
	id 1SelR0-0001Ct-Ad
	for linux-arch@vger.kernel.org; Wed, 13 Jun 2012 23:08:22 +1200
In-Reply-To: <CA+55aFzwZ3mCeALQx7fXX_HO4GZF03q4gtZOFGmdWkJrvwjrJg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, David Miller <davem@davemloft.net>, James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On 25/05/12 03:53, Linus Torvalds wrote:
> First off, the *last* thing you want to do is go to big-endian mode.
> All the bit counting gets *much* more complicated, and your argument
> that it's "free" on some architectures is pointless, since it is only
> free on the architectures that have the *least* users.

On Alpha we can find the zero bytes extrememly efficiently, and, yeah,
we have rather few users, so carry bugger-all weight.  Nevertheless I
want to ask about the semantics of the new prep_zero_mask() function
because if we have to implement it exactly as specified in the message
to commit 36126f8f2ed8 then we are forced to take a round-about, thus
less efficient, route in the find_zero() implementation on Alpha.

From commit 36126f8f2ed8 prep_zero_mask() must, and I quote, "generate
an *exact* mask of which byte had the first zero."  But the result of
prep_zero_mask() in all current extant usage is passed _only_ to
create_zero_mask().  It seems to me then that current usage is only
constrained by the following:

1) The result of prep_zero_mask() must be bitwise "OR"-able and the
result of the ORed results must in turn be a valid mask of zero bytes.

2) The result is only ever passed to create_zero_mask() which, like
prep_zero_mask(), is architecture specific.

But there is nothing currently in the kernel that currently requires
(other than a commit message) the result of prep_zero_mask() to be an
*exact* mask of the zero bytes, only that it be *a* mask of zero bytes.
 The difference is important to Alpha because if we can have a mask
where the lowest eight bits represent each byte (rather than a 64-bit
mask where a whole eight bits are set to represent a byte) we get an
extremely efficient implementation.

So, may I generalise prep_zero_mask() as suggested above?

I follow with the Alpha code for word-at-a-time.h that results if I may
(and is running fine on my Alpha):


/*
 * We do not use the word_at_a_time struct on Alpha, but it needs to be
 * implemented to humour the generic code.
 */
struct word_at_a_time {
        const unsigned long unused;
};

#define WORD_AT_A_TIME_CONSTANTS { 0 }

/* Return nonzero if val has a zero */
static inline unsigned long has_zero(unsigned long val, unsigned long
*bits, const struct word_at_a_time *c)
{
        unsigned long zero_locations = __kernel_cmpbge(0, val);
        *bits = zero_locations;
        return zero_locations;
}

static inline unsigned long prep_zero_mask(unsigned long val, unsigned
long bits, const struct word_at_a_time *c)
{
        return bits;
}

#define create_zero_mask(bits) (bits)

static inline unsigned long find_zero(unsigned long bits)
{
        return bits & (unsigned long)(-(long)bits);
}

Cheers
Michael.
