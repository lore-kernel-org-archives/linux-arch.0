Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52907 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab2GCNjj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 09:39:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 3 Jul 2012 13:39:34 +0000
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20120703114844.GJ29030@opensource.wolfsonmicro.com> <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
In-Reply-To: <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201207031339.34369.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120703133934._KsIjTUrzi76m3qblda8jjfLMw89Vw-iwioGXHzwAuc@z>

On Tuesday 03 July 2012, Stephen Rothwell wrote:
> > > Maybe Michal Marek or someone on the kbuild mailing list can help
> > > out with a solution for that.
> > 
> > We could do that incrementally...
> 
> Yes, indeed it should be a separate change.

Ok, let's do that then. What tree should we use for merging it?

In theory I should take it to some asm-generic tree, but since
I get very little traffic there, I'm usually happy to just provide
an Ack and let anyone who needs the patch merge it through their
trees.

	Arnd
