Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57983 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbbEGLki (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2015 07:40:38 -0400
Date: Thu, 7 May 2015 13:40:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 00/15] decouple pagefault_disable() from
 preempt_disable()
Message-ID: <20150507114021.GH23123@twins.programming.kicks-ass.net>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20150506150158.0a927470007e8ea5f3278956@linux-foundation.org>
 <20150507094819.GC4734@gmail.com>
 <554B43AA.1050605@de.ibm.com>
 <20150507110828.GA15284@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150507110828.GA15284@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20150507114021.GJvKrZdLVmNLnCB7P-lhuQisatgiibeHWaA-spqsKNM@z>

On Thu, May 07, 2015 at 01:08:28PM +0200, Ingo Molnar wrote:
> Yes, but I'm wondering what I'm missing: is there any deep reason for 
> making pagefaults-disabled sections non-atomic?

This all comes from -rt, where we had significant latencies due to these
things.
