From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
	flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 20:39:54 +0000
Message-ID: <20091210203954.GE20884@flint.arm.linux.org.uk>
References: <20091210030638.db4cfd8a.isloginov@gmail.com> <1260404395.14369.68.camel@mulgrave.site> <20091210074020.a7c36c32.isloginov@gmail.com> <1260464851.2457.98.camel@mulgrave.site> <20091210174823.GA20884@flint.arm.linux.org.uk> <1260467956.2457.109.camel@mulgrave.site> <20091210180635.GB20884@flint.arm.linux.org.uk> <1260469255.2457.113.camel@mulgrave.site> <20091210190524.GC20884@flint.arm.linux.org.uk> <1260476999.2457.118.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48252 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757616AbZLJUkH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 15:40:07 -0500
Content-Disposition: inline
In-Reply-To: <1260476999.2457.118.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, Dec 10, 2009 at 02:29:59PM -0600, James Bottomley wrote:
> For 2MB pages, yes, I'd have to agree.
> 
> so the fallback proposal is adding the flush to the kunmap(_atomic) and
> then adding a kunmap_noflush(_atomic) that we convert the already
> flushed architecture cases to using ... is that OK?

Yes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
