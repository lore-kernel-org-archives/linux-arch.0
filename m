Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:41432 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S263761AbUEEJ05
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 5 May 2004 05:26:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: static DEFINE_PER_CPU vs. modules
Date: Wed, 5 May 2004 11:24:56 +0200
References: <200405031741.52504.arnd@arndb.de> <200405051021.13944.arnd@arndb.de> <20040505012947.5e8c4050.akpm@osdl.org>
In-Reply-To: <20040505012947.5e8c4050.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405051124.57679.arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 05 May 2004 10:29, Andrew Morton wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The patch below still changes the common, i.e. non-ia64/x86_64, per-cpu
> >  implementation so that STATIC_DEFINE_PER_CPU is not static for modules
> >  and static DEFINE_PER_CPU is forbidden for modules.
> 
> What's the advantage in this?  The previous patch which killed the compile
> if someone sticks a `static' in there seemed sufficient?

One of Davids concerns was that simply removing the static is wrong because
- it confuses people by putting local symbols in the global namespace, and
- the resulting binary is less efficient even for the non-module case.

The previous patch was a sufficient fix for the original bug, the new
patch also addresses these concerns but is otherwise identical and will
result in the same compile error for code that is potentially broken.

	Arnd <><
