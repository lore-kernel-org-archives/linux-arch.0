Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43569 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbYAMFGH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Jan 2008 00:06:07 -0500
Date: Sun, 13 Jan 2008 06:06:05 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Message-ID: <20080113050605.GA1340@wotan.suse.de>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

On Sat, Jan 12, 2008 at 08:45:06PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 13 Jan 2008, Nick Piggin wrote:
> > On Sat, Jan 12, 2008 at 07:41:16PM -0800, Linus Torvalds wrote:
> > > 
> > > What's the point of this?
> > 
> > Well, it's written in the changelog.
> 
> No it's not.
> 
> It says "Rather than play interesting games with vmas..", but:

OK, you have to read to the 3rd paragraph.


> > > That's lots of new (ugly) code, and two totally different paths, that 
> > > aren't even cleanly abstracted, so now there's two separate things that 
> > > are just arbitrarily selected by an #ifdef.
> > 
> > How should it be cleanly abstracted?
> 
> I don't think it can, since you have to leave the old code anyway.

I don't think having 2 code paths means it is a bad abstraction at
all. We do things like that everywhere, what makes you say this is
bad?

My implementation is a bit crude maybe. You could have another arch
call so you write it with an if() instead of an ifdef I guess.

 
> Which just returns me to the original question: what's the actual 
> improvement here?

Well the immediate improvement from this actual patch is just that
it gives better and smaller code for vm_normal_page (even if you
discount the debug checks in the existing code).

But for example, s390 perhaps cannot implement VM_MIXEDMAP using
pfn_valid() like we have in vm_normal_page. The alternative is basically
to have a different path for those guys anyway, so why not make it a
"core" code thing rather than s390 specific.

So. Is there a big problem with adding this extra path? It's really quite
simple, literally just
       if (likely(!pte_special(pte)))
               return pte_page(pte);
       return NULL;

So I don't think maintainability is a problem.
