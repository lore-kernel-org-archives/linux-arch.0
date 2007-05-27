Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:49575 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbXE0Wq1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2007 18:46:27 -0400
Date: Mon, 28 May 2007 00:25:55 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070527222555.GB26268@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk> <1180275384.3711.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1180275384.3711.12.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 27, 2007 at 09:16:24AM -0500, James Bottomley wrote:

> Regardless of how we implement it, the way I read POSIX, it does
> require at least msync(x, 4096, MS_SYNC|MS_INVALIDATE) before
> accessing the data in another way.

Right.  At least the version of fsx-linux in akpm's ext3-tools
tarball doesn't do that.
