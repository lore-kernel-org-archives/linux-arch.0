Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36825 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbdGFSne (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 14:43:34 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so2364755wrb.3
        for <linux-arch@vger.kernel.org>; Thu, 06 Jul 2017 11:43:33 -0700 (PDT)
Subject: Re: [PATCH RFC 01/26] netfilter: Replace spin_unlock_wait() with
 lock/unlock pair
References: <Pine.LNX.4.44L0.1707031543170.2027-100000@iolanthe.rowland.org>
From: Manfred Spraul <manfred@colorfullife.com>
Message-ID: <ee509620-8ba5-be45-743e-f077a457c01d@colorfullife.com>
Date: Thu, 6 Jul 2017 20:43:28 +0200
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1707031543170.2027-100000@iolanthe.rowland.org>
Content-Type: multipart/mixed;
 boundary="------------564DE116543083334572D59F"
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, parri.andrea@gmail.com, torvalds@linux-foundation.org, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, coreteam@netfilter.org, 1vier1@web.de
Message-ID: <20170706184328.7OJIUgtmjXrMQCcXYAmuMxjalqOcCw1AQnnaK9EcqwQ@z>

This is a multi-part message in MIME format.
--------------564DE116543083334572D59F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alan,

On 07/03/2017 09:57 PM, Alan Stern wrote:
>
> (Alternatively, you could make nf_conntrack_all_unlock() do a
> lock+unlock on all the locks in the array, just like
> nf_conntrack_all_lock().  But of course, that would be a lot less
> efficient.)
Hmmmm.

Someone with a weakly ordered system who can test this?
semop() has a very short hotpath.

Either with aim9.shared_memory.ops_per_sec or

#sem-scalebench -t 10 -m 0
https://github.com/manfred-colorfu/ipcscale/blob/master/sem-scalebench.cpp
--
     Manfred

--------------564DE116543083334572D59F
Content-Type: text/x-patch;
 name="0002-ipc-sem.c-avoid-smp_load_acuqire-in-the-hot-path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ipc-sem.c-avoid-smp_load_acuqire-in-the-hot-path.patch"


--------------564DE116543083334572D59F--
