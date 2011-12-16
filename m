From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Fri, 16 Dec 2011 13:57:14 +0000
Message-ID: <201112161357.14463.arnd@arndb.de>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <5476903.m0O6cTqH9B@wuerfel> <4EEA89B6.7030204@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49241 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1LPN5m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2011 08:57:42 -0500
In-Reply-To: <4EEA89B6.7030204@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On Thursday 15 December 2011, H. Peter Anvin wrote:
> On 12/15/2011 02:43 PM, Arnd Bergmann wrote:
> > On Thursday 15 December 2011 13:29:07 H. Peter Anvin wrote:
> >> On 12/13/2011 06:56 AM, David Howells wrote:
> >>>  
> >>> +#if BITS_PER_LONG == 32
> >>>  #include <asm-generic/bitops/fls64.h>
> >>> +#endif
> >>>  
> >>
> >> This is outside __KERNEL__, and thus ends up changing what is exported
> >> to userspace (specifically, fls64.h won't be included for 64-bit
> >> non-__KERNEL__ anymore.)  Is this a bug?
> > 
> > Not sure, but I think it's a bug to use BITS_PER_LONG rather than
> > __BITS_PER_LONG outside of __KERNEL__.
> > 
> 
> Yes, it's one of many issues with this stuff.  After tracking down
> things a bit further it looks like this was simply a conversion error in
> checkin:
> 
> d57594c203b1 bitops: use __fls for fls64 on 64-bit archs

Hmm, I also looked a bit closer and noticed that we don't actually
export any bitops headers to user space, so any use of __KERNEL__ in
those headers is bogus, but I don't think there is an actual bug here.

	Arnd
