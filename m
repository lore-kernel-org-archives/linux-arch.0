Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267365AbUITV17@vger.kernel.org>
Received: from mail6.speakeasy.net ([216.254.0.206]:47299 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S267363AbUITV17
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Sep 2004 17:27:59 -0400
Date: Mon, 20 Sep 2004 14:27:54 -0700
Message-Id: <200409202127.i8KLRsEK000789@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: waitid fallout
In-Reply-To: Arnd Bergmann's message of  Saturday, 18 September 2004 15:03:03 +0200 <200409181503.07369.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Richard Henderson <rth@twiddle.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Also, why did you put the compat code in arch/* and not in
> kernel/compat.c? Converting siginfo_t should probably remain
> architecture specific, but the rest should be the same everywhere.

There is no existing shared compat code handling siginfo_t at all.  
I followed the model of existing interfaces that use it like
sys32_rt_sigtimedwait.  I'm not sure that all arch's provide the 32-bit
siginfo_t type or call it the same thing.  I haven't seen other such cases
where the generic kernel/compat.c code refers to types defined in
arch-specific code.


Thanks,
Roland
