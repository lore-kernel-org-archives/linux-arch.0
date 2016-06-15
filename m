From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: cmpxchg and x86 flags output
Date: Wed, 15 Jun 2016 10:50:02 +0200
Message-ID: <20160615085002.GC30935@twins.programming.kicks-ass.net>
References: <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50525 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbcFOIuJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2016 04:50:09 -0400
Content-Disposition: inline
In-Reply-To: <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, David Howells <dhowells@redhat.com>

On Tue, Jun 14, 2016 at 04:53:00PM -0700, H. Peter Anvin wrote:
> The x86 gcc now has the ability to return the value of flags output.  In
> most use cases, this has been trivial to use in the kernel.
> 
> However, cmpxchg() presents a problem.  The current definition of
> cmpxchg() and its variants is:
> 
> 	out = cmpxchg(ptr, old, new);
> 
> ... which is then frequently followed by:
> 
> 	if (likely(old == out))
> 
> ... or something along those lines.
> 
> This test is unnecessary and can now be elided, but this means changing
> the signature on the cmpxchg() function (macro, generally).
> 
> It seems to me that the sanest way to handle this is to add a new
> interface with a fourth parameter, so:
> 
> 	changed = cmpxchgx(ptr, old, new, out);

See also:

  lkml.kernel.org/r/146358429016.8596.3381723959064491676.stgit@warthog.procyon.org.uk

where David suggests the same.

> 
> A generic implementation of cmpxchgx() would be provided, looking like:
> 
> #define cmpxchgx(ptr, old, new, out) ({			\
> 	__typeof__((*(ptr))) __old = (old);		\
> 	__typeof__((*(ptr))) __new = (new);		\
> 	__typeof__((*(ptr))) __old = (old);		\
> 	__typeof__((*(ptr))) __out; 			\
> 	(out) = __out = cmpxchg(ptr, __old, __new);	\
> 	(__old != __out);				\
> })
> 
> ... and so on for all the many other variants.
> 
> However, I'm wondering how well this will fit in with other
> architectures.

All ll/sc based archs also already know if the operation succeeded
without having to do the extra comparison.

SPARCv9,S390x which are native CAS architectures, also places the
success of the operation in condition codes.

IA64 might be the odd duck out (or I'm not reading the manual right,
which is entirely possible).

> Keep in mind gcc will probably gain this ability for
> other architectures with flags at some point, although that doesn't
> inherently mean that cmpxchg will be able to make use of it.
> 
> This means a lot of changes even to common code, so I want to make sure
> the interface is right before embarking on an implementation.
> 
> Thoughts?

David has already done lots of the conversions for you.
