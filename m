Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:41339 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753189AbXE1OWD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 10:22:03 -0400
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070528123311.GA31609@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
	 <20070527222408.GA26268@xi.wantstofly.org>
	 <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
	 <20070528123311.GA31609@xi.wantstofly.org>
Content-Type: text/plain
Date: Mon, 28 May 2007 09:22:01 -0500
Message-Id: <1180362121.3689.7.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-05-28 at 14:33 +0200, Lennert Buytenhek wrote:
> On Sun, May 27, 2007 at 07:00:31PM -0500, James Bottomley wrote:
> 
> > Ok, output on parisc is:
> > 
> > jejb@ioz:~$ ./a.out
> > firstfirstfirst
> > firstfirstfirst
> > secondsecondsec
> > 
> > Which is correct.  It remains correct even if I drop the msync().
> 
> What else was running when you ran this program, and how many runs
> did you try?  I get a mixture of firstfirstfirst and secondsecondsec
> when the machine I run it on isn't idle.

Both loaded and unloaded ... although you have to be careful how you
load on pa to see coherency problems:  the fork/exec cycle does a full
cache flush.

James


James


