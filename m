Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49021 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753206AbYAMEp2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 12 Jan 2008 23:45:28 -0500
Date: Sat, 12 Jan 2008 20:45:06 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
In-Reply-To: <20080113043922.GA22345@wotan.suse.de>
Message-ID: <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org



On Sun, 13 Jan 2008, Nick Piggin wrote:
> On Sat, Jan 12, 2008 at 07:41:16PM -0800, Linus Torvalds wrote:
> > 
> > What's the point of this?
> 
> Well, it's written in the changelog.

No it's not.

It says "Rather than play interesting games with vmas..", but:

 - it doesn't say why the new model is any better

 - and the source code *still* has to play all the same interestign games 
   anyway due to s390 (and possibly others) that cannot play the *new* 
   interesting games.

So I repeat: what's the _point_.

> > That's lots of new (ugly) code, and two totally different paths, that 
> > aren't even cleanly abstracted, so now there's two separate things that 
> > are just arbitrarily selected by an #ifdef.
> 
> How should it be cleanly abstracted?

I don't think it can, since you have to leave the old code anyway.

Which just returns me to the original question: what's the actual 
improvement here?

		Linus
