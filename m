Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:27363 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261764AbUDDLHL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 Apr 2004 07:07:11 -0400
Date: Sun, 4 Apr 2004 13:04:57 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Message-Id: <20040404130457.303fd823.ak@suse.de>
In-Reply-To: <200404041236.50349.arnd@arndb.de>
References: <200404040204.03594.arnd@arndb.de>
	<200404040222.41413.arnd@arndb.de>
	<20040404122404.54329a2e.ak@suse.de>
	<200404041236.50349.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 4 Apr 2004 12:36:49 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Sunday 04 April 2004 12:24, Andi Kleen wrote:
> > I'm a bit dubious about LTP - often their test cases are very poor
> > and just check EFAULT behaviour. For testing it's better to just boot 
> > a 32bit distribution and make sure that at least some X desktop
> > works.
> 
> Right, the quality of LTP testcases varies a lot, but they tend to
> check the more obscure stuff that you might not hit when everything
> goes right.

Well, barely. The LSB test suite is a bit better, but it takes forever 
to run. There is also another test suite called ballista, but I never
got it to run properly.

 
> I forgot to say that I'm running mostly 32 bit user space on my
> Opteron box, so the good path was probably exercised as well.

Ok fine. I do too actually on my workstation, but I haven't booted your
patches yet ;-)

-Andi
