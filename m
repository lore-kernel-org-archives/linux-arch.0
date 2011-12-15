From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Thu, 15 Dec 2011 23:01:16 +0000
Message-ID: <15267.1323990076@redhat.com>
References: <4EEA66A3.4010205@zytor.com> <20111213145654.14362.39868.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759655Ab1LOXBc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Dec 2011 18:01:32 -0500
In-Reply-To: <4EEA66A3.4010205@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org, heukelum@mailshack.com

H. Peter Anvin <hpa@zytor.com> wrote:

> > +#if BITS_PER_LONG == 32
> >  #include <asm-generic/bitops/fls64.h>
> > +#endif
> >  
> 
> This is outside __KERNEL__, and thus ends up changing what is exported
> to userspace (specifically, fls64.h won't be included for 64-bit
> non-__KERNEL__ anymore.)  Is this a bug?

It moved in the following commit:

	commit d57594c203b1e7b54373080a797f0cbfa4aade68
	Author: Alexander van Heukelum <heukelum@mailshack.com>
	Date:   Sat Mar 15 18:32:36 2008 +0100

	    bitops: use __fls for fls64 on 64-bit archs

	    Use __fls for fls64 on 64-bit archs. The implementation for
	    64-bit archs is moved from x86_64 to asm-generic.

	    Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
	    Signed-off-by: Ingo Molnar <mingo@elte.hu>

So I think it's a bug.

David
