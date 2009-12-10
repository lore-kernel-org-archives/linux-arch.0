From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
	flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 19:43:48 +0000
Message-ID: <20091210194348.GD20884@flint.arm.linux.org.uk>
References: <1260402471.14369.60.camel@mulgrave.site> <20091210030638.db4cfd8a.isloginov@gmail.com> <1260404395.14369.68.camel@mulgrave.site> <20091210074020.a7c36c32.isloginov@gmail.com> <1260464851.2457.98.camel@mulgrave.site> <20091210174823.GA20884@flint.arm.linux.org.uk> <1260467956.2457.109.camel@mulgrave.site> <20091210180635.GB20884@flint.arm.linux.org.uk> <1260469255.2457.113.camel@mulgrave.site> <20091210224237.a1548bf9.isloginov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54134 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761435AbZLJToA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 14:44:00 -0500
Content-Disposition: inline
In-Reply-To: <20091210224237.a1548bf9.isloginov@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Loginov <isloginov@gmail.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, Dec 10, 2009 at 10:42:37PM +0300, Ilya Loginov wrote:
> On Thu, 10 Dec 2009 12:20:55 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > I'm not religiously opposed to the separation into a flush and a non
> > flush case ... although I think if we have to do this, it's equivalent
> > to just forcing users to add the flush_kernel_dcache_page() ... but if
> > we can do it so that the users don't need to know the details, I think
> > the API is much better.
> 
> I wrote that flush_kernel_dcache_page() was exist only in parisc(and sh).

and ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
