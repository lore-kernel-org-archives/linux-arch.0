From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Thu, 15 Dec 2011 23:43:44 +0100
Message-ID: <5476903.m0O6cTqH9B@wuerfel>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <4EEA66A3.4010205@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52228 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675Ab1LOWoM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Dec 2011 17:44:12 -0500
In-Reply-To: <4EEA66A3.4010205@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On Thursday 15 December 2011 13:29:07 H. Peter Anvin wrote:
> On 12/13/2011 06:56 AM, David Howells wrote:
> >  
> > +#if BITS_PER_LONG == 32
> >  #include <asm-generic/bitops/fls64.h>
> > +#endif
> >  
> 
> This is outside __KERNEL__, and thus ends up changing what is exported
> to userspace (specifically, fls64.h won't be included for 64-bit
> non-__KERNEL__ anymore.)  Is this a bug?

Not sure, but I think it's a bug to use BITS_PER_LONG rather than
__BITS_PER_LONG outside of __KERNEL__.

	Arnd
