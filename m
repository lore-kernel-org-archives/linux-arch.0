Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:35884 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652AbYB2TVu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Feb 2008 14:21:50 -0500
Date: Fri, 29 Feb 2008 20:21:23 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 11/12] Generic semaphore implementation
Message-ID: <20080229192123.GB19476@elte.hu>
References: <1204180441-8540-5-git-send-email-matthew@wil.cx> <1204180441-8540-6-git-send-email-matthew@wil.cx> <1204180441-8540-7-git-send-email-matthew@wil.cx> <1204180441-8540-8-git-send-email-matthew@wil.cx> <1204180441-8540-9-git-send-email-matthew@wil.cx> <1204180441-8540-10-git-send-email-matthew@wil.cx> <1204180441-8540-11-git-send-email-matthew@wil.cx> <20080228071822.GA13571@elte.hu> <20080229003954.GA525@parisc-linux.org> <20080228174349.1da254bd.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080228174349.1da254bd.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> yummy summary:
> 
>  254 files changed, 386 insertions(+), 7827 deletions(-)
> 
> The only major conflict is with avr32 which seems to have just done a 
> major revamp of that architecture's semaphore implementation.  Oh 
> well.
> 
> There are a couple of small #include rejects here and there, nothing 
> at all major.
> 
> Yes, let's get this into linux-next if poss please.  If mainline later 
> breaks for some architecture, well, we did our best..

a better approach would be to send the core bits to Linus right now - as 
long as it's Kconfig isolated and inactive code - hence it is eligible 
as a cleanup.

That means arch maintainers could start applying the patches at their 
own pace, starting right now, in their own work-flow and test-flow. 
(obviously, the first such patches would hit mainline starting in the 
next merge window)

And all the linux-next integration trouble down the line is avoided, and 
each architecture can do a concentrated effort of: 'get rid of semaphore 
code'.

Please!

	Ingo
