From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
	flush_dcache_page() against a bio and a request's pages)
Date: Wed, 9 Dec 2009 22:45:38 +0000
Message-ID: <20091209224538.GA23365@flint.arm.linux.org.uk>
References: <1260398346.14369.45.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56963 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758561AbZLIWuy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 17:50:54 -0500
Content-Disposition: inline
In-Reply-To: <1260398346.14369.45.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Wed, Dec 09, 2009 at 04:39:06PM -0600, James Bottomley wrote:
> Realistically, if I were thinking about the API properly, I'd probably
> have kunmap flush the kernel view if the dirty bit were set, thus
> relieving the user of the need to know anything at all about any of
> this.

Which dirty bit are you referring to?

New page cache pages do not have any dirty bit for this.  There is
PG_arch_1, but this is set by flush_dcache_page on architectures
playing the delayed-dcache-flush game... so making a call to
some cache flushing function conditional on it isn't going to work.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
