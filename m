Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263529AbUCTUUs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 20 Mar 2004 15:20:48 -0500
Date: Sat, 20 Mar 2004 12:20:48 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: compat-signal-noarch-2004-01-29.patch again
Message-Id: <20040320122048.70db9888.akpm@osdl.org>
In-Reply-To: <20040320133634.GU25059@parcelfarce.linux.theplanet.co.uk>
References: <20040319214949.6b7d50bc.akpm@osdl.org>
	<20040320051519.780318b8.ak@suse.de>
	<20040319223744.1f003f9f.akpm@osdl.org>
	<20040320055753.27517d88.ak@suse.de>
	<20040320133634.GU25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@debian.org>
Cc: ak@suse.de, linux-arch@vger.kernel.org, carlos@baldric.uwo.ca
List-ID: <linux-arch.vger.kernel.org>

Matthew Wilcox <willy@debian.org> wrote:
>
> On Sat, Mar 20, 2004 at 05:57:53AM +0100, Andi Kleen wrote:
> > No. The problem is not in a particular implementation of this for a specific 
> > architecture, but in the generic design - it is the wrong direction and will
> > cause hard to fix later design problems.
> 
> You're wrong.  Just accept this patch.

I can sort-of-see Andi's worry.

The issue appears to be that at some time in the future he will have 64-bit
applications using the 32-bit API without PER_LINUX32 set.  So the proposed
is_compat_task() is meaningless in this context - hence Andi doesn't want
is_compat_task() propagated around the place.

This begs the question of how his kernel correctly handle these
pseudo-32-bit tasks.
