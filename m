Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:54882 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbdJXJc5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2017 05:32:57 -0400
Date: Tue, 24 Oct 2017 11:32:53 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL de-alpha] Make core code not need to know about Alpha
 for v4.15
Message-ID: <20171024093253.4fx2ev3av7vu7ky5@gmail.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org
Message-ID: <20171024093253.tbo-8gYLb_sfokQ1ZBKMsujWI0InEDkwlnsB1gsIua4@z>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Mark Rutland (14):
>       dm integrity: Kill off ACCESS_ONCE()
>       EDAC, altera: Kill off ACCESS_ONCE()
>       firmware/ivc: Kill off ACCESS_ONCE()
>       fs: dcache: Kill off ACCESS_ONCE()
>       fs: ncpfs: Kill off ACCESS_ONCE()
>       media: dvb_ringbuffer: Kill off ACCESS_ONCE()
>       net: netlink/netfilter: Kill off ACCESS_ONCE()
>       net/ipv4/tcp_input.c: Kill off ACCESS_ONCE()
>       net: average: Kill off ACCESS_ONCE()
>       samples: mic/mpssd/mpssd.c: Kill off ACCESS_ONCE()
>       selftests/powerpc: Kill off ACCESS_ONCE()
>       workqueue: Kill off ACCESS_ONCE()
>       rcutorture: formal: Prepare for ACCESS_ONCE() removal
>       COCCINELLE: treewide: kill off ACCESS_ONCE()
> 
> Paul E. McKenney (3):
>       doc: filesystems: Kill off ACCESS_ONCE()
>       mm: Kill off ACCESS_ONCE()

Quick question: are there any ACCESS_ONCE() users left after this? If not then we 
should add a separate patch that either removes it, or at least adds a build time 
warning which should trigger with new users.

Thanks,

	Ingo
