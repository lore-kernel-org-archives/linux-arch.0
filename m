Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:51661 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbbERMqi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 May 2015 08:46:38 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Mon, 18 May 2015 13:46:37 +0100
Date: Mon, 18 May 2015 14:46:24 +0200
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 00/15] decouple pagefault_disable() from
 preempt_disable()
Message-ID: <20150518144624.3fb3fa46@thinkpad-w530>
In-Reply-To: <alpine.DEB.2.11.1505151620390.4225@nanos>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
	<alpine.DEB.2.11.1505151620390.4225@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org
Message-ID: <20150518124624.jLxd-7rViA15Wm7C46mh3_yt59UIjpwyF8OfH5vevDM@z>

> Thanks for picking that up (again)!
> 
> We've pulled the lot into RT and unsurprisingly it works like a charm :)
> 
> Works on !RT as well. 
> 
> Reviewed-and-tested-by: Thomas Gleixner <tglx@linutronix.de>
> 

Thanks a lot Thomas!

@Ingo, @Andrew, nothing changed during the review of this version and Thomas
gave it a review + test.

Any of you willing to pick this up to give it a shot? Or should I resend it with
Thomas' tags added.

Thanks!

David

