Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:60727 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755212AbXAAOlJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jan 2007 09:41:09 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org>
References: <20061221152621.GB3958@flint.arm.linux.org.uk>
	 <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu>
	 <20061221171739.GE3958@flint.arm.linux.org.uk>
	 <20061230163955.GA12622@flint.arm.linux.org.uk>
	 <20061230165012.GB12622@flint.arm.linux.org.uk>
	 <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 09:35:17 -0500
Message-Id: <1167662118.5302.52.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2006-12-30 at 10:26 -0800, Linus Torvalds wrote:
> 
> On Sat, 30 Dec 2006, Russell King wrote:
> > 
> > And here's the flush_anon_page() part.

This looks fine to me (if you need my ack).

> > Add flush_anon_page() for ARM, to avoid data corruption issues when using
> > fuse or other subsystems using get_user_pages().
> 
> Btw, since this doesn't actually change any code for anybody but ARM, just 
> adds a parameter that is obviously unused by everybody else, and if it 
> actually fixes a real bug for ARM, I'll obviously happily take it even 
> before 2.6.20. So go ahead put it in your ARM tree, and we'll get some 
> testing through that. And just ask me to pull at some point.
> 
> I wonder why nobody else seems to have a "flush_anon_page()"? This would 
> seem to be a potential issue for architectures like sparc too.. Although 
> maybe sparc can do a flush by physical index with "flush_dcache_page()".

The sparc handling of anonymous pages is different ... they accitentally
sweep them up in flush_dcache_page().  When I audited the architectures
to try to make fuse work on parisc, parisc and arm were the only ones
that actually needed flush_anon_page().

James


