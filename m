Return-Path: <BATV+2af8ccde70ad7c28a1d8+5722+infradead.org+mchehab@bombadil.srs.infradead.org>
Date: Wed, 24 Apr 2019 09:57:56 -0300
From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
Message-ID: <20190424095756.73b8981f@coco.lan>
In-Reply-To: <20190424115126.GC6278@rapoport-lnx>
References: <20190423132100.GB7132@redhat.com>
	<cover.1555938375.git.mchehab+samsung@kernel.org>
	<cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
	<20190423083135.GA11158@hirez.programming.kicks-ass.net>
	<20190423125519.GA7104@redhat.com>
	<20190423130132.GT4038@hirez.programming.kicks-ass.net>
	<20704.1556031146@warthog.procyon.org.uk>
	<20190423105415.3a69a0cb@lwn.net>
	<20190423172641.612012c8@coco.lan>
	<20190424115126.GC6278@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190424125756.dhftyLk2hsjoBMBYaYVhFFcM9yVhF_ZjfGegdTWpiBg@z>

Em Wed, 24 Apr 2019 14:51:26 +0300
Mike Rapoport <rppt@linux.ibm.com> escreveu:

> On Tue, Apr 23, 2019 at 05:26:41PM -0300, Mauro Carvalho Chehab wrote:
> > Em Tue, 23 Apr 2019 10:54:15 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> > 
> > > On Tue, 23 Apr 2019 15:52:26 +0100
> > > David Howells <dhowells@redhat.com> wrote:
> > > 
> > > Suggestions / patches on how to improve things for *all* users of the
> > > docs are certainly welcome!
> > > 
> > > I am, incidentally, toying with the idea of trying to put together a
> > > documentation microconf at the Linux Plumbers Conference this year.  If
> > > anybody out there thinks that's a good idea and would like to
> > > participate, please let me know.
> > 
> > If you add a microconf to LPC, I'm in. 
> 
> +1
>  
> > IMO, we made big advances with documentation, but there's a lot more
> > to be done. Having a microconf to discuss those things may help us
> > to bring new ideas about how to keep improving it.
> 
> The most difficult part, IMHO, is to convince people to document things ;-)

As David mentioned, maintainers could enforce merging new APIs
only with documentation, with the risk of being unpopular. 

Well, maintainers are not among the most loved ones anyway ;-)
<sarcasm/>

My experience enforcing it at media subsystem is that it is not
that hard to have developers writing documentation, once it
becomes a rule, and the maintainers give the example.

The big problem is how to deal with legacy stuff. I had to do that
myself for the DVB subsystem, where the documentation were frozen back 
on 2002 days, while lots of new stuff got added (and, worse than that,
with some very obscure ioctls that is used only by a single driver and
some that were used only by OOT drivers). 

It take a few years to put it in sync with the code, but, once the 
ReST conversion was done, it became easier to do the work.

Thanks,
Mauro
