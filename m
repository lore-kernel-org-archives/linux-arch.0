From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 03:06:38 +0300
Message-ID: <20091210030638.db4cfd8a.isloginov@gmail.com>
References: <1260398346.14369.45.camel@mulgrave.site>
	<20091210020309.36742c7f.isloginov@gmail.com>
	<1260400273.14369.52.camel@mulgrave.site>
	<20091210023609.b8c9bd34.isloginov@gmail.com>
	<1260402471.14369.60.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:43257 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758856AbZLJAGf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 19:06:35 -0500
Received: by ewy1 with SMTP id 1so5045997ewy.28
        for <linux-arch@vger.kernel.org>; Wed, 09 Dec 2009 16:06:40 -0800 (PST)
In-Reply-To: <1260402471.14369.60.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Wed, 09 Dec 2009 17:47:51 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> Which architecture is this? ... because if it's missing a necessary
> definition for flush_kernel_dcache_page() it's very easy to add it ...

This is a MIPS. Why? The call flush_dcache_page() on MIPS is lazy enought.
And it do exactly what i need to fix the problem.

> > But. I could do that rq_flush_dcache_pages will call flush_kernel_dcache_page
> > for architectures where ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE was defined.
> 
> The point I'm trying to make is that flush_dcache_page() does a lot of
> unnecessary flushing.  Where you are in the system with the READ call,
> you know the user aliases are clean (because users aren't allowed to
> touch pages submitted for write), so you only (for efficiency) need to
> flush the dirty kernel alias.

I understand that in your case(parisc) solution with flushdcache_page()
is very voracious. But I don't think that we should change something
somewhere else except parisc. Or we should write to Ralf Baechle and
other maintainers and discuss all with them. Don't think?

-- 
Ilya Loginov <isloginov@gmail.com>
