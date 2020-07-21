From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] arch, net: remove the last csum_partial_copy()
 leftovers
Date: Mon, 20 Jul 2020 17:45:52 -0700 (PDT)
Message-ID: <20200720.174552.1199692153657012436.davem@davemloft.net>
References: <20200720113609.177259-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720113609.177259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: msalter@redhat.com, jacquiot.aurelien@gmail.com, ley.foon.tan@intel.com, arnd@arndb.de, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 20 Jul 2020 13:36:09 +0200

> Most of the tree only uses and implements csum_partial_copy_nocheck,
> but the c6x and lib/checksum.c implement a csum_partial_copy that
> isn't used anywere except to define csum_partial_copy.  Get rid of
> this pointless alias.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'll apply this to net-next, thanks.
