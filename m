Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:40157 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbXI2ABe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2007 20:01:34 -0400
Date: Fri, 28 Sep 2007 20:01:31 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [COMPAT] Add compat_merge64 helper
Message-ID: <20070929000131.GD25346@fattire.cabal.ca>
References: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca> <200709290138.24562.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709290138.24562.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Sep 29, 2007 at 01:38:23AM +0200, Arnd Bergmann wrote:
> 1. Byte order matches the order in which 64 bit arguments are split
>    in system call conventions on all platforms.

I checked powerpc, sparc, and mips, which are (besides parisc) the only
64-bit with 32-bit userspace big endian architectures that I could think
of offhand. A quick grep shows sh64 too... Paul?

> 2. Every user of compat_merge64() includes asm/byteorder.h
> 

*nod* Good point.

> Both should be easy to prove, but I'm not convinced until someone
> actually does it.
> 

Cheers,
	Kyle
