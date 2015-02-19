From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/5] Reenable might_sleep() checks for might_fault()
Date: Thu, 19 Feb 2015 16:14:39 +0100
Message-ID: <20150219161439.4aa444fe@thinkpad-w530>
References: <1418221414-60110-1-git-send-email-dahi@linux.vnet.ibm.com>
	<20150112151911.4a51f09d@thinkpad-w530>
	<20150209144217.GT5029@twins.programming.kicks-ass.net>
	<20150219154805.2651257d@thinkpad-w530>
	<20150219150723.GF21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:39233 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbbBSPOu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Feb 2015 10:14:50 -0500
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Thu, 19 Feb 2015 15:14:48 -0000
In-Reply-To: <20150219150723.GF21418@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz

> On Thu, Feb 19, 2015 at 03:48:05PM +0100, David Hildenbrand wrote:
> > Downside is that now that I have to touch all fault handlers, I have to go
> > through all archs again.
> 
> You should be able to borrow from the -rt patches there. They have all
> that.
> 

Jup, that's what I partially did.

Thanks

David
