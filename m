From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Wed, 9 Dec 2009 13:12:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0912091242010.26035@sister.anvils>
References: <20091208060701.GM14381@ZenIV.linux.org.uk>
 <Pine.LNX.4.64.0912081142280.31223@sister.anvils>
 <Pine.LNX.4.64.0912081254500.3365@sister.anvils>  <20091208.130802.25121122.davem@davemloft.net>
  <20091208220638.GN14381@ZenIV.linux.org.uk>  <Pine.LNX.4.64.0912091041250.23659@sister.anvils>
 <1260361302.5489.372.camel@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mk-filter-4-a-1.mail.uk.tiscali.com ([212.74.100.55]:42535 "EHLO
	mk-filter-4-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755439AbZLINMj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 08:12:39 -0500
In-Reply-To: <1260361302.5489.372.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, David Miller <davem@davemloft.net>, Ollie Wild <aaw@google.com>, Rik van Riel <riel@redhat.com>, viro@ftp.linux.org.uk, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, 9 Dec 2009, Peter Zijlstra wrote:
> On Wed, 2009-12-09 at 11:43 +0000, Hugh Dickins wrote:
> > 
> > David: Yes, that's one of my fears too - I don't think
> > rlimits would pose any new problem, but building up the argv+env below
> > sp on the execer's userstack would be in danger of colliding with the
> > vma below if the space allowed to that userstack is too small.  We can
> > say "sorry, you left too little space for your userstack", but it's
> > still a regression.  My other big fear is this: that it's such a simple
> > and obvious way to do it, that it has probably been ruled out for very
> > good reasons in the past.
> 
> Vague memories, but here goes..

Thanks!

> 
> /me ponders.. doesn't the binfmt engine cruft need the args in place in
> order to execute?

Hardly looked, Al will be more up to date with all the grisly details.

The "binfmt engine cruft" being search_binary_handler()?  I think the
args have to be "ready to go" before that, but that's different from
the new mm actually being used as an mm before that.  It used not to
be used early, but from 2.6.23 on it is used early, via get_user_pages.

> 
> That is, IIRC the problem is that you need to have the argc/env in place
> for the binfmt engine thing, and need to have ran the binfmt engine
> thing before you know the personality.

It is a problem that personality is discovered late in the sequence,
and that is a considerable part of what Al is up against.

> 
> As to your idea, if that were feasible we could do without the copy and
> simply steal the pages directly from the old mm.

Perhaps, but I think that would lead to a gradual accumulation
of more and more pages pinned in memory by scattered references.

I Cc'ed you really because I wasn't much involved in the variable
length arg discussions, and don't remember how important swappability
was viewed at the time.  It is a significant feature of what you and
Ollie ended up with, so I'm guessing it was then viewed as essential.
That would be my view.

But now it's suggested that the TLB+cache effects of using an mm there
are counter-productive, and better to forget swappability: well, I want
to keep it, and Al is making a brave effort to hold on to it, but I'm
wary of the weirdness involved.

Hugh
