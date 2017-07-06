Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35755 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdGFSqE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 14:46:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id z45so2404359wrb.2
        for <linux-arch@vger.kernel.org>; Thu, 06 Jul 2017 11:46:03 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] net/netfilter/nf_conntrack_core: Fix
 net_conntrack_lock()
References: <20170705232955.GA15992@linux.vnet.ibm.com>
 <1499297503-23852-1-git-send-email-paulmck@linux.vnet.ibm.com>
From: Manfred Spraul <manfred@colorfullife.com>
Message-ID: <113516eb-8615-4468-0127-1a491d34c83c@colorfullife.com>
Date: Thu, 6 Jul 2017 20:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <1499297503-23852-1-git-send-email-paulmck@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------8805E1252AD032F77ACB3F79"
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, stable@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>, Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20170706184559.kqJMrgzjO6IvHTKfMnJyBATTxehWk6bzNzveRN28dkI@z>

This is a multi-part message in MIME format.
--------------8805E1252AD032F77ACB3F79
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,

On 07/06/2017 01:31 AM, Paul E. McKenney wrote:
> From: Manfred Spraul <manfred@colorfullife.com>
>
> As we want to remove spin_unlock_wait() and replace it with explicit
> spin_lock()/spin_unlock() calls, we can use this to simplify the
> locking.
>
> In addition:
> - Reading nf_conntrack_locks_all needs ACQUIRE memory ordering.
> - The new code avoids the backwards loop.
>
> Only slightly tested, I did not manage to trigger calls to
> nf_conntrack_all_lock().

If you want:
Attached would be V2, with adapted comments.

--
     Manfred

--------------8805E1252AD032F77ACB3F79
Content-Type: text/x-patch;
 name="0001-net-netfilter-nf_conntrack_core-Fix-net_conntrack_lo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-net-netfilter-nf_conntrack_core-Fix-net_conntrack_lo.pa";
 filename*1="tch"


--------------8805E1252AD032F77ACB3F79--
