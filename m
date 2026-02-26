Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3F3290A9;
	Thu, 26 Feb 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131974; cv=none; b=nO10S3Zyd3mGSjGKWy5w1ZfIrwvKy6Pb8fKEZpRurtlNHAg/UspOensfcsalm1KjkJdCLE8xnC3tqSjXBf6aOLBJ1PtL6njqhlBXO5rzQpTSl5p3M5Pl9fOgPHW9CU6D48zvYroceTUteowODvsxjHIeteCoypbtL8l7gnlA4Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131974; c=relaxed/simple;
	bh=+StJ6bSt+9W6TUbjleFHsdNnyzNJCUdR/ufr8IQ3U3U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MYg9pzbKQWqt8lq2klJORI0Bs6tmD6CuXiE3gOmfgmZR4O8eZIIZKUMkaWSWFWpDgDmRCCgfQmtvcIHRf/hlboaPJed02wWBGHH3AXq1/4O4Xk3u4MzRDI0hdWCOcTy20n5OMH0+iPhl74qNHizyxawHl08988wrqxvza3LzMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=efGiM6fL; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="efGiM6fL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1772128766;
	bh=+StJ6bSt+9W6TUbjleFHsdNnyzNJCUdR/ufr8IQ3U3U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=efGiM6fLM8PJs/tFPaYL3iiDbsQuar7zZTJjEZ+Zn8gfukuIHLEP2ob4/BOfCyEC2
	 TUcfQsC80HMu9jT86HJb+XbZ9qixYCcm0FvcKwD38fYtewT7VX01GElPqWhj5XVnO/
	 DBYvusA0Rm/GcMnYRnzCWiVy6LJOCKHRIQBwYHEU=
Received: by gentwo.org (Postfix, from userid 1003)
	id 20350401EB; Thu, 26 Feb 2026 09:59:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1ABB3401AF;
	Thu, 26 Feb 2026 09:59:26 -0800 (PST)
Date: Thu, 26 Feb 2026 09:59:26 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Harry Yoo <harry.yoo@oracle.com>
cc: Alan Stern <stern@rowland.harvard.edu>, linux-mm@kvack.org, 
    Dmitry Vyukov <dvyukov@google.com>, lkmm@lists.linux.dev, 
    linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Joel Fernandes <joelagnelf@nvidia.com>, Daniel Lustig <dlustig@nvidia.com>, 
    Akira Yokosawa <akiyks@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
    Luc Maranget <luc.maranget@inria.fr>, Jade Alglave <j.alglave@ucl.ac.uk>, 
    David Howells <dhowells@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
    Boqun Feng <boqun@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Will Deacon <will@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
    Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
    David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
    Mateusz Guzik <mjguzik@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
    Marco Elver <elver@google.com>
Subject: Re: [BUG] Memory ordering between kmalloc() and kfree()? it's
 confusing!
In-Reply-To: <aaByMLSAIJM8HdbO@hyeyoo>
Message-ID: <6c08b86f-461c-d484-8556-09e53072113f@gentwo.org>
References: <aZ_lJAqxh_hNGr_v@hyeyoo> <9dcd02b9-42da-455d-aa08-165e6ff0b921@rowland.harvard.edu> <aaByMLSAIJM8HdbO@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 27 Feb 2026, Harry Yoo wrote:

> Ah, alloc/free slowpaths do use cmpxchg128 or spinlock and
> don't mess things up.
>
> But fastpath allocs/frees are served from percpu array that is protected
> by a local_lock. local_lock has a compiler barrier in it, but that's
> not enough.

Well if objects are coming from different folios then that is an issue.

The prior slub approach had no per cpu linked lists and restricted
allocations to the objects of a single page that was only used by a
specific cpu. locks were used when that page changed. There was no need
for further synchronization since accesses were known to only refer to a
single page frame and there was only one cpu accessing.

