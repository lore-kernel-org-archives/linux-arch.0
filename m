From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 23:41:18 +0300
Message-ID: <20091210234118.cb699264.isloginov@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48554 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096AbZLJUlQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 15:41:16 -0500
Received: by ewy19 with SMTP id 19so278545ewy.21
        for <linux-arch@vger.kernel.org>; Thu, 10 Dec 2009 12:41:22 -0800 (PST)
In-Reply-To: <1260476884.2457.116.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 10 Dec 2009 14:28:04 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > diskimage(via slram) in memory.

> Which exact driver in drivers/mtd?  I can probably just look at it and
> see where the kmap/flush is supposed to be.

I think that this is the right driver.
drivers/mtd/devices/slram.c

-- 
Ilya Loginov <isloginov@gmail.com>
