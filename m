Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:61336 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266246AbUG0E7G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Jul 2004 00:59:06 -0400
Date: Mon, 26 Jul 2004 21:57:40 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: signal-race-fix.patch
Message-Id: <20040726215740.1503d085.akpm@osdl.org>
In-Reply-To: <4105CEC5.2030308@acm.org>
References: <20040319120151.380dcbc9.akpm@osdl.org>
	<20040319141258.338c91b1.davem@redhat.com>
	<405B773B.8010705@acm.org>
	<20040319154928.3b2d8820.davem@redhat.com>
	<405B8BE5.4070602@acm.org>
	<20040323022020.3972af1d.akpm@osdl.org>
	<410574E6.2040309@acm.org>
	<20040726142224.79018464.akpm@osdl.org>
	<4105CEC5.2030308@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Corey Minyard <minyard@acm.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Corey Minyard <minyard@acm.org> wrote:
>
> Andrew Morton wrote:
> 
>  >Corey Minyard <minyard@acm.org> wrote:
>  >  
>  >
>  >>I haven't seen anything for this, this is not in the current Linus or mm 
>  >>releases.  Did I miss something?
>  >>    
>  >>
>  >
>  >Andi had some legitimate gripes over it - the patch was a bit messy and
>  >could have some performance impact.  So I kinda forgot about it in the hope
>  >that a nicer solution would come along.
>  >  
>  >
>  Ok.  I searched and could not find Andi's email; do you have a pointer 
>  to it?

err, no.

I resurrected the patches - I'll send them out to remind people what they
do.  It affects all arches, and I only have x86, ia64, s390 and x86_64 in
hand.

It'll be a fair bit of work all round, so I'd ask people to take some time
out to think about this please.
