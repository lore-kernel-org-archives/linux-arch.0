Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:51810 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbXE2Pm6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2007 11:42:58 -0400
Date: Tue, 29 May 2007 17:42:55 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070529154255.GA10955@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk> <20070527222408.GA26268@xi.wantstofly.org> <1180310431.3711.27.camel@mulgrave.il.steeleye.com> <20070528100513.GC26046@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070528100513.GC26046@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, May 28, 2007 at 11:05:13AM +0100, Russell King wrote:

> With Lennert's new program, I get mostly:
> 
> firstfirstfirst
> firstfirstfirst
> firstfirstfirst
> 
> but occasionally:
> 
> firstfirstfirst
> firstfirstfirst
> secondsecondsec
> 
> However, if I open code the memcpy() in the MAPREAD to copy one word
> at a time, then I reliably get the "secondsecondsec" line.  But if I
> convert the memcpy() in MAPWRITE in the same way, I'm back to mostly
> getting the failure with the occasional success.  Utterly confused.

Maybe your caches are no-allocate-on-write and glibc's memcpy()
loads from the destination addresses to force line allocation?
