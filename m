Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:10704 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262736AbUCWSnl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 13:43:41 -0500
Date: Tue, 23 Mar 2004 10:43:18 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: signal-race-fix.patch
Message-Id: <20040323104318.00239a2d.davem@redhat.com>
In-Reply-To: <20040323022020.3972af1d.akpm@osdl.org>
References: <20040319120151.380dcbc9.akpm@osdl.org>
	<20040319141258.338c91b1.davem@redhat.com>
	<405B773B.8010705@acm.org>
	<20040319154928.3b2d8820.davem@redhat.com>
	<405B8BE5.4070602@acm.org>
	<20040323022020.3972af1d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: minyard@acm.org, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, 23 Mar 2004 02:20:20 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Corey Minyard <minyard@acm.org> wrote:
> >
> > Here's another patch with the SEGV problems handled and the ka's renamed 
> >  to ka_copy.
> 
> Are there any remaining concerns with Corey's final patch?

I'm fine with it.
