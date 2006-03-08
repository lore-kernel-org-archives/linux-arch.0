Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18050
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932534AbWCHWXd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 17:23:33 -0500
Date: Wed, 08 Mar 2006 14:23:26 -0800 (PST)
Message-Id: <20060308.142326.116048199.davem@davemloft.net>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17423.21589.385336.68518@cargo.ozlabs.ibm.com>
References: <29826.1141828678@warthog.cambridge.redhat.com>
	<20060308145506.GA5095@devserv.devel.redhat.com>
	<17423.21589.385336.68518@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: paulus@samba.org
Cc: alan@redhat.com, dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 9 Mar 2006 09:01:57 +1100

> On PPC machines, the PTE has a bit called G (for Guarded) which
> indicates that the memory mapped by it has side effects.  It prevents
> the CPU from doing speculative accesses (i.e. the CPU can't send out a
> load from the page until it knows for sure that the program will get
> to that instruction) and from prefetching from the page.
> 
> The kernel sets G=1 on MMIO and PIO pages in general, as you would
> expect, although you can get G=0 mappings for framebuffers etc. if you
> ask specifically for that.

Sparc64 has a similar PTE bit called "E" for "side-Effect".
And we also do the same thing as powerpc for framebuffers.

Note that on sparc64 in our asm/io.h PIO/MMIO accessor macros
we use physical addresses, so we don't have to map anything
in ioremap(), and use a special address space identifier on
the loads and stores that indicates "E" behavior is desired.
