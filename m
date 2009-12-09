From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Wed, 09 Dec 2009 16:56:49 -0600
Message-ID: <1260399409.14369.46.camel@mulgrave.site>
References: <1260398346.14369.45.camel@mulgrave.site>
	 <20091209224538.GA23365@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34641 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758575AbZLIW4r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 17:56:47 -0500
In-Reply-To: <20091209224538.GA23365@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Wed, 2009-12-09 at 22:45 +0000, Russell King wrote:
> On Wed, Dec 09, 2009 at 04:39:06PM -0600, James Bottomley wrote:
> > Realistically, if I were thinking about the API properly, I'd probably
> > have kunmap flush the kernel view if the dirty bit were set, thus
> > relieving the user of the need to know anything at all about any of
> > this.
> 
> Which dirty bit are you referring to?
> 
> New page cache pages do not have any dirty bit for this.  There is
> PG_arch_1, but this is set by flush_dcache_page on architectures
> playing the delayed-dcache-flush game... so making a call to
> some cache flushing function conditional on it isn't going to work.

Sorry, was thinking of the one in the architecture page tables, not the
one in struct page ... the only reason for checking is that page flush
is an expensive op (at least on parisc) so we really don't want to do it
if the page was never written to.

James
