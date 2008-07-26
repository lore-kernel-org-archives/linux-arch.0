From: Nick Piggin <npiggin@suse.de>
Subject: Re: MMU notifiers review and some proposals
Date: Sat, 26 Jul 2008 05:18:58 +0200
Message-ID: <20080726031858.GB18896@wotan.suse.de>
References: <20080724143949.GB12897@wotan.suse.de> <20080725232907.GA243187@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:45409 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbYGZDTA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Jul 2008 23:19:00 -0400
Content-Disposition: inline
In-Reply-To: <20080725232907.GA243187@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jack Steiner <steiner@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, andrea@qumranet.com, cl@linux-foundation.org

On Fri, Jul 25, 2008 at 06:29:09PM -0500, Jack Steiner wrote:
> > 
> > I also think we should be cautious to make this slowpath so horribly
> > slow. For KVM it's fine, but perhaps for GRU we'd actually want to
> > register quite a lot of notifiers, unregister them, and perhaps even
> > do per-vma registrations if we don't want to slow down other memory
> > management operations too much (eg. if it is otherwise just some
> > regular processes just doing accelerated things with GRU).
> 
> I can't speak for other possible users of the mmu notifier mechanism
> but the GRU will only register a single notifier for a process.
> The notifier is registered when the GRU is opened and (currently)
> unregistered when the GRU is closed.
> 
> If a task opens multiple GRUs (quite possible for threaded apps), all
> shared the same notifier. Regardless of the number of threads/opens,
> there will be a single notifier. 

OK, sure, but you might have a lot of processes opening the GRU, no?
(I'm not sure how it is exactly going to be used, but if you have a
number of GRU units per blade...)

So you have a machine with 4096 CPUs, and maybe 4096 processes that
each have to lock the mapping of exec, glibc, pthreads, grulib, etc
etc.

Or you might have a situation where many short lived processes do
some operating on GRU.

Anyway, I won't dispute your data point (thanks for that), but still
noting that a very heavy registration is obviously less desirable
than a faster one, all else being equal...
