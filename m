From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH] sock: add SO_RCVQUEUE_SIZE getsockopt
Date: Mon, 13 Mar 2017 17:10:08 -0700 (PDT)
Message-ID: <20170313.171008.1845413549443399902.davem@davemloft.net>
References: <522a2e2d-c288-7019-3f12-2b624d6aa921@akamai.com>
        <20170313.123933.1813218797817423920.davem@davemloft.net>
        <9f775c33-01f4-fbd8-4d4d-4ca67f0f6d3b@akamai.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:60192 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdCNAKJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2017 20:10:09 -0400
In-Reply-To: <9f775c33-01f4-fbd8-4d4d-4ca67f0f6d3b@akamai.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: johunt@akamai.com
Cc: edumazet@google.com, arnd@arndb.de, soheil@google.com, willemb@google.com, pabeni@redhat.com, linux-arch@vger.kernel.org, netdev@vger.kernel.org

From: Josh Hunt <johunt@akamai.com>
Date: Mon, 13 Mar 2017 18:34:41 -0500

> In this particular case they really do want to know total # of bytes
> in the receive queue, not the data bytes they can consume from an
> application pov. The kernel currently only exposes this value through
> netlink or /proc/net/udp from what I saw.

Can you explain in what way this is useful?

The difference between skb->len and skb->truesize is really kernel
internal implementation detail, and I'm trying to figure out why
this would be useful to an application.
