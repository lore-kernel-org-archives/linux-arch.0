From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 00/15] decouple pagefault_disable() from
 preempt_disable()
Date: Fri, 15 May 2015 16:23:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505151620390.4225@nanos>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41794 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbEOOXt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 May 2015 10:23:49 -0400
In-Reply-To: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org

On Mon, 11 May 2015, David Hildenbrand wrote:
> 
> Any feedback very welcome!

Thanks for picking that up (again)!

We've pulled the lot into RT and unsurprisingly it works like a charm :)

Works on !RT as well. 

Reviewed-and-tested-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
