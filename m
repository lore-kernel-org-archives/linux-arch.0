Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43330 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbXGZAom (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 20:44:42 -0400
Date: Thu, 26 Jul 2007 02:44:41 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/7] bitops: introduce lock bitops
Message-ID: <20070726004441.GA20727@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de> <27432.1185374413@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27432.1185374413@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jul 25, 2007 at 03:40:13PM +0100, David Howells wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > I'd like to get the new lock bitop primitives in if possible. Maybe it
> > is too late for 2.6.23, but at least if I can queue them up in -mm?
> > 
> > They are pretty simple, but at least the page lock and buffer lock
> > conversions touch quite a lot of code. Not sure how to really do this
> > better to reduce merge difficulties.
> 
> I like the way we can get away with a memory barrier before calling
> clear_bit() and not have one after.
> 
> This works fine on FRV.
> 
> Now all you need to do is add the kerneldoc comments...  Contingent on that:
> 
> Acked-By: David Howells <dhowells@redhat.com>

Thanks, I can add a little something...

