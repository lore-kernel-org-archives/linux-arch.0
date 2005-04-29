Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [RFC] unify semaphore implementations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <20050428234005.A19778@flint.arm.linux.org.uk>
References: <20050428182926.GC16545@kvack.org>
	 <20050428234005.A19778@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 20:42:38 -0400
Message-Id: <1114735358.9738.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

to den 28.04.2005 Klokka 23:40 (+0100) skreiv Russell King:
> On Thu, Apr 28, 2005 at 02:29:26PM -0400, Benjamin LaHaise wrote:
> > Please review the following series of patches for unifying the 
> > semaphore implementation across all architectures (not posted as 
> > they're about 350K), as they have only been tested on x86-64.  The 
> > code generated is functionally identical to the earlier i386 
> > variant, but since gcc has no way of taking condition codes as 
> > results, there are two additional instructions inserted from the 
> > use of generic atomic operations.  All told the >6000 lines of code 
> > deleted makes for a much easier job for subsequent patches changing 
> > semaphore functionality.  Cheers,
> 
> I'm not sure why we're doing this, apart from a desire to unify stuff.

It started from a desire to extend the existing implementations to
support new features such as asynchronous notification. Currently that
sort of thing is impossible unless your developer-super-powers include
the ability to herd 24 different subsystem maintainers into working
together on a solution.

In other words, the main drive is the desire to make it maintainable.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>
