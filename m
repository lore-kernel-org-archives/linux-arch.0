From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Wed, 09 Dec 2009 13:21:42 +0100
Message-ID: <1260361302.5489.372.camel@laptop>
References: <20091208060701.GM14381@ZenIV.linux.org.uk>
	 <Pine.LNX.4.64.0912081142280.31223@sister.anvils>
	 <Pine.LNX.4.64.0912081254500.3365@sister.anvils>
	 <20091208.130802.25121122.davem@davemloft.net>
	 <20091208220638.GN14381@ZenIV.linux.org.uk>
	 <Pine.LNX.4.64.0912091041250.23659@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755417AbZLIMVu@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0912091041250.23659@sister.anvils>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, David Miller <davem@davemloft.net>, Ollie Wild <aaw@google.com>, Rik van Riel <riel@redhat.com>, viro@ftp.linux.org.uk, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-12-09 at 11:43 +0000, Hugh Dickins wrote:

> On Tue, 8 Dec 2009, Al Viro wrote:
> > On Tue, Dec 08, 2009 at 01:08:02PM -0800, David Miller wrote:
> > > From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> > > Date: Tue, 8 Dec 2009 13:03:30 +0000 (GMT)

> Would it make sense to build up argv and env of execee on the execer's
> user stack (below user's sp ("below" assuming topdown stack))?

> > > 
> > > > That would impose some (unacceptable?) limits, and require some funny
> > > > code to migrate the pages over to the new mm later (instead of
> > > > relocating within the new mm as we do now).
> > > 
> > > I think this approach would create new failure cases that don't exist
> > > now.  Whether that's acceptable or not is another issue.
> 
> David: Yes, that's one of my fears too - I don't think
> rlimits would pose any new problem, but building up the argv+env below
> sp on the execer's userstack would be in danger of colliding with the
> vma below if the space allowed to that userstack is too small.  We can
> say "sorry, you left too little space for your userstack", but it's
> still a regression.  My other big fear is this: that it's such a simple
> and obvious way to do it, that it has probably been ruled out for very
> good reasons in the past.

Vague memories, but here goes..

/me ponders.. doesn't the binfmt engine cruft need the args in place in
order to execute?

That is, IIRC the problem is that you need to have the argc/env in place
for the binfmt engine thing, and need to have ran the binfmt engine
thing before you know the personality.

As to your idea, if that were feasible we could do without the copy and
simply steal the pages directly from the old mm.
