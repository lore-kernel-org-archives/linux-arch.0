Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41584 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbbERNEz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 May 2015 09:04:55 -0400
Message-ID: <1431954250.3322.0.camel@twins>
Subject: Re: [PATCH v1 00/15] decouple pagefault_disable() from
 preempt_disable()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 18 May 2015 15:04:10 +0200
In-Reply-To: <20150518144624.3fb3fa46@thinkpad-w530>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
	 <alpine.DEB.2.11.1505151620390.4225@nanos>
	 <20150518144624.3fb3fa46@thinkpad-w530>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20150518130410.A2ZWM4cIyr1ARxC9TJpDBsD2RiRQqViMv5TvQL8M6dc@z>

On Mon, 2015-05-18 at 14:46 +0200, David Hildenbrand wrote:
> > Thanks for picking that up (again)!
> > 
> > We've pulled the lot into RT and unsurprisingly it works like a charm :)
> > 
> > Works on !RT as well. 
> > 
> > Reviewed-and-tested-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> 
> Thanks a lot Thomas!
> 
> @Ingo, @Andrew, nothing changed during the review of this version and Thomas
> gave it a review + test.
> 
> Any of you willing to pick this up to give it a shot? Or should I resend it with
> Thomas' tags added.

I've got it queued.

Thanks!
