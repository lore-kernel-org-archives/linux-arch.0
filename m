Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34348 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbCSScb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 14:32:31 -0400
Date: Thu, 19 Mar 2015 19:32:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Xen-devel] [PATCH 0/9] qspinlock stuff -v15
Message-ID: <20150319183220.GU23123@twins.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
 <550B0EFE.1040309@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550B0EFE.1040309@citrix.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Vrabel <david.vrabel@citrix.com>
Cc: Waiman.Long@hp.com, raghavendra.kt@linux.vnet.ibm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com, boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, x86@kernel.org, mingo@redhat.com, doug.hatch@hp.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, scott.norton@hp.com, paolo.bonzini@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, oleg@redhat.com, luto@amacapital.net, torvalds@linux-foundation.org
Message-ID: <20150319183220.j3b3ycCW3FGtl0jR_r4zZzcNq1-zyjfsuEet_DfOv2Q@z>

On Thu, Mar 19, 2015 at 06:01:34PM +0000, David Vrabel wrote:
> This seems work for me, but I've not got time to give it a more thorough
> testing.
> 
> You can fold this into your series.

Thanks!

> There doesn't seem to be a way to disable QUEUE_SPINLOCKS when supported by
> the arch, is this intentional?  If so, the existing ticketlock code could go.

Yeah, its left as a rudiment such that if we find issues with the
qspinlock code we can 'revert' with a trivial patch. If no issues show
up we can rip out all the old code in a subsequent release.
