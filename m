Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:14550 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964916AbWIQKg3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 06:36:29 -0400
Subject: Re: All arch maintainers: 'make headers_check' fails on most
	architectures.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0609171149210.5726@anakin>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0609171149210.5726@anakin>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 11:36:07 +0100
Message-Id: <1158489367.24527.222.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-09-17 at 11:52 +0200, Geert Uytterhoeven wrote:
> > asm-m68k/page.h requires asm-generic/page.h, which does not exist
> 
> Like this?

Looks sane to me, yes. Thanks. Care to add a Signed-off-by and send it
to Linus?

> BTW, what about adding headers_check to `make help'?

Yeah, good idea.

----
[PATCH] Add headers_check' target to output of 'make help'

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/Makefile b/Makefile
index eab5a8c..7646fc9 100644
--- a/Makefile
+++ b/Makefile
@@ -1082,6 +1082,7 @@ help:
 	@echo  'Static analysers'
 	@echo  '  checkstack      - Generate a list of stack hogs'
 	@echo  '  namespacecheck  - Name space analysis on compiled kernel'
+	@echo  '  headers_check   - Sanity check on exported headers'
 	@echo  ''
 	@echo  'Kernel packaging:'
 	@$(MAKE) $(build)=$(package-dir) help


-- 
dwmw2

