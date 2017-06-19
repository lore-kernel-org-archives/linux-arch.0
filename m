Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34323 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbdFSU1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 16:27:55 -0400
Received: by mail-pf0-f171.google.com with SMTP id s66so58839626pfs.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Jun 2017 13:27:50 -0700 (PDT)
Date: Mon, 19 Jun 2017 13:27:48 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 0/7] rwsem: Implement down_read_killable()
In-Reply-To: <149789463636.9059.16943955939303454611.stgit@localhost.localdomain>
Message-ID: <alpine.DEB.2.10.1706191327190.95967@chino.kir.corp.google.com>
References: <149789463636.9059.16943955939303454611.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: linux-ia64@vger.kernel.org, avagin@virtuozzo.com, peterz@infradead.org, heiko.carstens@de.ibm.com, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net
Message-ID: <20170619202748.axAmZrM_5C_bVuyxH_NWtl-lhPl8TC3Zv5UwzgXf7NU@z>

On Mon, 19 Jun 2017, Kirill Tkhai wrote:

> This series implements killable version of down_read()
> similar to already existing down_write_killable() function.
> Patches [1-2/7] add arch-independent low-level primitives
> for the both rwsem types.
> 
> Patches [3-6/7] add arch-dependent primitives for
> the architectures, that use rwsem-xadd implementation.
> The assembly code was modified in x86 case only, the rest
> of architectures does not need such change.
> 
> I tested the series in x86 (which uses RWSEM_XCHGADD_ALGORITHM
> config option), and also the RWSEM_GENERIC_SPINLOCK case,
> which were manually written in Kconfig. alpha, ia64 and s390
> are compile-tested only, but I believe, their changes are
> pretty easy. Please, people, who work with them, take your
> look at the corresponding patches.
> 

I would have expected to see down_read_killable() actually used somewhere 
after its implementation as part of this patchset.
