Return-Path: <SRS0=028w=A4=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgGQICM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 04:02:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951AC08C5C0
        for <linux-arch@vger.kernel.org>; Fri, 17 Jul 2020 01:02:11 -0700 (PDT)
Subject: Re: [PATCH 22/22] net: make ->{get,set}sockopt in proto_ops optional
References: <20200717062331.691152-1-hch@lst.de>
 <20200717062331.691152-23-hch@lst.de>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <5f88e695-d787-2191-feef-883a067788ed@pengutronix.de>
Date: Fri, 17 Jul 2020 10:01:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200717062331.691152-23-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Chas Williams <3chas3@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org, linux-arch@vger.kernel.org, linux-bluetooth@vger.kernel.org, bridge@lists.linux-foundation.org, linux-can@vger.kernel.org, dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.01.org
Message-ID: <20200717080128.1ahqdJ5c7nGZ4Hbbq47am7rf0whYLlm0gdpyDQxVx8c@z>

On 7/17/20 8:23 AM, Christoph Hellwig wrote:
> Just check for a NULL method instead of wiring up
> sock_no_{get,set}sockopt.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  net/can/bcm.c               |  2 --
>  net/core/sock.c             | 14 --------------

For the CAN part:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
