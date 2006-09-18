Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:4485 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965194AbWIRA50 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 20:57:26 -0400
Date: Sun, 17 Sep 2006 17:57:23 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
Message-ID: <20060918005723.GB12662@tuatara.stupidest.org>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net> <20060917202408.GA10031@tuatara.stupidest.org> <1158527646.6069.67.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158527646.6069.67.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Sep 17, 2006 at 10:14:06PM +0100, Alan Cox wrote:

> Unfortunately yes. This was discovered in the real world.

Are there a lot of these applications and does it break badly?  Do you
know which ones they are?

It's not an intuitive change and as the current behavior isn't
entirely consistent and (presumably) these applications work, so is
this change really needed?

Fixing userspace assumptions but setting a (counter-intuitive)
precedent in the kernel seems wrong.

> Executable types already let us handle that, or as you suggest but
> the other way around you add PROT_REALLYLIKEWRITEONLYOK as a new
> mmap type (and as PROT_WRITE) for a new binary format later if the
> CPU ever supports it.

True, but it's more complexity further down the line.

> Frankly I think the odds of Intel cpus growing write-only are
> remote....

Even with VT/Pacifica?  Might those not provide support to catch reads
and writes to certain regions?  At some point I imagine there will be
in-kernel awareness of those technologies when the kernel isn't
running uder a hypervisor to make things like running a VM inside
Linux easier (I would assume vmware is/has done this already perhaps).
