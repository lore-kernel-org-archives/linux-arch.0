From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH net-next] net: remove mm.h inclusion from netdevice.h
Date: Fri, 17 Jun 2011 09:57:22 +0300
Message-ID: <20110617065721.GA20555@p183.telecom.by>
References: <20110616210134.GA18026@p183.telecom.by>
 <20110617131937.63c71cb6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46482 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab1FQG51 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2011 02:57:27 -0400
Content-Disposition: inline
In-Reply-To: <20110617131937.63c71cb6.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org

On Fri, Jun 17, 2011 at 01:19:37PM +1000, Stephen Rothwell wrote:
> On Fri, 17 Jun 2011 00:01:34 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Remove linux/mm.h inclusion from netdevice.h -- it's unused (I've checked manually).
> 
> Have you tried building this with STAGING enabled?  The fallout for
> STAGING from the removal of linux/interrupt.h is still not sorted out.

No, because allmodconfig doesn't pick it.
I'll look into staging fallout.
