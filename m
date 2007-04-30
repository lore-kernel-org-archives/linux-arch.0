Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dhazelton.dsl.enter.net ([216.193.185.50]:50719 "EHLO mail"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1946623AbXD3SwJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Apr 2007 14:52:09 -0400
From: Daniel Hazelton <dhazelton@enter.net>
Subject: Re: condingstyle, was Re: utrace comments
Date: Mon, 30 Apr 2007 14:39:23 -0400
References: <20061127165138.GA2991@lst.de> <20070430091121.GC31397@infradead.org> <20070430100917.439ebfc8.akpm@linux-foundation.org>
In-Reply-To: <20070430100917.439ebfc8.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704301439.23561.dhazelton@enter.net>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 30 April 2007 13:09:17 Andrew Morton wrote:
> On Mon, 30 Apr 2007 10:11:21 +0100 Christoph Hellwig <hch@infradead.org> 
wrote:
> > I've separated this out under a new subject because some style issues
> > that so far aren't documented explicitly are in doubt here, and Roland
> > wants and Answer from Andrew.
> >
> > We also should put clauses on this into CodingStyle.
> >
> > On Sun, Apr 29, 2007 at 09:02:13PM -0700, Roland McGrath wrote:
> > > > 	The coding style here is wrong.  The else should be on the line
> > > > 	of the closing brace.
> > >
> > > I can ordinarily ignore syntax, but this is an abomination in the sight
> > > of the Lord and always will be.  Fortunately, it's far from being 100%
> > > consistently used in the kernel already.  People are welcome to change
> > > the code after I submit it, but I just can't make myself write it that
> > > way, sorry.
>
> I'm a bit lost here.  Are we referring to
>
> 	if (expr) {
> 		...
> 	} else {
> 		...
> 	}
>
> versus
>
> 	if (expr) {
> 		...
> 	}
> 	else {
> 		...
> 	}
>
> ?

For some strange reason I have a feeling its the former. I remember that one 
of the "Rules of Style" that are pushed by a lot of people is to "Uncuddle 
the Else".

I prefer the '} else {'  style - for the same reason that I prefer the 
'float logf(float x) {' style for functions and similar (where it doesn't go 
beyond 80 columns) in my own code. The reason is that I like trying to keep 
the number of lines with no code on them minimal - helps me to look at the 
output of wc -l to find files where I might have been overly verbose with the 
code and/or comments.

DRH


