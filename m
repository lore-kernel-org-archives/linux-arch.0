Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:17106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751104AbWCIRjZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2006 12:39:25 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603090814530.18022@g5.osdl.org> 
References: <Pine.LNX.4.64.0603090814530.18022@g5.osdl.org>  <1141855305.10606.6.camel@localhost.localdomain> <20060308161829.GC3669@elf.ucw.cz> <31492.1141753245@warthog.cambridge.redhat.com> <24309.1141848971@warthog.cambridge.redhat.com> <24280.1141904462@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH] Document Linux's memory barriers 
Date: Thu, 09 Mar 2006 17:39:05 +0000
Message-ID: <12101.1141925945@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds <torvalds@osdl.org> wrote:

> Basically, as long as nobody else is reading the lock, the lock will stay 
> in the caches.

I think for the purposes of talking about memory barriers, we consider the
cache to be part of the memory since the cache coherency mechanisms will give
the same effect.

I suppose the way the cache can be viewed as working is that bits of memory
are shuttled around between the CPUs, RAM and any other devices that partake
of the coherency mechanism.

> All modern CPU's do atomic operations entirely within the cache coherency 
> logic.

I know that, and I think it's irrelevant to specifying memory barriers.

> I think x86 still support the notion of a "locked cycle" on the 
> bus,

I wonder if that's what XCHG and XADD do... There's no particular reason they
should be that much slower than LOCK INCL/DECL. Of course, I've only measured
this on my Dual-PPro test box, so other i386 arch CPUs may exhibit other
behaviour.

David
