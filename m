Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbXGYOkY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 10:40:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070725113407.GG29011@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de>
Subject: Re: [patch 1/7] bitops: introduce lock bitops
Date: Wed, 25 Jul 2007 15:40:13 +0100
Message-ID: <27432.1185374413@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <npiggin@suse.de> wrote:

> I'd like to get the new lock bitop primitives in if possible. Maybe it
> is too late for 2.6.23, but at least if I can queue them up in -mm?
> 
> They are pretty simple, but at least the page lock and buffer lock
> conversions touch quite a lot of code. Not sure how to really do this
> better to reduce merge difficulties.

I like the way we can get away with a memory barrier before calling
clear_bit() and not have one after.

This works fine on FRV.

Now all you need to do is add the kerneldoc comments...  Contingent on that:

Acked-By: David Howells <dhowells@redhat.com>
