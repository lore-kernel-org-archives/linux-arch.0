From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 22:42:37 +0300
Message-ID: <20091210224237.a1548bf9.isloginov@gmail.com>
References: <20091210020309.36742c7f.isloginov@gmail.com>
	<1260400273.14369.52.camel@mulgrave.site>
	<20091210023609.b8c9bd34.isloginov@gmail.com>
	<1260402471.14369.60.camel@mulgrave.site>
	<20091210030638.db4cfd8a.isloginov@gmail.com>
	<1260404395.14369.68.camel@mulgrave.site>
	<20091210074020.a7c36c32.isloginov@gmail.com>
	<1260464851.2457.98.camel@mulgrave.site>
	<20091210174823.GA20884@flint.arm.linux.org.uk>
	<1260467956.2457.109.camel@mulgrave.site>
	<20091210180635.GB20884@flint.arm.linux.org.uk>
	<1260469255.2457.113.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:61189 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761560AbZLJTmi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 14:42:38 -0500
Received: by ewy19 with SMTP id 19so220301ewy.21
        for <linux-arch@vger.kernel.org>; Thu, 10 Dec 2009 11:42:41 -0800 (PST)
In-Reply-To: <1260469255.2457.113.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 10 Dec 2009 12:20:55 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> I'm not religiously opposed to the separation into a flush and a non
> flush case ... although I think if we have to do this, it's equivalent
> to just forcing users to add the flush_kernel_dcache_page() ... but if
> we can do it so that the users don't need to know the details, I think
> the API is much better.

I wrote that flush_kernel_dcache_page() was exist only in parisc(and sh).
There is flush_dcache_page() in other architectures. And I don't think,
that flush_kernel_dcache_page() should be introduced into other
architectures. Actually, I don't know a lot about many architectures.

So, may be. We should have a varian of rq_flush... call for architectures
where ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE was defined. I wrote this before.
And I continue to think such manner since I've read about ARM.

-- 
Ilya Loginov <isloginov@gmail.com>
