Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:53831 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761689AbXFQTN7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 17 Jun 2007 15:13:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim)
	id 1I00CD-0005lv-Lc
	from <mingo@elte.hu>
	for <linux-arch@vger.kernel.org>; Sun, 17 Jun 2007 21:13:57 +0200
Date: Sun, 17 Jun 2007 21:07:10 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/3] no MAX_ARG_PAGES -v2
Message-ID: <20070617190710.GA20682@elte.hu>
References: <20070613100334.635756997@chello.nl> <20070617183213.GA3892@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070617183213.GA3892@ucw.cz>
Sender: linux-arch-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Ollie Wild <aaw@google.com>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>


* Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > This patch-set aims at removing the current limit on argv+env space 
> > aka. MAX_ARG_PAGES.
> 
> Thanks a lot for solving this properly. I have been upping current 
> limits to some insane ammounts to work around this.

seconded! I have tried the patchset and it works great for me. This 
limitation of Linux has bothered me almost since i started using Linux 
more than a decade ago (i remember having run into it when running a 
script on an overly large directory), and it's perhaps the oldest still 
existing userspace-visible limitations of Linux. It was also a really 
hard nut to crack. Kudos Peter! I really cant wait to see this in 2.6.23
:-)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
