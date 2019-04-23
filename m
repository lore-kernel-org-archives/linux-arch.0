Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:48464 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfDWQyW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Apr 2019 12:54:22 -0400
Date: Tue, 23 Apr 2019 10:54:15 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
Message-ID: <20190423105415.3a69a0cb@lwn.net>
In-Reply-To: <20704.1556031146@warthog.procyon.org.uk>
References: <20190423132100.GB7132@redhat.com>
        <cover.1555938375.git.mchehab+samsung@kernel.org>
        <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
        <20190423083135.GA11158@hirez.programming.kicks-ass.net>
        <20190423125519.GA7104@redhat.com>
        <20190423130132.GT4038@hirez.programming.kicks-ass.net>
        <20704.1556031146@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190423165415.xl77LuZ_3jvXpL0ZZFXwDpNPQY8CkZGrlV3CLw7aqMk@z>

On Tue, 23 Apr 2019 15:52:26 +0100
David Howells <dhowells@redhat.com> wrote:

> There've been some changes that I've particularly objected to, such as
> removing contents lists from files and replacing them with markup like:
> 
> 	.. contents:: :local:
> 
> This actually impedes use of the file.  It should not be necessary to build
> the docs to get that for ordinary use.

Usability of the text files versus that of the built docs is occasionally
something that has to be traded off.  As a general rule, I want the text
files to remain useful on their own.  There is a lot of value in the
built docs for a lot of people, but that should not be the only, or even
the primary, form of access

Tables of contents are certainly a place where that tradeoff makes itself
felt.  Doing them by hand ensures that they are always present, but
requires that people editing the docs also maintain the TOCS - something
that experience has shown tends not to happen.  That's more of a pain
than a little bit of markup, and people don't do it.  An automatically
generated TOC, instead, is always correct and is linkable.

Few people complain about the biggest impediment to the readability of
text files, though: the use of kerneldoc comments.  That splits the
information between the text file and multiple random-seeming locations
among tends of thousands of source files.  Sometimes the solution here is
to move all of the documentation into the source, but that tends to
fragment it and make it harder to find; it's certainly not the right
place for many kinds of docs.  In general, it's hard to create a coherent
story that way.

Suggestions / patches on how to improve things for *all* users of the
docs are certainly welcome!

I am, incidentally, toying with the idea of trying to put together a
documentation microconf at the Linux Plumbers Conference this year.  If
anybody out there thinks that's a good idea and would like to
participate, please let me know.

> Anyway, the biggest doc issue in the kernel isn't addressed by the conversion
> to ReST: and that is that most people don't seem interested in documenting
> stuff - whether because writing documentation isn't as fun as writing code or
> the fact that English isn't their native language, I don't know.  I can
> sympathise more with the latter.

I believe there's enough experience now to say that using RST increases
contributions to the documentation.  Just having something that approaches
a coherent approach to docs (though we are a *long* way from that still)
makes the whole thing more accessible.  It doesn't solve our
documentation issues by any stretch, but it helps.

Thanks,

jon
