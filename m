Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:34388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFCVKs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Jun 2017 17:10:48 -0400
Date: Sat, 03 Jun 2017 17:10:43 -0400 (EDT)
Message-ID: <20170603.171043.791231559479346761.davem@davemloft.net>
Subject: Re: [PATCH 1/5] sparc: simplify <asm/siginfo.h>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170603190102.28866-2-hch@lst.de>
References: <20170603190102.28866-1-hch@lst.de>
        <20170603190102.28866-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hch@lst.de
Cc: arnd@arndb.de, tglx@linutronix.de, tony.luck@intel.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170603211043.1ZRB50BWaf7JEYbbdzIRaaUKSCWlQ0_ZyOsink3LgQo@z>

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  3 Jun 2017 21:00:58 +0200

> There is no need for the forward declaration of compat_siginfo provided
> here.  We can't yet use the generic header as we need to pull in the
> sparc-specific version of the uapi <asm/siginfo.h>, but this prepares
> for removing the non-uapi <asm/siginfo.h> entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
