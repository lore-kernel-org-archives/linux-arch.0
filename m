Return-Path: <SRS0=C7+S=A7=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgGTBRB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 21:17:01 -0400
Date: Sun, 19 Jul 2020 18:16:59 -0700 (PDT)
Message-ID: <20200719.181659.1807927650741641565.davem@davemloft.net>
Subject: Re: sockopt cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hch@lst.de
Cc: ast@kernel.org, daniel@iogearbox.net, 3chas3@gmail.com, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org, linux-arch@vger.kernel.org, linux-bluetooth@vger.kernel.org, bridge@lists.linux-foundation.org, linux-can@vger.kernel.org, dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.01.org
Message-ID: <20200720011659.d1z0573JtYkMRSmFw7vq0iqoIykANxWesR8GaqRkQkI@z>

From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:09 +0200

> this series cleans up various lose ends in the sockopt code, most
> importantly removing the compat_{get,set}sockopt infrastructure in favor
> of just using in_compat_syscall() in the few places that care.

Series applied to net-next, thanks.
