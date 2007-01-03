Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:59201 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179AbXACXPq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Jan 2007 18:15:46 -0500
Date: Wed, 3 Jan 2007 15:15:29 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: + use-cycle_t-instead-of-u64-in-struct-time_interpolator.patch
 added to -mm tree
Message-Id: <20070103151529.85261050.akpm@osdl.org>
In-Reply-To: <617E1C2C70743745A92448908E030B2AF699F6@scsmsx411.amr.corp.intel.com>
References: <20070103134233.c983864f.akpm@osdl.org>
	<617E1C2C70743745A92448908E030B2AF699F6@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, deller@gmx.de, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
List-ID: <linux-arch.vger.kernel.org>

On Wed, 3 Jan 2007 15:04:33 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> > > It's simply impossible to implement cmpxchg() in the general case on
> > > parisc.  This was hashed out in great detail recently ...
> >
> > That's a bug in the time_interpolator implementation.  Fixable, I assume,
> > by whacking a spinlock into struct time_interpolator.
> 
> The cmpxchg is already a bit painful if you have a lot of cpus (and a bunch
> of users that call gettimeofday() incessantly).  A spinlock would most likely
> be even worse (wouldn't it?).
> 

It might be slightly worse, although most of the cost will be common
between the two implementations.  Perhaps some design change is needed in
there (a sequence lock?)

But cmpxchg just isn't suitable for use outside per-arch code.
