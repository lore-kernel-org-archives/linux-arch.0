Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51910 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752530AbYD0RAZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Apr 2008 13:00:25 -0400
Date: Sun, 27 Apr 2008 17:50:49 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: microblaze syscall list
Message-ID: <20080427175049.765766c8@core>
In-Reply-To: <4814A153.3040600@seznam.cz>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	<200804221515.28075.arnd@arndb.de>
	<480FA729.3000406@seznam.cz>
	<200804241311.09881.arnd@arndb.de>
	<4810D4A4.7050900@seznam.cz>
	<4811A623.80104@itee.uq.edu.au>
	<20080425100614.GB14990@parisc-linux.org>
	<4813DF3E.6080800@itee.uq.edu.au>
	<4814A153.3040600@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: microblaze-uclinux@itee.uq.edu.au, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>
Message-ID: <20080427165049.10N8gVpVy_AzvvhwgsMxi3KUJk8PQL6jrgtyAPlRr1k@z>

> There is two opinions:
> * One is take syscall table with old syscalls for backward compatibility.
> As John W wrote. Microblaze has history around 4 years and 2.6 kernel almost 2
> years.

I would keep the old syscall table. Otherwise you end up with two
differing microblaze setups and people will get binaries, libraries and
compilers muddled up for years to come which will be nothing but pain for
eveyone.

Alan
