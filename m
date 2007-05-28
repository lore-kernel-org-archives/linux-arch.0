Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4097 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbXE1KF0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 06:05:26 -0400
Date: Mon, 28 May 2007 11:05:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070528100513.GC26046@flint.arm.linux.org.uk>
References: <20070527104930.GB25023@flint.arm.linux.org.uk> <20070527222408.GA26268@xi.wantstofly.org> <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 27, 2007 at 07:00:31PM -0500, James Bottomley wrote:
> Ok, output on parisc is:
> 
> jejb@ioz:~$ ./a.out
> firstfirstfirst
> firstfirstfirst
> secondsecondsec
> 
> Which is correct.  It remains correct even if I drop the msync().

With Lennert's new program, I get mostly:

firstfirstfirst
firstfirstfirst
firstfirstfirst

but occasionally:

firstfirstfirst
firstfirstfirst
secondsecondsec

However, if I open code the memcpy() in the MAPREAD to copy one word
at a time, then I reliably get the "secondsecondsec" line.  But if I
convert the memcpy() in MAPWRITE in the same way, I'm back to mostly
getting the failure with the occasional success.  Utterly confused.

Unless someone's got a theory, I'm stumped.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
