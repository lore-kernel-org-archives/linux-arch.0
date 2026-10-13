Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0D5349C5;
	Tue, 13 Oct 2026 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917739; cv=none; b=lDN2VoTHl9O3NAGKEk5TSnIQydzD2uKgJbEb1rUOT+xBsSEcXJVrhil4Adqi782SwpudDmqakq3b7C/T3XO2Iytm2pLNP3cIQQqZNyU1CHvubmxLHqPDAjQaRqsymkVZ0+vwQIKDwRhbXxVFn4tESvOaeVFV25Q8UxQbWHzHA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917739; c=relaxed/simple;
	bh=RU4YgXZngQ4UQhrqQlFB9hI5h3QCAwD9AR7EpHyA/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APKo28GveOStjYg1I1vnKkMEVar2qZYwKu2i4zv3gN5BfP548o+Y99+SxFqzd7wvOad99EXjfYVZJI/7rAbunA2N3oXfEr3PbGmUqt4YPZpcpXbM2/XfimYypSm9xKI9QzuJZCweQKZq9Lc3h6q+9M4XfTsINRW76M/d+2hhj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu0Zp5Ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu0Zp5Ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618851F000FF;
	Tue, 13 Oct 2026 18:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791917738;
	bh=9KBRiB/jxJOo2yUyG8r9joCH90adgDB2oF8tSnxf3J8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=iu0Zp5Ld3288Sk6M4lvRVezLiLvg4KssIKe519xGPXVVmP5qfUAJnwZ0CUlglqViB
	 HLHVhjZxtN8KqRJTPEPaoUBRr/LGLvUXTh4l7kK7uoN+OxlkcuKbZLWuptMt3YKAE/
	 3h3yGxmR3MvD+zD6RwOo8i8fTcpKfaqefiwwcbCL/PEnb2jCfPRuNg3E9wGRZpSq56
	 Z5oI7ycCVKCCNYhK7EKpvmSGtVIAZN6dXo+KKgXjQ/CIeoOqPdA7wWA58InGq2uNoo
	 GBjpc3DRIeEwPWdi6NzBoS0Hv7hDhhPeswryHfuEDhS/zEHVtRUH3Ayvj1btv7VTfQ
	 vjtR/0r5IndxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 191F6CE0877; Tue, 13 Oct 2026 11:55:38 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:55:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>, corbet@lwn.net, mingo@redhat.com,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org, urezki@gmail.com, dave@stgolabs.net,
	lianux.mm@gmail.com, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
	joelagnelf@nvidia.com, skhan@linuxfoundation.org,
	rdunlap@infradead.org, longman@redhat.com, rostedt@goodmis.org,
	qiang.zhang@linux.dev, brads@mainlining.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, linux-doc@vger.kernel.org,
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 08/15] locking/lockdep: use hazptr to wait for
 dynamic key lookups
Message-ID: <397580f0-f07c-4ee1-ab8f-d933c3d7dd9b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-9-kunwu.chan@gmail.com>
 <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local>
 <as4ooZSWA2lAIceu@tardis.local>
 <ef3fd68d-f35e-4071-9523-0cd14396d860@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3fd68d-f35e-4071-9523-0cd14396d860@efficios.com>

On Tue, Oct 13, 2026 at 09:04:50AM -0400, Mathieu Desnoyers wrote:
> On 2026-10-13 08:48, Boqun Feng wrote:
> > On Tue, Oct 13, 2026 at 03:40:36PM +0800, Lai Jiangshan wrote:
> [...]
> > > 
> > > This breaks the forward-progress argument used by the underlying
> > > hazptr implementation: after removing an object from publication,
> > > there should not be a continuing stream of new readers acquiring
> > > that same object. Here, the bucket is never unpublished.
> > > 
> > > For example, let B be the bucket containing key K:
> > > 
> > >    Updater                    Reader                 Scan kthread
> > >    -------                    ------                 ------------
> > >    Unlink K from B
> > >    hazptr_synchronize(B)
> > >                               Acquire B
> > >                                                      Observe B;
> > >                                                      retain waiter
> > >                               Release B
> > >                               Acquire B again
> > >                                                      Observe B;
> > >                                                      retain waiter
> > >                               Release B
> > >                               ...                    ...
> > > 
> > 
> > This is more of an implementation issue,
> I agree with Boqun about the point that this is really an implementation
> issue.
> 
> If we care about forward progress in the scenario of a repeated
> address reuse, we just need to wire up a "0/1" low bit phase tag and
> make hazptr acquire pick it up and set it within its hazptr slot. This
> will ensure forward progress in that scenario. hazptr synchronzie
> would therefore flip this phase between 0 and 1, and check that the
> pointer it's looking for is not set in the other phase, in alternance,
> handling both phases within one synchronize. Indeed, this phase concept
> comes from the realm of RCU implementations.
> 
> I think that the overall mindset so far has been "RCU does this" and
> "Hazard pointers do this" as if those were entirely predefined
> mechanisms. I think the way forward is not "one or the other", but
> rather to combine the strengths of each of those mechanisms into
> something better.

There have been a number of academic attempts to do just that, all of
which ended up providing the worst of both worlds.  Large memory footprint
*and* conditional pointer traversal being the usual suboptimal outcome.  :-(

However, I don't see a problem with use of hazard pointers for static
addresses, at least assuming use of something like the above low-bit
trick to ensure forward progress.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
