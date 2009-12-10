From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Fri, 11 Dec 2009 01:33:19 +0300
Message-ID: <20091211013319.c2148b9d.isloginov@gmail.com>
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
	<1260478776.2457.141.camel@mulgrave.site>
	<20091211002700.0600d327.isloginov@gmail.com>
	<1260482418.2457.208.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60041 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761248AbZLJWdR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 17:33:17 -0500
Received: by ewy19 with SMTP id 19so390404ewy.21
        for <linux-arch@vger.kernel.org>; Thu, 10 Dec 2009 14:33:22 -0800 (PST)
In-Reply-To: <1260482418.2457.208.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 10 Dec 2009 16:00:18 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:


> Actually, I think only sparc and mips need it.

How I can know this exactly?

> It's only needed for an
> aliasing architecture.  Next, it's only used for pio drivers, so if the
> platform never uses a pio driver, it can get away without having this
> (that's the sparc case, I think).

> Unfortunately, you can't do it at the bio level.  The reason is the
> kmap/kunmap.  On a highmem system the mapping disappears after kunmap,
> so you have to flush before you lose the mapping ... that means right in
> the guts of the driver where it's doing the kmap/copy/kunmap.
> 
> Sounds like aio does have the issue, yes.  If you grep the kernel for
> flush_kernel_dcache_pages(), you'll see that a lot of PIO drivers are
> already using this, so there's not a lot of conversion to be done.

I will write my seeing of current stage. Please correct me.

All mtd drivers and aio works correctly(about flushes). But there is a
lot of waste work on some architecrures (PA-RISC as example). It is bad.

We want to add flush_kernel_dcache_page() in MIPS(and may be SPARC and
other archs) and call it after kunmap in slram driver(and in aio may be).
So, we will fix the specific bug and, may be, bugs in other drivers which
use flush_kernel_dcache_page which(bugs) have not been founded yet. But
bugs in mtd may be will remain.

-- 
Ilya Loginov <isloginov@gmail.com>
