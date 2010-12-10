From: "J. R. Okajima" <hooanon05@yahoo.co.jp>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Fri, 10 Dec 2010 23:23:17 +0900
Message-ID: <19324.1291990997@jrobl>
References: <20101209070938.GA3949@amd>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mfbichi11.ns.itscom.net ([219.110.2.189]:64296 "EHLO
	mfbichi11.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab0LJPBc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Dec 2010 10:01:32 -0500
In-Reply-To: <20101209070938.GA3949@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org


Nick Piggin:
> The standard memcmp function on a Westmere system shows up hot in
> profiles in the `git diff` workload (both parallel and single threaded),
> and it is likely due to the costs associated with trapping into
> microcode, and little opportunity to improve memory access (dentry
> name is not likely to take up more than a cacheline).

Let me make sure.
What you are pointing out is
- asm("repe; cmpsb") may grab CPU long time, and can be a hazard for
  scaling.
- by breaking it into pieces, the chances to scale will increase.
Right?

Anyway this appraoch replacing smallest code by larger but faster code
is interesting.
How about mixing 'unsigned char *' and 'unsigned long *' in referencing
the given strings?
For example,

int f(const unsigned char *cs, const unsigned char *ct, size_t count)
{
	int ret;
	union {
		const unsigned long *l;
		const unsigned char *c;
	} s, t;

/* this macro is your dentry_memcmp() actually */
#define cmp(s, t, c, step)		      \
	do {				      \
		while ((c) >= (step)) {	      \
			ret = (*(s) != *(t)); \
			if (ret)	      \
				return ret;   \
			(s)++;		      \
			(t)++;		      \
			(c) -= (step);	      \
		}			      \
	} while (0)

	s.c = cs;
	t.c = ct;
	cmp(s.l, t.l, count, sizeof(*s.l));
	cmp(s.c, t.c, count, sizeof(*s.c));
	return 0;
}

What I am thinking here is,
- in load and compare, there is no difference between 'char*' and
  'long*', probably.
- obviously 'step by sizeof(long)' will reduce the number of repeats.
- but I am not sure whether the length of string is generally longer
  than 4 (or 8) or not.


J. R. Okajima
