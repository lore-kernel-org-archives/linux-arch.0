Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDWU0r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 16:26:47 -0400
Date: Tue, 23 Apr 2019 17:26:41 -0300
From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
Message-ID: <20190423172641.612012c8@coco.lan>
In-Reply-To: <20190423105415.3a69a0cb@lwn.net>
References: <20190423132100.GB7132@redhat.com>
        <cover.1555938375.git.mchehab+samsung@kernel.org>
        <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
        <20190423083135.GA11158@hirez.programming.kicks-ass.net>
        <20190423125519.GA7104@redhat.com>
        <20190423130132.GT4038@hirez.programming.kicks-ass.net>
        <20704.1556031146@warthog.procyon.org.uk>
        <20190423105415.3a69a0cb@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: David Howells <dhowells@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190423202641.Oxued7jp4GwOU-FCyUdLNDWQ2XVmzAQW30Vz11zOFyE@z>

Em Tue, 23 Apr 2019 10:54:15 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 23 Apr 2019 15:52:26 +0100
> David Howells <dhowells@redhat.com> wrote:
> 
> > There've been some changes that I've particularly objected to, such as
> > removing contents lists from files and replacing them with markup like:
> > 
> > 	.. contents:: :local:
> > 
> > This actually impedes use of the file.  It should not be necessary to build
> > the docs to get that for ordinary use.  
> 
> Usability of the text files versus that of the built docs is occasionally
> something that has to be traded off.  As a general rule, I want the text
> files to remain useful on their own.  There is a lot of value in the
> built docs for a lot of people, but that should not be the only, or even
> the primary, form of access
> 
> Tables of contents are certainly a place where that tradeoff makes itself
> felt.  Doing them by hand ensures that they are always present, but
> requires that people editing the docs also maintain the TOCS - something
> that experience has shown tends not to happen.  That's more of a pain
> than a little bit of markup, and people don't do it.  An automatically
> generated TOC, instead, is always correct and is linkable.
> 
> Few people complain about the biggest impediment to the readability of
> text files, though: the use of kerneldoc comments.  That splits the
> information between the text file and multiple random-seeming locations
> among tends of thousands of source files.  Sometimes the solution here is
> to move all of the documentation into the source, but that tends to
> fragment it and make it harder to find; it's certainly not the right
> place for many kinds of docs.  In general, it's hard to create a coherent
> story that way.
> 
> Suggestions / patches on how to improve things for *all* users of the
> docs are certainly welcome!
> 
> I am, incidentally, toying with the idea of trying to put together a
> documentation microconf at the Linux Plumbers Conference this year.  If
> anybody out there thinks that's a good idea and would like to
> participate, please let me know.

If you add a microconf to LPC, I'm in. 

IMO, we made big advances with documentation, but there's a lot more
to be done. Having a microconf to discuss those things may help us
to bring new ideas about how to keep improving it.

Thanks,
Mauro
