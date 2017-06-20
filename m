Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve1eur01on0125.outbound.protection.outlook.com ([104.47.1.125]:54303
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750992AbdFTKhE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jun 2017 06:37:04 -0400
Date: Tue, 20 Jun 2017 13:36:50 +0300
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/7] rwsem: Implement down_read_killable()
Message-ID: <20170620103648.vi7v45mjk63msw72@virtuozzo.com>
References: <alpine.DEB.2.10.1706191327190.95967@chino.kir.corp.google.com>
 <149789463636.9059.16943955939303454611.stgit@localhost.localdomain>
 <2406.1497947414@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2406.1497947414@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: David Rientjes <rientjes@google.com>, linux-ia64@vger.kernel.org, avagin@virtuozzo.com, peterz@infradead.org, heiko.carstens@de.ibm.com, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net
Message-ID: <20170620103650.n2E0hyuEgTdm2fqiYWWmQjK3xO2AyU6mg-J_IWurL9A@z>

On Tue, Jun 20, 2017 at 09:30, David Howells wrote:
> David Rientjes <rientjes@google.com> wrote:
> 
> > I would have expected to see down_read_killable() actually used somewhere 
> > after its implementation as part of this patchset.
> 
> There are some places we should be using down_{read|write}_interruptible(), if
> it existed, dressed as inode_lock{,_shared}_interruptible().

Then let's use it in iterate_dir():

[PATCH]fs: Use killable down_read() in iterate_dir()

There was mutex_lock_interruptible() initially, and it was changed
to rwsem, but there were not killable rwsem primitives that time.
