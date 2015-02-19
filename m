From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/5] Reenable might_sleep() checks for might_fault()
Date: Thu, 19 Feb 2015 16:07:23 +0100
Message-ID: <20150219150723.GF21418@twins.programming.kicks-ass.net>
References: <1418221414-60110-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20150112151911.4a51f09d@thinkpad-w530>
 <20150209144217.GT5029@twins.programming.kicks-ass.net>
 <20150219154805.2651257d@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45700 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbbBSPHe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Feb 2015 10:07:34 -0500
Content-Disposition: inline
In-Reply-To: <20150219154805.2651257d@thinkpad-w530>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz

On Thu, Feb 19, 2015 at 03:48:05PM +0100, David Hildenbrand wrote:
> Downside is that now that I have to touch all fault handlers, I have to go
> through all archs again.

You should be able to borrow from the -rt patches there. They have all
that.
