Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:33043 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440AbXHXLYO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Aug 2007 07:24:14 -0400
Date: Fri, 24 Aug 2007 13:24:13 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc] vmalloc: lazy, batched vunmapping
Message-ID: <20070824112413.GB12412@wotan.suse.de>
References: <20070824032646.GE6989@wotan.suse.de> <14030.1187945965@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14030.1187945965@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Aug 24, 2007 at 09:59:25AM +0100, David Howells wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > I'm working on a bit of code that vmaps/vunmaps a bit more often than
> > I'd like. I've implemented a frontend to cache commonly used mappings,
> > which solves most of the problem, but in looking various other ways to
> > get the last bit of performance, I thought might be generally helpful
> > to batch up vunmap driven TLB flushes. So I'll just throw the idea
> > out there (is anyone else doing a lot of vmapping? I'd like to hear
> > from you!).
> 
> Can the OOM handler force a purge?

You could, it would be just one function call from a process context.
I didn't really bother at this stage, because it's just a couple of K
of physical memory really -- the virtual space purge is obviously the
critical thing.

