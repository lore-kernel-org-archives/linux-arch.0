Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55877 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbXJ2IK2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2007 04:10:28 -0400
Date: Mon, 29 Oct 2007 08:10:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Only show RESOURCES_64BIT on relevant architectures
Message-ID: <20071029081010.GA32160@flint.arm.linux.org.uk>
References: <20071028201549.GA23138@fattire.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071028201549.GA23138@fattire.cabal.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Oct 28, 2007 at 04:15:49PM -0400, Kyle McMartin wrote:
> To quote lolcats: CONFIG_RESOURCES_64BIT DO NOT WANT!
> 
> I *think* I have the logic of this right... Anyway, I was annoyed by
> having to do the bloody ugly casts to unsigned long long in
> arch-specific code. As near as I can tell, we only want this selectable
> in the case of PAE on x86, and some random PPC and MIPS embedded boards.

May I suggest trying:

$ grep RESOURCES_64BIT=y arch/*/configs/* arch/*/defconfig

to locate those architectures which use this?

FYI, that grep says ARM, ia64, mips, parisc, powerpc, PPC, s390, sparc64,
and x86 use this feature.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
