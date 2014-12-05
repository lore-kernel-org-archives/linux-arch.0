From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 3/5] mm, uaccess: trigger might_sleep() in
 might_fault() when pagefaults are disabled
Date: Fri, 5 Dec 2014 12:46:29 +0100
Message-ID: <20141205124629.2c77290f@thinkpad-w530>
References: <1417778289-51567-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1417778289-51567-4-git-send-email-dahi@linux.vnet.ibm.com>
	<20141205114529.GD4213@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:33870 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaLELqg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Dec 2014 06:46:36 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Fri, 5 Dec 2014 11:46:35 -0000
In-Reply-To: <20141205114529.GD4213@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, peterz@infradead.org, hughd@google.com, hocko@suse.cz

> On Fri, Dec 05, 2014 at 12:18:07PM +0100, David Hildenbrand wrote:
> > -void might_fault(void)
> > +void __might_fault(const char *file, int line)
> >  {
> >  	/*
> >  	 * Some code (nfs/sunrpc) uses socket ops on kernel memory while
> > @@ -3710,21 +3710,16 @@ void might_fault(void)
> >  	 */
> >  	if (segment_eq(get_fs(), KERNEL_DS))
> >  		return;
> > -
> > -	/*
> > -	 * it would be nicer only to annotate paths which are not under
> > -	 * pagefault_disable, however that requires a larger audit and
> > -	 * providing helpers like get_user_atomic.
> > -	 */
> > -	if (in_atomic())
> > +	if (unlikely(!pagefault_disabled())) {
> > +		__might_sleep(file, line, 0);
> >  		return;
> > -
> > -	__might_sleep(__FILE__, __LINE__, 0);
> > -
> > +	}
> 
> This should be likely() instead of unlikely(), no?
> I'd rather write this
> 
> 	if (pagefault_disabled())
>  		return;
> 	__might_sleep(file, line, 0);
> 
> and leave the likely stuff completely away.

Makes perfect sense!

Thanks!

David
