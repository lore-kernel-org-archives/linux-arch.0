Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB78387581
	for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120761; cv=none; b=heMyjiu53K7MRuCQox9qCvKImyqguOkF0vowbEFjUUNSAdZkwvpI1SNjdTy7TemD73PUzSMqg9KXtA4Ii4oFt6C5h0l9BaXY6y332brMgoL6NJv7ccQDdbLz61LMjLHrvPYDkXr+FR26YtL32JcvdjOw+QISf1JioR0R05c2sIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120761; c=relaxed/simple;
	bh=YWHQ3hb1ArwIbRQ89q9zG+CqmiOK4wPfERQK4NQHajI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aetGxp/V3zLQ8MtN9criX81dPfqT+zz3tuivarqPG1my6KJrF7GQBzaYvetqU89EAEhZugElwCvheX4jH3oTKbFYBqig7F5ViQvvTizjqWy9C7zNad8o32JLMO57Uf1RhbKgnPzcck+JigTbBYp9PyDZntY/fSS6YuxQp9/3WhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=vbyLVJ3W; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="vbyLVJ3W"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cbb6d5f780so99169085a.1
        for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1772120759; x=1772725559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wuTxE1p/1rypYy1lij4BdYhQVDSEtiYhB76DoENLIhw=;
        b=vbyLVJ3Wp5g355/EWwwRRqEl8xwl4FavfNRArcM7+ZJQrG3rMCqnFw+dH1deNfTm9Z
         zi9uQSujEDvEV1FfdyeXtJdBcz80mhztWVwDw3mL0Dno8Ak5O2uq4r7YFKboGhd+gYoo
         uCsmyfzZWBm3u6Yf3lSSaK9w00q69ohHAQjb1ioKqlufu4nKNPmETYEqquisjHET3QV8
         +vDZ63rccbfTQZ9YLcF6oJ5JrcvHThBlNc3RhudhvC7jRq9gIdiFKalfEZ4hiDBPoK8F
         ocdiIrAOIqMa4iyBF0Hrx4zHEnlIhQ+IehbyCB6rk2jqXbsefbsrwadO2br/2t4CJQp5
         Jp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120759; x=1772725559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuTxE1p/1rypYy1lij4BdYhQVDSEtiYhB76DoENLIhw=;
        b=BzEPbYoW/aQ0ZfU+gaRFuGpbjDRJGJ9GHcDmHKzlwTElqvq7ubuxZtPxgwVX7AK++G
         2maKMHZLUjnCG7IP7IPsqwhQhXvRczuKK8Lomx1DqY1YxQmS7l2Xbvpr9H6x+QekMbgI
         xkp2uFGr7/afHEBPwkUHqZKRAqPpTaEnw0t4YUdnB/zsRvgJW7c/GFYUMYVo6QwLpqC5
         uXmSrPGtVN5PHgT+l4tALI6QvJBp1NsiC2FPNSFc6R0AOth79A8hQ14bl4DMETklfaWK
         cXFFJEaJAkc1hbf0DYcP5Mbwob12t9DYjN42D04PeTMqqecsXo2BeEyG6sCqHLv8FgSk
         sqkA==
X-Forwarded-Encrypted: i=1; AJvYcCWGtMbjxixdbShDCkYdXTH4ZoqrJYxWBKyw/zflYTASaoH88Fa8hxLhD51meRI92RH7/HY7XDrdInbG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yHwNWhCm5F2DWpT0vUI/XnKA5vRIw90nSF7BmwcdkiI2El69
	F0dxjHVjuuvZl7G3rajw/9XuEO84UQav6cutwDReDQzV6y/3rgI0J984tSLoxPV1Iw==
X-Gm-Gg: ATEYQzzgNR6BVj1bbpzapsrluUj9tsMqfRUnk40eqAL8RQyAckJbKVGPuOV98zsw1vn
	tzhNMMN3ruJUdXrY+/lfxBFWotPnHMhNWXMnYWZcnbvqYNRR34JvdjC4yRpVn6xhqmi04IEvGYa
	S+sdO19lMJfpwLILCcaR7ZnS16+wA9ueEI0vYVFgFKLz+tSe8Uq89D7vUO0UnomC7v36taOb+fH
	ydnFvkhrmCKgd366PbE3fv/zB7twhn4xeagkT217hO4ILOmQMDZeBz36dj99784O6NPUSsCwr34
	In90enO+ohF9uL+uemdHA8BWGJNZYDBNzOe8ij9i1FZpQ1TzrXdIcbGjxPQdFRub1ApYNqP9eps
	uQci+b0FadkX2hjKRcw/HzO9Zz8vkJ/v4wxw+MJHXQGIaUehGq3NKz5QGbyMwQm1vD5DyRBdbWg
	RRpU7aGYR//eGfXkHg2L6+Qtb7EYmJ4LHIojtjeyNGyP3Oxi7a/xiP
X-Received: by 2002:a05:620a:1a9b:b0:8cb:4289:6c1a with SMTP id af79cd13be357-8cbbd05ff45mr585156785a.75.1772120759113;
        Thu, 26 Feb 2026 07:45:59 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf67814bsm272731985a.17.2026.02.26.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:45:58 -0800 (PST)
Date: Thu, 26 Feb 2026 10:45:55 -0500
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
Message-ID: <9dcd02b9-42da-455d-aa08-165e6ff0b921@rowland.harvard.edu>
References: <aZ_lJAqxh_hNGr_v@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ_lJAqxh_hNGr_v@hyeyoo>

On Thu, Feb 26, 2026 at 03:35:08PM +0900, Harry Yoo wrote:
> Hello, SLAB, LKMM, and KCSAN folks!
> 
> I'd like to discuss slab's assumption on users regarding memory ordering.
> 
> Recently, I've been investigating an interesting slab memory ordering
> issue [3] [4] in v7.0-rc1, which made me think about memory ordering
> for slab objects.
> 
> But without answering "What does slab expect users to do for correct
> operation?", I kept getting puzzled, and my brain hurt too much :/
> I'm writing things down to stop getting confused :)
> 
> Since I have never thought about this before, my reasoning could be
> partially or entirely incorrect. If so, please kindly let me know.
> 
> # Slab's assumption: Stores to object, its metadata, or struct slab
> # must be visible to the CPU that frees the object, when it is
> # passed to kfree(). It's users' responsibility to guarantee that.
> 
> When the slab allocator allocates an object, it updates its metadata and
> struct slab fields. After allocation, the user of slab updates object's
> content. As long as the object is freed on the same CPU that it was
> allocated, kfree() can see those stores (A CPU must be able to see
> what's in its store buffer), so no problem!
> 
> However, when e.g.) the pointer to object is stored in a shared variable
> and then freed on a different CPU, things become trickier.
> 
> In this case, I think it's fair for the slab allocator to assume that:
> 
>   1) Such stores must involve _at least_ a release barrier
>      (for example, via {cmp,}xchg{,_release}, or smp_store_release())
>      to ensure preceding stores are visible to other CPUs before
>      the pointer store becomes visible, and
> 
>   2) The CPU that frees an object must invoke at least an acquire
>      barrier to ensure that stores to object content / metadata, etc.,
>      are visible to the freeing CPU when it calls kfree().
> 
> Because the slab allocator itself doesn't guarantee that such
> barriers are invoked within the allocator, it relies on users to
> do this when needed.

It doesn't?  Then how does the slab allocator guarantee that two 
different CPUs won't try to perform allocations or deallocations from 
the same slab at the same time, messing everything up?

Can you explain how this is meant to work, for those of us who don't 
know anything about the slab allocator's internal mechanism?

Alan Stern
