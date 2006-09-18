Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:30337 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965227AbWIRCEA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 22:04:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17677.65159.433214.4524@cargo.ozlabs.ibm.com>
Date: Mon, 18 Sep 2006 12:03:51 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
In-Reply-To: <20060918005723.GB12662@tuatara.stupidest.org>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
	<20060917202408.GA10031@tuatara.stupidest.org>
	<1158527646.6069.67.camel@localhost.localdomain>
	<20060918005723.GB12662@tuatara.stupidest.org>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

Chris Wedgwood writes:

> Are there a lot of these applications and does it break badly?  Do you
> know which ones they are?
> 
> It's not an intuitive change and as the current behavior isn't
> entirely consistent and (presumably) these applications work, so is
> this change really needed?

I think the problem is that these applications break randomly,
depending on exactly when page faults happen, and these patches make
the behaviour consistent and deterministic.

Paul.
