Return-Path: <arnd@arndb.de>
Received: from natnoddy.rzone.de ([81.169.145.166]:6128 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261764AbUDDKqW
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 4 Apr 2004 06:46:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Date: Sun, 4 Apr 2004 12:36:49 +0200
References: <200404040204.03594.arnd@arndb.de> <200404040222.41413.arnd@arndb.de> <20040404122404.54329a2e.ak@suse.de>
In-Reply-To: <20040404122404.54329a2e.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404041236.50349.arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sunday 04 April 2004 12:24, Andi Kleen wrote:
> I'm a bit dubious about LTP - often their test cases are very poor
> and just check EFAULT behaviour. For testing it's better to just boot 
> a 32bit distribution and make sure that at least some X desktop
> works.

Right, the quality of LTP testcases varies a lot, but they tend to
check the more obscure stuff that you might not hit when everything
goes right.

I forgot to say that I'm running mostly 32 bit user space on my
Opteron box, so the good path was probably exercised as well.

	Arnd <><
