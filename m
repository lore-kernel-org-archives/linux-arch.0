Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4453 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbXFYLLo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 07:11:44 -0400
Date: Mon, 25 Jun 2007 12:09:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on PowerPC and ARM
Message-ID: <20070625110907.GA23438@flint.arm.linux.org.uk>
References: <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org> <20070625103535.GF22063@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070625103535.GF22063@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 25, 2007 at 04:35:35AM -0600, Matthew Wilcox wrote:
> On Mon, Jun 25, 2007 at 02:11:45AM -0700, Andrew Morton wrote:
> > ABI.  How would you like "it would be nice if maintainers of oddball
> > architectures would pay attention"?
> 
> If new syscalls got posted to linux-arch for discussion, I assure you,
> we'd pay attention.

Ditto.  sys_sync_file_range() wasn't, so I think David's sentiment is
bang on.

And as David says, we've _finally_ been round the discussion loop with
fallocate, so in theory we now know what the issues are, and we _all_
have a good idea how to deal with argument ordering to satisfy the
majority.  That should mean that subsequent discussion be shorter.

Also, I find that the accusation that "maintainers of oddball architectures
would pay attention" to be rather insulting.  I've tried to keep abreast
of everything that might possibly affect ARM, but it's utterly impossible
given the amount of what is quite frankly noise and utter drivel.

Thankfully, linux-arch is low noise.  We just need to convince those who
want to add additional syscalls to copy their stuff here, such as that
sys_sync_file_range() patch (http://lwn.net/Articles/177830/)

At least now, if they don't, provided we build every -rc kernel as it's
released, we can detect when new syscalls are added quickly and give
those submitters a suitable roasting at gas mark 95.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
