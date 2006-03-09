Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:53928 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751027AbWCIB5l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2006 20:57:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.34439.977741.295065@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 12:36:07 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
In-Reply-To: <200603081659.05786.jbarnes@virtuousgeek.org>
References: <20060308184500.GA17716@devserv.devel.redhat.com>
	<20060308194037.GO7301@parisc-linux.org>
	<17423.30924.278031.151438@cargo.ozlabs.ibm.com>
	<200603081659.05786.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Jesse Barnes writes:

> It uses a per-node address space to reference the local bridge.  The 
> local bridge then waits until the remote bridge has acked the write 
> before, then sets the outstanding write register to the appropriate 
> value.

That sounds like mmiowb can only be used when preemption is disabled,
such as inside a spin-locked region - is that right?

Paul.
