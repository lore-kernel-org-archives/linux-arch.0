From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] tools: memory-model: add it to the Documentation body
Date: Wed, 31 Jul 2019 09:52:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org>
References: <20190730195744.3aef478e@coco.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730195744.3aef478e@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 30 Jul 2019, Mauro Carvalho Chehab wrote:

> Em Tue, 30 Jul 2019 18:17:01 -0400
> Joel Fernandes <joel@joelfernandes.org> escreveu:

> > > > (4) I would argue that every occurence of
> > > > A ->(some dependency) B should be replaced with fixed size font in the HTML
> > > > results.  
> > > 
> > > Just place those with ``A -> (some dependency)``. This will make them use
> > > a fixed size font.  
> > 
> > Ok, understood all these. I guess my point was all of these will need to be
> > done to make this document useful from a ReST conversion standpoint. Until
> > then it is probably just better off being plain text - since there are so
> > many of those ``A -> (dep) B`` things.

> On a very quick look, it seems that, if we replace:
> 
> 	(\S+\s->\S*\s\w+)
> 
> by:
> 	``\1``
> 
> 
> On an editor that would allow to manually replace the regex (like kate),
> most of those can be get.
> 
> See patch enclosed.

Some time ago I considered the problem of converting this file to ReST 
format.  But I gave up on the idea, because the necessary changes were 
so widespread and the resulting text file would not be easily readable.

Replacing things of the form "A ->dep B" just scratches the surface.  
That document teems with variable names, formulas, code extracts, and
other things which would all need to be rendered in a different font
style.  The density of the markup required to do this would be
phenomenally high.

In my opinion it simply was not worthwhile.

Alan Stern
