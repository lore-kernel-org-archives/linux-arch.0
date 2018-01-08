From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sun, 07 Jan 2018 21:04:47 -0500 (EST)
Message-ID: <20180107.210447.857032573629357172.davem@davemloft.net>
References: <20180106.203654.731754766847198456.davem@davemloft.net>
        <1515345560.3075.7.camel@HansenPartnership.com>
        <alpine.DEB.2.20.1801071925090.2094@nanos>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:35142 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754870AbeAHCEv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2018 21:04:51 -0500
In-Reply-To: <alpine.DEB.2.20.1801071925090.2094@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: James.Bottomley@HansenPartnership.com, w@1wt.eu, gnomes@lxorguk.ukuu.org.uk, alexei.starovoitov@gmail.com, torvalds@linux-foundation.org, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, mingo@redhat.com, hpa@zytor.com

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 7 Jan 2018 19:31:41 +0100 (CET)

> 2) Alexei's analyis is purely based on the public information of the google
>    zero folks. If it would be complete and the only attack vector all fine.
> 
>    If not and I doubt it is, we're going to regret this decision faster
>    than we made it and this is not the kind of play field where we can
>    afford that.

Please state this more clearly.

Do you know about other attack vectors and just are not allowed to
talk about them?

Or is this, ironically, speculation?
