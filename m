From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 14:28:04 -0600
Message-ID: <1260476884.2457.116.camel@mulgrave.site>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57622 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755712AbZLJU2A (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Dec 2009 15:28:00 -0500
In-Reply-To: <20091210224637.cb9712f7.isloginov@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Loginov <isloginov@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 2009-12-10 at 22:46 +0300, Ilya Loginov wrote:
> On Thu, 10 Dec 2009 11:07:31 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > What MTD device is this?  The subsystem is very complex, but I suppose I
> > could trace the read path in a single device to see what the actual
> > problem is.
> 
> Oh! There is a FPGA. There are kernel and diskimage(via slram) in memory.
> So, kernel just copy a part of libc from fs in RAM to RAM.

Right, so this is the problem.  Where you do the ram to ram copy
in-kernel, you need kmap/kunmap.  If you copy from the FPGA RAM to the
kernel RAM, before you do the kunmap, you also need a
flush_kernel_dcache_page().  This (plus implementing
flush_kernel_dcache_page() on mips) will fix all coherency issues.

Which exact driver in drivers/mtd?  I can probably just look at it and
see where the kmap/flush is supposed to be.

James
