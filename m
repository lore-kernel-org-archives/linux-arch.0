From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/7] kernel/locking: Fix compile error with qrwlock.c
Date: Mon, 22 May 2017 15:03:28 -0400 (EDT)
Message-ID: <20170522.150328.1597262115447284483.davem@davemloft.net>
References: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
        <1495239421-441642-2-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:55230 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761028AbdEVTDf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2017 15:03:35 -0400
In-Reply-To: <1495239421-441642-2-git-send-email-babu.moger@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: babu.moger@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 19 May 2017 18:16:55 -0600

> Some architectures use the following guard in include file
>  "asm/spinlock_types.h" to discourage including the file directly.
> 
> Saw these compile errors on SPARC when queued rwlock feature is enabled.
> 
>   CC      kernel/locking/qrwlock.o
> In file included from ./include/asm-generic/qrwlock_types.h:5,
>                  from ./arch/sparc/include/asm/qrwlock.h:4,
>                  from kernel/locking/qrwlock.c:24:
> ./arch/sparc/include/asm/spinlock_types.h:5:3: error:
>         #error "please don't include this file directly"
> 
> Re-arrange the includes in qrwlock_types.h and include spinlock.h
> in qrwlock.c to fix it.
> 
> Also will be removing this stanza from SPARC. Stay tuned.
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>

In my feedback I said to remove that check from
sparc's asm/spinlock_types.h header.

Which you do in patch #2

But that means this patch #1 here is no longer necessary, since we
conform to the hearder scheme used by other architectures using queued
locks.

So please remove this patch from the series.

Thank you.
