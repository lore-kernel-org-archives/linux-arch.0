From: "H. Peter Anvin" <hpa@zytor.com>
Subject: cmpxchg and x86 flags output
Date: Tue, 14 Jun 2016 16:53:00 -0700
Message-ID: <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:53218 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbcFNXxL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jun 2016 19:53:11 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

The x86 gcc now has the ability to return the value of flags output.  In
most use cases, this has been trivial to use in the kernel.

However, cmpxchg() presents a problem.  The current definition of
cmpxchg() and its variants is:

	out = cmpxchg(ptr, old, new);

... which is then frequently followed by:

	if (likely(old == out))

... or something along those lines.

This test is unnecessary and can now be elided, but this means changing
the signature on the cmpxchg() function (macro, generally).

It seems to me that the sanest way to handle this is to add a new
interface with a fourth parameter, so:

	changed = cmpxchgx(ptr, old, new, out);

A generic implementation of cmpxchgx() would be provided, looking like:

#define cmpxchgx(ptr, old, new, out) ({			\
	__typeof__((*(ptr))) __old = (old);		\
	__typeof__((*(ptr))) __new = (new);		\
	__typeof__((*(ptr))) __old = (old);		\
	__typeof__((*(ptr))) __out; 			\
	(out) = __out = cmpxchg(ptr, __old, __new);	\
	(__old != __out);				\
})

... and so on for all the many other variants.

However, I'm wondering how well this will fit in with other
architectures.  Keep in mind gcc will probably gain this ability for
other architectures with flags at some point, although that doesn't
inherently mean that cmpxchg will be able to make use of it.

This means a lot of changes even to common code, so I want to make sure
the interface is right before embarking on an implementation.

Thoughts?

	-hpa
