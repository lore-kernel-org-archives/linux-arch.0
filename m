Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:15252 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262079AbUEQSWU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2004 14:22:20 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16553.725.469944.429214@napali.hpl.hp.com>
Date: Mon, 17 May 2004 11:22:13 -0700
Subject: Re: [PATCH] Allow arch override for kmem_bufctl_t
In-Reply-To: <40A60984.1070202@colorfullife.com>
References: <40A60984.1070202@colorfullife.com>
Reply-To: davidm@hpl.hp.com
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Sat, 15 May 2004 14:13:56 +0200, Manfred Spraul <manfred@colorfullife.com> said:

  Manfred> Hi Andrew, The slab allocator keeps track of the free
  Manfred> objects in a slab with a linked list of integers
  Manfred> (typedef'ed to kmem_bufctl_t). Right now unsigned int is
  Manfred> used for kmem_bufctl_t, i.e. 4 bytes per-object overhead.
  Manfred> The attached patch allows an arch override for this type:
  Manfred> Theoretically, unsigned short is sufficient for
  Manfred> kmem_bufctl_t and this would reduce the per-object overhead
  Manfred> to 2 bytes. But some archs cannot operate on 16-bit values
  Manfred> efficiently, thus it's not possible to switch everyone to
  Manfred> ushort.  The patch switches i386, the port maintainers
  Manfred> should switch their arch if there are no problems with
  Manfred> 16-bit quantities. All accesses to kmem_bufctl_t are under
  Manfred> a per-cache spinlock and not in the hottest path.

  Manfred> Could you apply it to -mm?

There was no patch attached.  I suspect we'd want to turn this on for
ia64 as well.  Do you have a good (worst-case) benchmark to evaluate
this change?

	--david
