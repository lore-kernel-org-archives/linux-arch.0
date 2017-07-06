Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56745 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdGFIFD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 04:05:03 -0400
Date: Thu, 6 Jul 2017 10:04:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/7] rwsem-spinlock: Add killable versions of
 rwsem_down_read_failed()
Message-ID: <20170706080447.a7emouoysilqex4p@hirez.programming.kicks-ass.net>
References: <149789463636.9059.16943955939303454611.stgit@localhost.localdomain>
 <149789534632.9059.2901382369609922565.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149789534632.9059.2901382369609922565.stgit@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: linux-ia64@vger.kernel.org, avagin@virtuozzo.com, heiko.carstens@de.ibm.com, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net
Message-ID: <20170706080447.CL5aGxD_kRc_D3azrRQqqD_283hR6-54Y3UOaXqwiYo@z>

On Mon, Jun 19, 2017 at 09:02:26PM +0300, Kirill Tkhai wrote:

> Subject: [PATCH 2/7] rwsem-spinlock: Add killable versions of rwsem_down_read_failed()

>  kernel/locking/rwsem-xadd.c |   33 ++++++++++++++++++++++++++++++---

Fixed that subject for your ;-)
