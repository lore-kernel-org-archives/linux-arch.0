Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50136 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759099Ab1IJLVs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2011 07:21:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 19/36] Hexagon: Add ptrace support
Date: Sat, 10 Sep 2011 13:21:25 +0200
Message-ID: <9538097.pLKYojR4H4@wuerfel>
In-Reply-To: <CACM3HyH8P=u9pR0sa2besxsgDN5TUKg_7utLJTwL+hu8Wv48ow@mail.gmail.com>
References: <20110909010847.294039464@codeaurora.org> <20110909211808.GA3150@codeaurora.org> <CACM3HyH8P=u9pR0sa2besxsgDN5TUKg_7utLJTwL+hu8Wv48ow@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110910112125.Ll0QjyPRdzjYxCTHfdyRBQ2LSyfzUkl-Eub2Q2JUEzo@z>

On Saturday 10 September 2011 08:42:26 Jonas Bonn wrote:
> > Putting a printk into case PTRACE_POKEUSR seemed to show that
> > gdb was using this (and was somehow mis-numbering the registers
> > ... sigh.) Are you saying that the default should handle this?
> 
> I'm really not an expert on GDB, but I believe it can use either the
> PEEK/POKE functions to access regs, or it can use GET/SETREGS; it's an
> architecture-dependent configuration.  I think the second variant can
> be easily modified to become GET/SETREGSET instead, and the PEEK/POKE
> variant wouldn't be needed at all.

Yes, I think that is the way to go for new architectures, although
practically no architecture in the upstream kernel does it this
way.

The PEEKUSR/POKEUSR stuff is a relic from ancient Unix time where you
would directly access a kernel data structure with it, we should get
over it.

	Arnd
