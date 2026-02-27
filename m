Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCE36494B
	for <linux-arch@vger.kernel.org>; Fri, 27 Feb 2026 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179630; cv=none; b=BgQboia4q7jXPmCpd8mr9cSA103KG0djrstwqN29/OT0ROfDxCBW/pICa0yjgH9VUSp+fKGmcfyg9irZwvyGuFTQLkHFSJl88dhulFwyLe0qjfJh3WoHUEdPA7+GP+PFgrnLbUCca929GNlWQXzzdsa/4o9COrVLJxtfKCECnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179630; c=relaxed/simple;
	bh=FpnVQRb3GHt6nLCuJBC4UipKjion5rqGF0xAmH46rm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqMKy7ORADJKa1S1YW5loptj7YKS9x9nuoyLTWotdy+9GJwk7b4D6PAQosOb6qtGHk7AoyTfQcJx5STYczSBa+9hItFrmHvA4cgDS7GNZdKgzxESdfXD++tR5/9IL4xMUx+zqKPM/3YnWOcXNKn/RLaWWnyXCWU5GfvOKFAgDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BH3JEO9B; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BH3JEO9B"
Date: Fri, 27 Feb 2026 16:06:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772179617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTeZz0F/xvyPF1EACAmjGDgdsxghstNqLCL/uyUX4X4=;
	b=BH3JEO9Be6RKFr0ulxlKgajovzOPjD3SVKEk8f7tvapHX/F9vwCYOS/1cfL8VYubbKdHqN
	KnqNmAcGDfq7Y9h0i2MPyBX6x7MPr3br8N9KQs8X9xELHZZX3rBVjxJKNHf7I7OjM+ujKW
	zaeW/qL2IbjcwgEdAklxvl60e9BmVnw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-mm@kvack.org, 
	Dmitry Vyukov <dvyukov@google.com>, lkmm@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Luc Maranget <luc.maranget@inria.fr>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, David Howells <dhowells@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Boqun Feng <boqun@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrea Parri <parri.andrea@gmail.com>, Pedro Falcato <pfalcato@suse.de>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Marco Elver <elver@google.com>
Subject: Re: [BUG] Memory ordering between kmalloc() and kfree()? it's
 confusing!
Message-ID: <yf7gon3s3efwiwpsdytujnhohnxjc3fgu7oabmia4tbhwqgcs7@rzb7sfy2wrbu>
References: <aZ_lJAqxh_hNGr_v@hyeyoo>
 <9dcd02b9-42da-455d-aa08-165e6ff0b921@rowland.harvard.edu>
 <aaByMLSAIJM8HdbO@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaByMLSAIJM8HdbO@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 27, 2026 at 01:17:52AM +0900, Harry Yoo wrote:
> On Thu, Feb 26, 2026 at 10:45:55AM -0500, Alan Stern wrote:
> > On Thu, Feb 26, 2026 at 03:35:08PM +0900, Harry Yoo wrote:
> > > Hello, SLAB, LKMM, and KCSAN folks!
> > > 
> > > I'd like to discuss slab's assumption on users regarding memory ordering.
> > > 
> > > Recently, I've been investigating an interesting slab memory ordering
> > > issue [3] [4] in v7.0-rc1, which made me think about memory ordering
> > > for slab objects.
> > > 
> > > But without answering "What does slab expect users to do for correct
> > > operation?", I kept getting puzzled, and my brain hurt too much :/
> > > I'm writing things down to stop getting confused :)
> > > 
> > > Since I have never thought about this before, my reasoning could be
> > > partially or entirely incorrect. If so, please kindly let me know.
> > > 
> > > # Slab's assumption: Stores to object, its metadata, or struct slab
> > > # must be visible to the CPU that frees the object, when it is
> > > # passed to kfree(). It's users' responsibility to guarantee that.
> > > 
> > > When the slab allocator allocates an object, it updates its metadata and
> > > struct slab fields. After allocation, the user of slab updates object's
> > > content. As long as the object is freed on the same CPU that it was
> > > allocated, kfree() can see those stores (A CPU must be able to see
> > > what's in its store buffer), so no problem!
> > > 
> > > However, when e.g.) the pointer to object is stored in a shared variable
> > > and then freed on a different CPU, things become trickier.
> > > 
> > > In this case, I think it's fair for the slab allocator to assume that:
> > > 
> > >   1) Such stores must involve _at least_ a release barrier
> > >      (for example, via {cmp,}xchg{,_release}, or smp_store_release())
> > >      to ensure preceding stores are visible to other CPUs before
> > >      the pointer store becomes visible, and
> > > 
> > >   2) The CPU that frees an object must invoke at least an acquire
> > >      barrier to ensure that stores to object content / metadata, etc.,
> > >      are visible to the freeing CPU when it calls kfree().
> > > 
> > > Because the slab allocator itself doesn't guarantee that such
> > > barriers are invoked within the allocator, it relies on users to
> > > do this when needed.
> > 
> > It doesn't?  Then how does the slab allocator guarantee that two 
> > different CPUs won't try to perform allocations or deallocations from 
> > the same slab at the same time, messing everything up?
> 
> Ah, alloc/free slowpaths do use cmpxchg128 or spinlock and
> don't mess things up.
> 
> But fastpath allocs/frees are served from percpu array that is protected
> by a local_lock. local_lock has a compiler barrier in it, but that's
> not enough.

Hmm, this memory-ordering issue is indeed pretty mind-bending. I'd like to
share a few thoughts as well. Happy to be corrected!

For our current problem, I think the key lies in the relative ordering between
the two variables, stride and obj_exts. To address it, we need to ensure that
on the writer side, stride is assigned before obj_exts. And on the reader
side, we need to guarantee that if it can observe the latest value of
obj_exts, then it must also be able to observe the latest value of stride. If
this understanding is correct, then even if the slab API caller inserts a
memory barrier between alloc and free, or uses a spinlock (or any statement
that provides an equivalent memory-barrier effect), it would only ensure that
the writes to the pair {stride, obj_exts} as a whole happen-before the reads
of {stride, obj_exts} as a whole. However, it still wouldn't be able to
guarantee the ordering between the two variables: stride and obj_exts.

-- 
Thanks,
Hao
