Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36784 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbKQBUn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2015 20:20:43 -0500
Received: by qgad10 with SMTP id d10so63307120qga.3
        for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2015 17:20:41 -0800 (PST)
Date: Mon, 16 Nov 2015 20:20:38 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
Message-ID: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20151117012038.rpb2HMm_pzyhSyGKA7DYZi6Oo61YzXA3cl8TfEXEjd4@z>

Arnd,

Please pull the following branch:

	git://git.linaro.org/people/nicolas.pitre/linux div64

This contains those patches I've initially posted here:

	https://lkml.org/lkml/2015/11/2/715

Only changes to those posted patches are cosmetic improvements such as 
the use of ilog2() replacing the custom __div64_ffs(). Exposure in 
linux-next would be a good thing.

I also included fixes for a couple do_div() misuses that an allyesconfig 
build turned up after switching ARM to the generic do_div() code.  
Those patches have been posted separately and addressed to relevant 
maintainers. They are included here until/unless those maintainers 
include those patches in their tree.

Original cover letter:

This is a generalization of the optimization I produced for ARM a decade
ago to turn constant divisors into a multiplication by the divisor
reciprocal. Turns out that after all those years gcc is still not
optimizing things on its own for that case.

This has important performance benefits as discussed in this thread:

	https://lkml.org/lkml/2015/10/28/851

This series brings the formerly ARM-only optimization to all 32-bit
architectures using C code by default.  The possibility for the actual
multiplication to be implemented in assembly is provided in order to get
optimal code.  The ARM version can be used as an example implementation
for other interested architectures to implement.

