Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E3C33263A
	for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124127; cv=none; b=tmjLMzeZaKRw3wjx4nXLbiNtI7utZRls9KwAH9wI9mnWa074WCY8zurvJQ54cpNhE4hODplLnRFaAgTiOIYI1r/fggzeQj20xW0i8UMO3ZmcNXxgOhXlMDz6PVbBUeMSLtk4SAY5Qm6NA38sZA81NlDvtNIxzBCHO33bf9NKKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124127; c=relaxed/simple;
	bh=Sz2h/B59VzM/elbQ5KRgcEfNz0dQLT3qJ4J437bHqGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2d2FU4tNhBI6aFVhCBlE/U1nDr87BYkWZgYOkIfIzz/wFZefYayKCK2PurAmZbQL302YtpwuTvxzFYCoupobJCle4kswdSrAr08F7bhIxcwg0nOskpKs242Cpg6Ul2w+MwS1enJkE/q+KN3iFK0MoQ4hK/jtnxuZAM+Sitjit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=AjwtLSmC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="AjwtLSmC"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cbc593a67aso38240585a.2
        for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 08:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1772124125; x=1772728925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25OvDP+ctZOpce7ovpdW5sTLVF7qvDLK1eZyECLnIqg=;
        b=AjwtLSmC61L8E5yz6NT2QxMVMiSqpS9Qg8xsntSjYgvfKuinwUzr5KKZcGolo/2gFn
         0AVyL3mQNYFyyijmeGuj457AnpEj6t0x9gfKv65xEV9n6lV7GV7wVYp/YAVeU4WD82Ce
         j33q/IYVlGbh8P2ilCrk0w9E3TxFxc6j4ART7yV/rM0ZFHve0l8eIbTRfttJR6xqnkTs
         nOhQtyuvY518RDDjJLEqcATB3HDmLO2AFyMfSD4Nx532YSwiJW/z3Rt9aZjGR/5suhog
         0xtfwCjAGBQwy9XztDjJ19GtKX8WraT3GHNHs1f/t9mLqFYFqLijmSLAIMXRupM53b3/
         vbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772124125; x=1772728925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25OvDP+ctZOpce7ovpdW5sTLVF7qvDLK1eZyECLnIqg=;
        b=MRDd6iyPPPbCrTHfC5U1fw4EHe5gi2AkmwXEqGuJFGML2UnPpI830bGVkOPpE1Kk1h
         cwANkS8cT4GGamVUDiey1RTGKRKV9dZmHh/t2PCdZcKm5qXUmiFc9cv2wJWV0dLCZ+PJ
         Lz03Jjhi+4QsF8GFDTbnG35EOqJiZSPWBpNeACdErAzf3Q/nMUla5cqq7JnTUPnqYCC4
         3vz7o0Ve1qNWz+2yg0RWnyHfIPyvS+DD2apxSe8DjljWdYr8dG095vw0KFhuRQbpnFja
         3npdhsAKs5s4s2g2Q8V/7+1uXyQ7atomTiGGkV5gzX27CQZ6iMnJeKYoeRvOyhfAM3bU
         OchQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR4yc2fTyi841OWGZxwweOCACTinFVs+n/5ddq2v6gNwoqxKXPSXqbg0u7MBMtEu7dq4O1qTmHvTOx@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3xobOyaClIgHPc4s6mF6wsaWI6OZ0nyJccX8cvjs+mkVUw1T
	rw1BrAhwDWCVy4i3pyqDJNXGc4GMDgFwOoxlvyKIXj0Bndjm6EMaEKUpTNG+vRVcYrMICYezj6J
	lpLg=
X-Gm-Gg: ATEYQzyx4RSv4qbZ91qlDF9iFWnjb9XUu2of4nLtv5Gbg9+zZcrbrDqUMg4c4BGexit
	GmHLy4BfiMNdzgTWgcOzVyU4nzN/ds/oMqlpP2ASwA4Dc8a92DNnoWn7sKS6+i7DxfW4NEb1u5s
	BGjqtA4K9qAOKn63T548sNThdOUELhVU3ztu+penGqqTfsNDHwX9N2bCqAx8baE/yQgxpBki106
	8bV6MjZKcOLfuWNttVAcxAFbFeJykdRqO6uGwXAI/lguMc+ziQhJ1RnUNvjkcrJiJB4yd3BfYPj
	kpVsfFvAwVYJnSxFlJdM24gFIEAwh7vV3iP8kLAxg7tHIYLq0mNTM5EZ8NYIXrl7uq7yvkrQ0VN
	NBq23GIix94GjPtHp+SZYB744e1UtqyXNakcCQEG56CLy6e4Iwwq9+u7Zaslc0VkBkECdJizIev
	ecjyHLcUtVn0Jvk18i0HQYruMVkU+M58uGCwJ28PhIglVfacKtlCx4ehkrWBP25tvtokLxt+bpH
	8RXghrPo14D9EEx055i
X-Received: by 2002:a05:620a:4542:b0:8cb:4c29:66b3 with SMTP id af79cd13be357-8cb8c9cdf25mr2260008985a.15.1772124124932;
        Thu, 26 Feb 2026 08:42:04 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-51.harvard-secure.wrls.harvard.edu. [65.112.8.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716e09csm22299906d6.19.2026.02.26.08.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:42:04 -0800 (PST)
Date: Thu, 26 Feb 2026 11:42:02 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org, Dmitry Vyukov <dvyukov@google.com>,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Akira Yokosawa <akiyks@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Luc Maranget <luc.maranget@inria.fr>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	David Howells <dhowells@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>, Boqun Feng <boqun@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Marco Elver <elver@google.com>
Subject: Re: [BUG] Memory ordering between kmalloc() and kfree()? it's
 confusing!
Message-ID: <d8308828-ed28-4650-8c8f-22a7e5cfd1a0@rowland.harvard.edu>
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

On Fri, Feb 27, 2026 at 01:17:52AM +0900, Harry Yoo wrote:
> On Thu, Feb 26, 2026 at 10:45:55AM -0500, Alan Stern wrote:
> > On Thu, Feb 26, 2026 at 03:35:08PM +0900, Harry Yoo wrote:
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

If those things rely on a percpu array, how can one CPU possibly 
manipulate a resource (slab or something else) that was changed by a 
different CPU?  The whole point of percpu data structures is that each 
CPU gets its own copy.

Alan Stern
