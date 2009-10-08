Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54892 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbZJHQ0O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2009 12:26:14 -0400
Subject: Re: [RFC][PATCH] kmap_atomic_push
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20091008155344.GA11727@elte.hu>
References: <1255016123.17055.17.camel@laptop>
	 <20091008155344.GA11727@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Oct 2009 18:29:22 +0200
Message-ID: <1255019362.26976.311.camel@twins>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Avi Kivity <avi@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "hugh.dickins" <hugh.dickins@tiscali.co.uk>, David Howells <dhowells@redhat.com>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20091008162922.c4asxBKO8JCZRRZxTzny9RpwSUYiCI-HCH0ssWLQOVU@z>

On Thu, 2009-10-08 at 17:53 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > The below patchlet changes the kmap_atomic interface to a stack based 
> > one that doesn't require the KM_types anymore.
> > 
> > This significantly simplifies some code (more still than are present 
> > in this patch -- ie. pte_map_nested can go now)
> > 
> > This obviously requires that push and pop are matched, I fixed a few 
> > cases that were not properly nested, the (x86) code checks for this 
> > and will go BUG when trying to pop a vaddr that isn't the top one so 
> > abusers should be rather visible.
> 
> Looks great IMO! Last i proposed this i think either Andrew or Avi had 
> second thoughts about the hard-to-calculate worst-case mapping limit - 
> but i dont think that's a big issue.

That would've been me ;-)

> Lets not change the API names though - the rule is that map/unmap must 
> be properly nested.

Right, so I did that full rename just so that people wouldn't get
confused or something, but if both you and Linus think it should remain:
kmap_atomic() and kunmap_atomic(), I can certainly undo that part.


