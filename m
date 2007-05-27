Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55185
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbXE0XGi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 May 2007 19:06:38 -0400
Date: Sun, 27 May 2007 16:06:44 -0700 (PDT)
Message-Id: <20070527.160644.18307009.davem@davemloft.net>
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070527222555.GB26268@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
	<1180275384.3711.12.camel@mulgrave.il.steeleye.com>
	<20070527222555.GB26268@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: buytenh@wantstofly.org
Cc: James.Bottomley@steeleye.com, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Mon, 28 May 2007 00:25:55 +0200

> On Sun, May 27, 2007 at 09:16:24AM -0500, James Bottomley wrote:
> 
> > Regardless of how we implement it, the way I read POSIX, it does
> > require at least msync(x, 4096, MS_SYNC|MS_INVALIDATE) before
> > accessing the data in another way.
> 
> Right.  At least the version of fsx-linux in akpm's ext3-tools
> tarball doesn't do that.

I don't think we can seriously consider this requirement.

We can make the data properly coherent on D-cache aliasing cpus, so we
should.
