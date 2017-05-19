From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/6] kernel/locking: Fix compile error with qrwlock.c
Date: Thu, 18 May 2017 22:27:53 -0400 (EDT)
Message-ID: <20170518.222753.1822313785663789393.davem@davemloft.net>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
        <1495154170-854693-2-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1495154170-854693-2-git-send-email-babu.moger@oracle.com>
Sender: sparclinux-owner@vger.kernel.org
To: babu.moger@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 18 May 2017 18:36:05 -0600

> Seeing this error on SPARC while compiling qrwlock.c.
> 
>   CC      kernel/locking/qrwlock.o
> In file included from ./include/asm-generic/qrwlock_types.h:5,
>                  from ./arch/sparc/include/asm/qrwlock.h:4,
>                  from kernel/locking/qrwlock.c:24:
> ./arch/sparc/include/asm/spinlock_types.h:5:3: error:
>         #error "please don't include this file directly"
> 
> Re-arrange the includes in qrwlock_types.h and also include spinlock.h
> in qrwlock.c to fix it. This should also help other architectures when
> queued rwlock is enabled.
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>

I think you can simply remove the:

#ifndef __LINUX_SPINLOCK_TYPES_H
# error "please don't include this file directly"
#endif

stanza from the sparc header file instead.  Other architectures
don't use this guard.
