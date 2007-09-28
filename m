Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57267 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXI2AH7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2007 20:07:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [COMPAT] Add compat_merge64 helper
Date: Sat, 29 Sep 2007 01:52:12 +0200
References: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca> <200709290138.24562.arnd@arndb.de> <20070929000131.GD25346@fattire.cabal.ca>
In-Reply-To: <20070929000131.GD25346@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200709290152.12842.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Saturday 29 September 2007, Kyle McMartin wrote:
> 
> On Sat, Sep 29, 2007 at 01:38:23AM +0200, Arnd Bergmann wrote:
> > 1. Byte order matches the order in which 64 bit arguments are split
> >    in system call conventions on all platforms.
> 
> I checked powerpc, sparc, and mips, which are (besides parisc) the only
> 64-bit with 32-bit userspace big endian architectures that I could think
> of offhand. A quick grep shows sh64 too... Paul?
> 

s390 is big-endian as well, and while it does have really weird C calling
conventions for 64 bit arguments in 32 bit mode, these do not affect the
system call ABI, so we should be fine here.

ia64 and x86_64 are obviously little-endian, and I double-checked that they
work with this logic.

	Arnd <><
