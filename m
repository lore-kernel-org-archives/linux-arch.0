Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58499 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXHGUKl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Aug 2007 16:10:41 -0400
Date: Tue, 7 Aug 2007 22:10:54 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [patch 3/3] mm: variable length argument support
Message-ID: <20070807201054.GA31501@aepfle.de>
References: <20070613100334.635756997@chello.nl> <20070613100835.014096712@chello.nl> <20070807190357.GA31139@aepfle.de> <20070807122008.fcd175d6.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070807122008.fcd175d6.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Ollie Wild <aaw@google.com>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 07, Andrew Morton wrote:

> > > +++ linux-2.6-2/include/linux/binfmts.h	2007-06-13 11:52:46.000000000 +0200

> > > -#define MAX_ARG_PAGES 32
> > > +#define MAX_ARG_STRLEN (PAGE_SIZE * 32)
> > > +#define MAX_ARG_STRINGS 0x7FFFFFFF
> > 
> > This adds a new usage of PAGE_SIZE to an exported header.
> > How can this be fixed for 2.6.23?
> 
> Put #ifdef __KERNEL__ around it?

No package uses linux/binfmts.h, will send a Kbuild patch to unexport
it.
