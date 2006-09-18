Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2789 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965601AbWIRJFI
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 05:05:08 -0400
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20060918005723.GB12662@tuatara.stupidest.org>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
	 <20060917202408.GA10031@tuatara.stupidest.org>
	 <1158527646.6069.67.camel@localhost.localdomain>
	 <20060918005723.GB12662@tuatara.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 10:26:33 +0100
Message-Id: <1158571594.6069.82.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

Ar Sul, 2006-09-17 am 17:57 -0700, ysgrifennodd Chris Wedgwood:
> On Sun, Sep 17, 2006 at 10:14:06PM +0100, Alan Cox wrote:
> 
> > Unfortunately yes. This was discovered in the real world.
> 
> Are there a lot of these applications and does it break badly?  Do you
> know which ones they are?

I don't know precisely which applications but Red Hat has customers
hitting the random behaviour. By choice I'd like that to turn into
consistent failure but its outside the hardware capabilities right now.

> It's not an intuitive change and as the current behavior isn't
> entirely consistent and (presumably) these applications work, so is
> this change really needed?
> 
> Fixing userspace assumptions but setting a (counter-intuitive)
> precedent in the kernel seems wrong.

The current behaviour is "randomly fails". The expected behaviour is
"consistently fails" or "consistently succeeds". POSIX explicitly says
that passing just PROT_WRITE may give you a readable mapping (just as
PROT_READ may give you exec in turn).

The change would thus be logically consistent and in keeping with the
standard.

> Even with VT/Pacifica?  

For VT at the moment the answer appears to be no. 

Alan

