Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:35410 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754888AbeAHCXu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2018 21:23:50 -0500
Date: Sun, 07 Jan 2018 21:23:47 -0500 (EST)
Message-ID: <20180107.212347.315015145942081238.davem@davemloft.net>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.20.1801072143370.2094@nanos>
References: <20180107201211.GA9996@1wt.eu>
        <CA+55aFwYEr-x3teixCh5QtyMzXZKdNUkoF4xiw+1zg08PSsvpw@mail.gmail.com>
        <alpine.DEB.2.20.1801072143370.2094@nanos>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: torvalds@linux-foundation.org, w@1wt.eu, alexei.starovoitov@gmail.com, gnomes@lxorguk.ukuu.org.uk, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, mingo@redhat.com, hpa@zytor.com
Message-ID: <20180108022347.cPpsep28SA0cLZYjhBc2Q9lxDkbn2bnBiN3PznXWHNQ@z>

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 7 Jan 2018 21:56:39 +0100 (CET)

> I surely agree, but we have gone the way of PTI without the ability of
> exempting individual processes exactly for one reason:
> 
>   Lack of time
> 
> It can be done on top of the PTI implementation and it won't take ages.
> 
> For spectre_v1/2 we face the same problem simply because we got informed so
> much ahead of time and we were all twiddling thumbs, enjoying our christmas
> vacation and having a good time.

I just want to point out that this should be noted in history as a
case where all of this controlled disclosure stuff seems to have made
things worse rather than better.

Why is there so much haste and paranoia if supposedly some group of
people had all this extra time to think about and deal with this bug?
