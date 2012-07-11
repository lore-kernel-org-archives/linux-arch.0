Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50040 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab2GKGdA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jul 2012 02:33:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Wed, 11 Jul 2012 06:32:39 +0000
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com> <201207101807.28993.arnd@arndb.de> <20120711024411.GA11440@linux-sh.org>
In-Reply-To: <20120711024411.GA11440@linux-sh.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201207110632.39571.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mike Turquette <mturquette@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120711063239.d6P20pC7sYxKJUClKUSmGHD4ef7bVpy7yHgpjeDzIgI@z>

On Wednesday 11 July 2012, Paul Mundt wrote:
> > I can start an asm-generic branch in the arm-soc tree then (or maybe
> > a new tree) and apply the patch there.
> > 
> Given that this patch has nothing at all to do with ARM, why not just
> take it through the asm-generic tree?

Just my personal lazyness. I haven't had an asm-generic tree for a while,
and my main working tree is a mirror of the arm-soc tree.

On the other hand, I looked up the maintainers file and it points to
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
so maybe I should restore that one after all or remove the reference
if I don't.

	Arnd
