Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:17705 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758828AbXGMT1e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 15:27:34 -0400
Date: Fri, 13 Jul 2007 12:26:42 -0700 (PDT)
From: Joshua Wise <jwise@google.com>
Subject: Re: - print-utsname-on-oops-on-all-architectures.patch removed from
 -mm tree
In-Reply-To: <20070713012541.46fc04b8.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0707131225430.617@internets.corp.google.com>
References: <200707062207.l66M7hQA023027@imap1.linux-foundation.org>
 <Pine.LNX.4.64.0707091121570.617@internets.corp.google.com>
 <20070713012541.46fc04b8.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ak@suse.de, benh@kernel.crashing.org, ink@jurassic.park.msu.ru, linux-arch@vger.kernel.org, paulus@samba.org, rmk@arm.linux.org.uk, rth@twiddle.net, mm-commits@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 13 Jul 2007, Andrew Morton wrote:
> I turned this into an incremental patch so we could see what changed.

Sounds good.

> Please prefer to copy a mailing list on all patches.  OK, linux-arch
> was copied this time, but only by luck (I suspect)

OK, will do in the future.

> Please avoid sending two copies of the patch in one email (one inlined
> and the other attached).  Because the resulting patch will apply happily
> with `patch --dry-run' and will then cause havoc when one tries to apply
> it for real.

Did my inlined one get mangled?  I sent two copies mostly to avoid the issue
where pine mashes my patches; if pine is continuing to do so, I will simply
attach, but if it is not, then I'll go back to inlining exclusivel;y.

joshua

> 
> Thanks.
> 
