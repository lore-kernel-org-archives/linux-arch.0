Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:60698 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758107AbYD0Xl7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Apr 2008 19:41:59 -0400
Date: Mon, 28 Apr 2008 01:41:10 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Message-ID: <20080427234110.GA14679@elte.hu>
References: <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org> <20080427174714.GB2252@cs181133002.pp.htv.fi> <20080427180007.GB28483@infradead.org> <20080427180957.GA25964@uranus.ravnborg.org> <20080427181411.GA31667@infradead.org> <alpine.LFD.1.10.0804271118500.2896@woody.linux-foundation.org> <20080427162606.3dd82c0c@laptopd505.fenrus.org> <alpine.LFD.1.10.0804271634490.3119@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804271634490.3119@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@kernel.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>
Message-ID: <20080427234110.3Najoj8_h_va8nYyfqjLIyVyc91StC9U6Oy7TQBwyBU@z>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 27 Apr 2008, Arjan van de Ven wrote:
> > 
> > (actually, other than some obscure commandline options, the only 
> > sane way to avoid gcc doing this too agressive is using -Os)
> 
> Well, CC_OPTIMIZE_FOR_SIZE has been defaulting to 'y' for a *loong* 
> time, but it's hidden behind a EXPERIMENTAL (unless you were on some 
> embedded architectures), so many people won't see it.
> 
> Perhaps it is time to remove the EXPERIMENTAL? I think the gcc 
> warnings were mostly bogus - it's not as if there haven't been 
> compiler bugs without -Os too..

i was wondering about that when doing the OPTIMIZE_INLINING change - 
lets do something like the patch below?

	Ingo

-------------->
Subject: make CC_OPTIMIZE_FOR_SIZE non-experimental
From: Ingo Molnar <mingo@elte.hu>
Date: Mon Apr 28 01:39:43 CEST 2008

this option has been the default on a wide range of distributions
for a long time - time to make it non-experimental.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 init/Kconfig |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux-x86.q/init/Kconfig
===================================================================
--- linux-x86.q.orig/init/Kconfig
+++ linux-x86.q/init/Kconfig
@@ -496,16 +496,12 @@ source "usr/Kconfig"
 endif
 
 config CC_OPTIMIZE_FOR_SIZE
-	bool "Optimize for size (Look out for broken compilers!)"
+	bool "Optimize for size"
 	default y
-	depends on ARM || H8300 || SUPERH || EXPERIMENTAL
 	help
 	  Enabling this option will pass "-Os" instead of "-O2" to gcc
 	  resulting in a smaller kernel.
 
-	  WARNING: some versions of gcc may generate incorrect code with this
-	  option.  If problems are observed, a gcc upgrade may be needed.
-
 	  If unsure, say N.
 
 config SYSCTL
