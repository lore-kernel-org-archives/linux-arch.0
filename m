From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 4/4] perf: Optimize perf_output_begin() -- weaker memory
 barrier
Date: Fri, 8 Nov 2013 02:54:11 +0000 (UTC)
Message-ID: <1435428554.62880.1383879251319.JavaMail.zimbra@efficios.com>
References: <20131107220314.740353088@infradead.org> <20131107221254.293322441@infradead.org> <20131107211617.GD27329@Krystal> <20131108021928.GZ18245@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([78.47.125.74]:58056 "EHLO mail.efficios.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054Ab3KHDAS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 7 Nov 2013 22:00:18 -0500
In-Reply-To: <20131108021928.GZ18245@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, linux-arch@vger.kernel.org, geert@linux-m68k.org, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko carstens <heiko.carstens@de.ibm.com>, tony luck <tony.luck@intel.com>

----- Original Message -----
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: peterz@infradead.org, linux-arch@vger.kernel.org, geert@linux-m68k.org, torvalds@linux-foundation.org,
> VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com,
> michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, "heiko carstens"
> <heiko.carstens@de.ibm.com>, "tony luck" <tony.luck@intel.com>
> Sent: Thursday, November 7, 2013 9:19:28 PM
> Subject: Re: [PATCH 4/4] perf: Optimize perf_output_begin() -- weaker memory barrier
> 
> On Thu, Nov 07, 2013 at 04:16:17PM -0500, Mathieu Desnoyers wrote:
> > * peterz@infradead.org (peterz@infradead.org) wrote:
> > > Apply the fancy new smp_load_acquire() and smp_store_release() to
> > > potentially avoid the full memory barrier in perf_output_begin().
> > > 
> > > On x86 (and other TSO like architectures) this removes all explicit
> > > memory fences, on weakly ordered systems this often allows the use of
> > > weaker barriers; in particular on powerpc we demote from a full sync
> > > to a cheaper lwsync.
> > > 
> > > Cc: Tony Luck <tony.luck@intel.com>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> > > Cc: Michael Ellerman <michael@ellerman.id.au>
> > > Cc: Michael Neuling <mikey@neuling.org>
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > Cc: Victor Kaplansky <VICTORK@il.ibm.com>
> > > Suggested-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > > ---
> > >  kernel/events/ring_buffer.c |   62
> > >  +++++++++++++++++++++++++-------------------
> > >  1 file changed, 36 insertions(+), 26 deletions(-)
> > > 
> > > --- a/kernel/events/ring_buffer.c
> > > +++ b/kernel/events/ring_buffer.c
> > > @@ -41,6 +41,32 @@ static void perf_output_get_handle(struc
> > >  	handle->wakeup = local_read(&rb->wakeup);
> > >  }
> > >  
> > > +/*
> > > + * Our user visible data structure (struct perf_event_mmap_page) uses
> > > + * u64 values for ->data_head and ->data_tail to avoid size variance
> > > + * across 32/64 bit.
> > > + *
> > > + * Since you cannot mmap() a buffer larger than your memory address
> > > space
> > > + * we're naturally limited to unsigned long and can avoid writing the
> > > + * high word on 32bit systems (its always 0)
> > > + *
> > > + * This allows us to always use a single load/store.
> > > + */
> > > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > > +static inline unsigned long *low_word(u64 *ptr)
> > > +{
> > > +	return (unsigned long *)ptr;
> > > +}
> > > +#else /* __ORDER_BIG_ENDIAN__ */
> > > +static inline unsigned long *low_word(u64 *ptr)
> > > +{
> > > +	void *_ptr = ptr;
> > > +	_ptr += sizeof(u64);
> > > +	_ptr -= sizeof(unsigned long);
> > > +	return (unsigned long *)_ptr;
> > > +}
> > > +#endif
> > > +
> > >  static void perf_output_put_handle(struct perf_output_handle *handle)
> > >  {
> > >  	struct ring_buffer *rb = handle->rb;
> > > @@ -61,28 +87,15 @@ static void perf_output_put_handle(struc
> > >  	 *
> > >  	 *   kernel				user
> > >  	 *
> > > -	 *   READ ->data_tail			READ ->data_head
> > > -	 *   smp_mb()	(A)			smp_rmb()	(C)
> > > +	 *   READ.acq ->data_tail  (A)		READ.acq ->data_head  (C)
> > 
> > I don't get how the barrier() in the TSO implementation of
> > smp_load_acquire (A) orders the following writes to $data after the
> > READ.acq of data_tail. I'm probably missing something.
> > 
> > Also, I don't get how the smp_load_acquire (C) with the barrier() (x86
> > TSO) orders READ $data after the READ.acq of data_head.
> > 
> > I don't have the TSO model fresh in memory however.
> 
> TSO guarantees that earlier reads will not be reordered with later
> writes, so only a barrier() is required.

OK, so this takes care of (A), but how about (C) ? It's about the order of two READ operations.

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
> > >  	 *   WRITE $data			READ $data
> > > -	 *   smp_wmb()	(B)			smp_mb()	(D)
> > > -	 *   STORE ->data_head			WRITE ->data_tail
> > > +	 *   STORE.rel ->data_head (B)		WRITE.rel ->data_tail (D)
> > 
> > You might want to choose either STORE or WRITE for consistency.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > >  	 *
> > >  	 * Where A pairs with D, and B pairs with C.
> > >  	 *
> > > -	 * I don't think A needs to be a full barrier because we won't in fact
> > > -	 * write data until we see the store from userspace. So we simply don't
> > > -	 * issue the data WRITE until we observe it. Be conservative for now.
> > > -	 *
> > > -	 * OTOH, D needs to be a full barrier since it separates the data READ
> > > -	 * from the tail WRITE.
> > > -	 *
> > > -	 * For B a WMB is sufficient since it separates two WRITEs, and for C
> > > -	 * an RMB is sufficient since it separates two READs.
> > > -	 *
> > >  	 * See perf_output_begin().
> > >  	 */
> > > -	smp_wmb();
> > > -	rb->user_page->data_head = head;
> > > +	smp_store_release(low_word(&rb->user_page->data_head), head);
> > >  
> > >  	/*
> > >  	 * Now check if we missed an update -- rely on previous implied
> > > @@ -139,7 +152,13 @@ int perf_output_begin(struct perf_output
> > >  	perf_output_get_handle(handle);
> > >  
> > >  	do {
> > > -		tail = ACCESS_ONCE(rb->user_page->data_tail);
> > > +		tail = smp_load_acquire(low_word(&rb->user_page->data_tail));
> > > +		/*
> > > +		 * STORES of the data below cannot pass the ACQUIRE barrier.
> > > +		 *
> > > +		 * Matches with an smp_mb() or smp_store_release() in userspace
> > > +		 * as described in perf_output_put_handle().
> > > +		 */
> > >  		offset = head = local_read(&rb->head);
> > >  		if (!rb->overwrite &&
> > >  		    unlikely(CIRC_SPACE(head, tail, perf_data_size(rb)) < size))
> > > @@ -147,15 +166,6 @@ int perf_output_begin(struct perf_output
> > >  		head += size;
> > >  	} while (local_cmpxchg(&rb->head, offset, head) != offset);
> > >  
> > > -	/*
> > > -	 * Separate the userpage->tail read from the data stores below.
> > > -	 * Matches the MB userspace SHOULD issue after reading the data
> > > -	 * and before storing the new tail position.
> > > -	 *
> > > -	 * See perf_output_put_handle().
> > > -	 */
> > > -	smp_mb();
> > > -
> > >  	if (unlikely(head - local_read(&rb->wakeup) > rb->watermark))
> > >  		local_add(rb->watermark, &rb->wakeup);
> > >  
> > > 
> > > 
> > 
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> > 
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
