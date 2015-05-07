From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RFC 01/15] uaccess: count pagefault_disable() levels in
 pagefault_disabled
Date: Thu, 7 May 2015 13:12:39 +0200
Message-ID: <20150507111239.GB15284@gmail.com>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1430934639-2131-2-git-send-email-dahi@linux.vnet.ibm.com>
 <20150507102254.GE23123@twins.programming.kicks-ass.net>
 <20150507125053.5d2e8f0a@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150507125053.5d2e8f0a@thinkpad-w530>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* David Hildenbrand <dahi@linux.vnet.ibm.com> wrote:

> > AFAICR we did this to avoid having to do both:
> > 
> > 	preempt_disable();
> > 	pagefault_disable();
> > 
> > in a fair number of places -- just like this patch-set does, this is
> > touching two cachelines where one would have been enough.
> > 
> > Also, removing in_atomic() from fault handlers like you did
> > significantly changes semantics for interrupts (soft, hard and NMI).
> > 
> > So while I agree with most of these patches, I'm very hesitant on the
> > above little detail.
> 
> Just to make sure we have a common understanding (as written in my 
> cover letter):
> 
> Your suggestion won't work with !CONFIG_PREEMPT 
> (!CONFIG_PREEMPT_COUNT). If there is no preempt counter, in_atomic() 
> won't work. So doing a preempt_disable() instead of a 
> pagefault_disable() is not going to work. (not sure how -RT handles 
> that - most probably with CONFIG_PREEMPT_COUNT being enabled, due to 
> atomic debug).
> 
> That's why I dropped that check for a reason.

So, what's the point of disabling the preempt counter?

Looks like the much simpler (and faster) solution would be to 
eliminate CONFIG_PREEMPT_COUNT (i.e. make it always available), and 
use it for pagefault-disable.

> This patchset is about decoupling both concept. (not ending up with 
> to mechanisms doing almost the same)

So that's really backwards: just because we might not have a handy 
counter we introduce _another one_, and duplicate checks for it ;-)

Why not keep a single counter, if indeed what we care about most in 
the pagefault_disable() case is atomicity?

Thanks,

	Ingo
