From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 14:59:36 -0600
Message-ID: <1260478776.2457.141.camel@mulgrave.site>
References: <1260398346.14369.45.camel@mulgrave.site>
	 <20091210020309.36742c7f.isloginov@gmail.com>
	 <1260400273.14369.52.camel@mulgrave.site>
	 <20091210023609.b8c9bd34.isloginov@gmail.com>
	 <1260402471.14369.60.camel@mulgrave.site>
	 <20091210030638.db4cfd8a.isloginov@gmail.com>
	 <1260404395.14369.68.camel@mulgrave.site>
	 <20091210074020.a7c36c32.isloginov@gmail.com>
	 <1260464851.2457.98.camel@mulgrave.site>
	 <20091210224637.cb9712f7.isloginov@gmail.com>
	 <1260476884.2457.116.camel@mulgrave.site>
	 <20091210234816.5aca535e.isloginov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38119 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755457AbZLJU7e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Dec 2009 15:59:34 -0500
In-Reply-To: <20091210234816.5aca535e.isloginov@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Loginov <isloginov@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 2009-12-10 at 23:48 +0300, Ilya Loginov wrote:
> On Thu, 10 Dec 2009 14:28:04 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > Which exact driver in drivers/mtd?  I can probably just look at it and
> > see where the kmap/flush is supposed to be.
> 
> So, do you think that problem is only in slram driver not in mtd layer 
> in the large?

Yes, you can't copy into a kernel mapping of a user page without
flushing and expect it to succeed in an aliased environment.  This is
the source of your incoherency.  The slram driver is doing a memcpy
between the kernel address it's given and the allocated ram area in
slram_read and slram_write.  To fix mips, you just need a
flush_kernel_dcache_page() in slram_read so that the alias is updated
after the memcpy.  I would also expect this driver not to work on any
highmem system without additional kmap/kunmap(_atomic) pairs in the read
and write routines.

How many other mtd drivers are affected, I'm not sure ... any that do
PIO are wrong ... those that do MMIO should be right (that looks to be
just the omap driver).

James
