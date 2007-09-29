Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:50931 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbXI2HXt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 29 Sep 2007 03:23:49 -0400
Date: Sat, 29 Sep 2007 16:23:25 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [COMPAT] Add compat_merge64 helper
Message-ID: <20070929072325.GC1395@linux-sh.org>
References: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca> <200709290138.24562.arnd@arndb.de> <20070929000131.GD25346@fattire.cabal.ca> <20070929000247.GE25346@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070929000247.GE25346@fattire.cabal.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Sep 28, 2007 at 08:02:47PM -0400, Kyle McMartin wrote:
> On Fri, Sep 28, 2007 at 08:01:31PM -0400, Kyle McMartin wrote:
> > I checked powerpc, sparc, and mips, which are (besides parisc) the only
> > 64-bit with 32-bit userspace big endian architectures that I could think
> > of offhand. A quick grep shows sh64 too... Paul?
> > 
> 
> Ah, no CONFIG_COMPAT on sh64 anyways.

Yes, the kernel currently runs with a 32-bit ABI, so it's not an issue
there.
