From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 22:46:37 +0300
Message-ID: <20091210224637.cb9712f7.isloginov@gmail.com>
References: <1260398346.14369.45.camel@mulgrave.site>
	<20091210020309.36742c7f.isloginov@gmail.com>
	<1260400273.14369.52.camel@mulgrave.site>
	<20091210023609.b8c9bd34.isloginov@gmail.com>
	<1260402471.14369.60.camel@mulgrave.site>
	<20091210030638.db4cfd8a.isloginov@gmail.com>
	<1260404395.14369.68.camel@mulgrave.site>
	<20091210074020.a7c36c32.isloginov@gmail.com>
	<1260464851.2457.98.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:2616 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761571AbZLJTqe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 14:46:34 -0500
Received: by ey-out-2122.google.com with SMTP id d26so124340eyd.19
        for <linux-arch@vger.kernel.org>; Thu, 10 Dec 2009 11:46:40 -0800 (PST)
In-Reply-To: <1260464851.2457.98.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 10 Dec 2009 11:07:31 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> What MTD device is this?  The subsystem is very complex, but I suppose I
> could trace the read path in a single device to see what the actual
> problem is.

Oh! There is a FPGA. There are kernel and diskimage(via slram) in memory.
So, kernel just copy a part of libc from fs in RAM to RAM.

-- 
Ilya Loginov <isloginov@gmail.com>
