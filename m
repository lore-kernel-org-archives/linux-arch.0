Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:1419 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265777AbUGZVXu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Jul 2004 17:23:50 -0400
Date: Mon, 26 Jul 2004 14:22:24 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: signal-race-fix.patch
Message-Id: <20040726142224.79018464.akpm@osdl.org>
In-Reply-To: <410574E6.2040309@acm.org>
References: <20040319120151.380dcbc9.akpm@osdl.org>
	<20040319141258.338c91b1.davem@redhat.com>
	<405B773B.8010705@acm.org>
	<20040319154928.3b2d8820.davem@redhat.com>
	<405B8BE5.4070602@acm.org>
	<20040323022020.3972af1d.akpm@osdl.org>
	<410574E6.2040309@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Corey Minyard <minyard@acm.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Corey Minyard <minyard@acm.org> wrote:
>
> I haven't seen anything for this, this is not in the current Linus or mm 
> releases.  Did I miss something?

Andi had some legitimate gripes over it - the patch was a bit messy and
could have some performance impact.  So I kinda forgot about it in the hope
that a nicer solution would come along.


> Thanks,
> 
> -Corey
> 
> Andrew Morton wrote:
> 
> >Corey Minyard <minyard@acm.org> wrote:
> >  
> >
> >>Here's another patch with the SEGV problems handled and the ka's renamed 
> >> to ka_copy.
> >>    
> >>
> >
> >Are there any remaining concerns with Corey's final patch?
> >
> >
> > 25-akpm/arch/i386/kernel/signal.c |   60 +++++++++++++++++---------------------
> > 25-akpm/include/linux/signal.h    |    2 -
> > 25-akpm/kernel/signal.c           |   12 ++++++-
> > 3 files changed, 39 insertions(+), 35 deletions(-)
> >  
> >
