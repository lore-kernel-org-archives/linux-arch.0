Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:54714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751224AbWCWGX4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Mar 2006 01:23:56 -0500
Date: Wed, 22 Mar 2006 22:20:27 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: Potential problem with the page_mapping macro and
 flush_dcache_page()
Message-Id: <20060322222027.4615e245.akpm@osdl.org>
In-Reply-To: <1142803783.3240.64.camel@mulgrave.il.steeleye.com>
References: <1142801589.3240.51.camel@mulgrave.il.steeleye.com>
	<20060319.130009.102283514.davem@davemloft.net>
	<1142802286.3240.54.camel@mulgrave.il.steeleye.com>
	<20060319.132511.116548328.davem@davemloft.net>
	<1142803783.3240.64.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> > > OK, I confess to not ever having looked at that ... does it use
>  > > get_user_pages() as well?
>  > 
>  > I believe so, Andrew knows...
> 
>  OK I'll wait to see what he says.

<he'd made some procmailrc changes and had thought that linux-arch was
rather quiet lately>

Yes, direct-io does get_user_pages() and then uses submit_bio() to
read/write the pages.

So it should fall under

 2) device DMA, where the L2 cache eviction done by the device DMA
    will pull out the D-cache entries, or if the block I/O is via PIO
    it will do cache flushing in there, as per some asm-*/ide.h
    implementations of __ide_ins*()/__ide_outs*()

umm, except in the case where direct-io hit a file hole.  In that case we
memset the user's page and use flush_dcache_page().  And that's most likely
an anonymous page.
