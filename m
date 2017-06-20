Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbdFTIaV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jun 2017 04:30:21 -0400
In-Reply-To: <alpine.DEB.2.10.1706191327190.95967@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1706191327190.95967@chino.kir.corp.google.com> <149789463636.9059.16943955939303454611.stgit@localhost.localdomain>
Subject: Re: [PATCH 0/7] rwsem: Implement down_read_killable()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <407.1497945958.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Tue, 20 Jun 2017 09:30:14 +0100
Message-ID: <2406.1497947414@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: dhowells@redhat.com, Kirill Tkhai <ktkhai@virtuozzo.com>, linux-ia64@vger.kernel.org, avagin@virtuozzo.com, peterz@infradead.org, heiko.carstens@de.ibm.com, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net
Message-ID: <20170620083014.Cy3x6k3hqjJmfdkM_cr95BZNckwKaRDWvoCqRJMHmtQ@z>

David Rientjes <rientjes@google.com> wrote:

> I would have expected to see down_read_killable() actually used somewhere 
> after its implementation as part of this patchset.

There are some places we should be using down_{read|write}_interruptible(), if
it existed, dressed as inode_lock{,_shared}_interruptible().

David
