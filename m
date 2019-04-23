Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWThr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 15:37:47 -0400
Date: Tue, 23 Apr 2019 16:37:40 -0300
From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
Message-ID: <20190423163740.76b0a9f1@coco.lan>
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
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190423193740.HzwQ5nJSbPA0XD3guxRwAYtxJU23DHajjpPoWCmOSpk@z>

Em Tue, 23 Apr 2019 15:52:26 +0100
David Howells <dhowells@redhat.com> escreveu:

> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > But yes, I have 0 motivation to learn or abide by rst. It simply doesn't
> > > give me anything in return. There is no upside, only worse text files :/  
> > 
> > Right, but these changes aren't meant for our benefit.  They are for
> > users who get cleaner web accessible Linux kernel docs.  Seems the
> > decision has been made that the users' benefit, and broader
> > modernization of Linux docs, outweighs the inconvenience for engineers
> > who maintain the content of said documentation.  
> 
> Whilst I can sympathise with Mauro and Jon - and appreciate the hard work
> they've put into this, I do think that the engineers dealing directly with the
> kernel code should be considered the primary audience.
> 
> There've been some changes that I've particularly objected to, such as
> removing contents lists from files and replacing them with markup like:
> 
> 	.. contents:: :local:

Actually, just:

	.. contents

Is enough. The goal here is just to avoid having two indexes when
generating an html output - and sometimes the internal contents index
is broken - I got one of these during this patch series: a very
confusing internal "contents" that doesn't really match the contents
of the file - probably because some patch changed the contents but
didn't update the internal index.

> 
> This actually impedes use of the file.  It should not be necessary to build
> the docs to get that for ordinary use.

IMHO, replacing:

	Contents

		1. Introduction
		...

By:


	.. Contents

		1. Introduction
		...

won't make the document harder to read as plain text file. With html 
output, the contents will be at both the index.html and at the lateral
bar, so the text "Contents" can be hidden (and that's what the two points
make: it transforms the block into a comment).

> 
> 
> Anyway, the biggest doc issue in the kernel isn't addressed by the conversion
> to ReST: and that is that most people don't seem interested in documenting
> stuff - whether because writing documentation isn't as fun as writing code or
> the fact that English isn't their native language, I don't know.  I can
> sympathise more with the latter.

Yeah, foreign people gets afraid on writing English documents. Yet, my
personal perception is that we end by getting more contributions once
the documents get converted, as more people end reading them and ends
by sending us more contributions.

> Kerneldoc is a start - and probably means that a lot of API functions are at
> least slightly documented - but too many APIs are not mentioned in the
> Documentation directory at all.  Remember: if you can't describe it, it's
> probably wrong!

Fully agreed.

> I'm not sure what we could do about this, but it would probably have to be
> imposed from the top: no more undocumented APIs.  Any new API must come with
> documentation; changes to APIs must include changes to the documentation.

This is a requirement on media: we don't accept for quite a while uAPI
changes without documentation, and we're doing the same for new kAPI
changes (although it is a little more complex to track kAPI changes).
 
> If you really want to upset people, you could add: anyone who wants to alter
> an already existing undocumented API must supply documentation for the whole
> API (but that could be considered a bit cruel).

Well, we may politely request that ;-) If it doesn't work, we can accept
documentation for just the new stuff.

> 
> And anyone who says "But the code is the documentation!" needs to consider
> carefully what happens to their code after it has been trampled, generalised,
> split, combined, renormalised, cthulhuised, janitorised and had parts of it
> migrate.

Yes, on a complex system like the Kernel, having just access to the code
is not enough, as developers don't usually have the time to read the code
for every single function call his code needs to use.

> 
> </rant>
> 
> And now, after that, I think a fresh cup of tea is called for!
> 
> David



Thanks,
Mauro
