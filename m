Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50241 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760116AbXE1MdO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 08:33:14 -0400
Date: Mon, 28 May 2007 14:33:11 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070528123311.GA31609@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk> <20070527222408.GA26268@xi.wantstofly.org> <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
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

What else was running when you ran this program, and how many runs
did you try?  I get a mixture of firstfirstfirst and secondsecondsec
when the machine I run it on isn't idle.
