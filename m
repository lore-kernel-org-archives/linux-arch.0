Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24202 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965092AbWIQUvy
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 16:51:54 -0400
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20060917202408.GA10031@tuatara.stupidest.org>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
	 <20060917202408.GA10031@tuatara.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 17 Sep 2006 22:14:06 +0100
Message-Id: <1158527646.6069.67.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

Ar Sul, 2006-09-17 am 13:24 -0700, ysgrifennodd Chris Wedgwood:
> On Thu, Sep 14, 2006 at 06:39:47PM -0700, akpm@osdl.org wrote:
> 
> > Make PROT_WRITE imply PROT_READ for a number of architectures which
> > don't support write only in hardware.
> 
> Why don't we WARN where PROT_WRITE is used w/o PROT_READ?  Do
> non-trivial or non-contrived applications really use PROT_WRITE and
> assume reads are OK?

Unfortunately yes. This was discovered in the real world.

> It seems once we do this there will be little or no chance of ever
> doing write-only mappings should we want to in the future using this
> mechanism.

Executable types already let us handle that, or as you suggest but the
other way around you add PROT_REALLYLIKEWRITEONLYOK as a new mmap type
(and as PROT_WRITE) for a new binary format later if the CPU ever
supports it. Frankly I think the odds of Intel cpus growing write-only
are remote....

Alan

