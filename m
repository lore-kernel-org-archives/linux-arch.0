From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 0/7] Enable queued rwlock and queued spinlock for
 SPARC
Date: Thu, 25 May 2017 15:18:57 -0400 (EDT)
Message-ID: <20170525.151857.1037705639569909590.davem@davemloft.net>
References: <1495670115-63960-1-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:60804 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036569AbdEYTTB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 15:19:01 -0400
In-Reply-To: <1495670115-63960-1-git-send-email-babu.moger@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: babu.moger@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com

From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 24 May 2017 17:55:08 -0600

> This series of patches enables queued rwlock and queued spinlock support
> for SPARC. These features were introduced some time ago in upstream.

Looks great, all applied to sparc-next.

Thanks!
