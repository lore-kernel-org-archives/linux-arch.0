Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13513 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152AbXACXEg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2007 18:04:36 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: + use-cycle_t-instead-of-u64-in-struct-time_interpolator.patch added to -mm tree
Date: Wed, 3 Jan 2007 15:04:33 -0800
Message-ID: <617E1C2C70743745A92448908E030B2AF699F6@scsmsx411.amr.corp.intel.com>
In-Reply-To: <20070103134233.c983864f.akpm@osdl.org>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Matthew Wilcox <matthew@wil.cx>
Cc: deller@gmx.de, linux-arch@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
List-ID: <linux-arch.vger.kernel.org>

> > It's simply impossible to implement cmpxchg() in the general case on
> > parisc.  This was hashed out in great detail recently ...
>
> That's a bug in the time_interpolator implementation.  Fixable, I assume,
> by whacking a spinlock into struct time_interpolator.

The cmpxchg is already a bit painful if you have a lot of cpus (and a bunch
of users that call gettimeofday() incessantly).  A spinlock would most likely
be even worse (wouldn't it?).

-Tony
