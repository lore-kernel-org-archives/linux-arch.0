From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 2/2] mm, sched: trigger might_sleep() in
 might_fault() when pagefaults are disabled
Date: Thu, 27 Nov 2014 19:08:42 +0100
Message-ID: <20141127190842.75a9cce3@thinkpad-w530>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1417108217-42687-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1417108217-42687-3-git-send-email-dahi@linux.vnet.ibm.com>
	<20141127172449.GA30380@redhat.com>
	<20141127173218.GA30419@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:32885 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaK0SIw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Nov 2014 13:08:52 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Thu, 27 Nov 2014 18:08:50 -0000
In-Reply-To: <20141127173218.GA30419@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, tglx@linutronix.de, David.Laight@ACULAB.COM

> > > -
> > > -	__might_sleep(__FILE__, __LINE__, 0);
> > > +	if (unlikely(!pagefault_disabled()))
> > > +		__might_sleep(__FILE__, __LINE__, 0);
> > >    
> 
> Same here: so maybe make might_fault a wrapper
> around __might_fault as well.

Yes, I also noticed that. It was part of the original code.
For now I kept this revert as close as possible to
the original patch.

Better fix this in an add-on patch? Or directly in this commit? At least for
the in-header function it is easy to fix in this patch.

Thanks!
