From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 19:06:25 -0400 (EDT)
Message-ID: <20120525.190625.1306293406531703607.davem@davemloft.net>
References: <alpine.LFD.2.02.1205251528570.26378@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:53733 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab2EYXG1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 19:06:27 -0400
In-Reply-To: <alpine.LFD.2.02.1205251528570.26378@i5.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 15:35:38 -0700 (PDT)

> So it's not truly generic, but it's in lib/strnlen_user.c and under the 
> CONFIG_GENERIC_STRNLEN_USER config option, because I'm convinced it should 
> be possible to do something that does the right thing for everybody. 

It should be relatively easy, especially since you work with aligned
words.

> What's the appropriate *clean* interface to allow architectures 
> to tweak the little details?

Maybe something like:

#define HAS_ZERO_CONST_DECLARE	...
#define HAS_ZERO_VAR_DECLARE	...
#define HAS_ZERO_ARGS		...

static inline unsigned long has_zero(unsigned long c ...)
{
}

#define FIND_ZERO_ARGS		...

static inline long find_zero(unsigned long c, unsigned long mask ...)
{
}

So at the use sites it's something like:

long do_strwhatever_user()
{
	HAS_ZERO_CONST_DECLARE;

	...

	while (max >= sizeof(unsigned long)) {
		unsigned long mask, c;
		HAS_ZERO_VAR_DECLARE;

		mask = has_zero(c HAS_ZERO_ARGS);
		if (mask)
			return res + find_zero(c, mask FIND_ZERO_ARGS);
	...
	}
	...
}

A little ugly.  The main problem is the magic args macros.

We can kill off the HAS_ZERO_CONST_DECLARE booger by instead
exposing the magic constants used by the particular has_zero()
implementation.  Then we'll have:

#define HAVE_ZERO_CONST1	REPEAT_BYTE(X)
#define HAVE_ZERO_CONST2	REPEAT_BYTE(X)

static inline unsigned long has_zero(unsigned long c,
				     const unsigned long magic1,
				     const unsigned long magic2);

and then it becomes something like:

long do_strwhatever_user()
{
	const unsigned long magic1 = HAVE_ZERO_CONST1;
	const unsigned long magic2 = HAVE_ZERO_CONST2;

	...

	while (max >= sizeof(unsigned long)) {
		unsigned long mask, c;
		HAS_ZERO_VAR_DECLARE;

		mask = has_zero(c, magic1, magic2);
		if (mask)
			return res + find_zero(c, mask, magic1, magic2);

The remaining problem, which I was trying to accomodate with the funky
ARGS macros, is propagating part of the has_zero() calculation into the
find_zero() call.

Hmmm...
