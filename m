Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1278 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758078AbXFQSwK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Jun 2007 14:52:10 -0400
Date: Sun, 17 Jun 2007 18:32:13 +0000
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 0/3] no MAX_ARG_PAGES -v2
Message-ID: <20070617183213.GA3892@ucw.cz>
References: <20070613100334.635756997@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070613100334.635756997@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Ollie Wild <aaw@google.com>, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>

Hi!

> This patch-set aims at removing the current limit on argv+env space aka.
> MAX_ARG_PAGES.

Thanks a lot for solving this properly. I have been upping current limits to some
insane ammounts to work around this.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
