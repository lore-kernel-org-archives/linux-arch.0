Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:56618 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbdESTfM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2017 15:35:12 -0400
Date: Fri, 19 May 2017 15:35:09 -0400 (EDT)
Message-ID: <20170519.153509.2070245733064513776.davem@davemloft.net>
Subject: Re: [PATCH 4/6] arch/sparc: Enable queued rwlocks for SPARC
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170519193126.vd52mhacekkhq342@hirez.programming.kicks-ass.net>
References: <20170519090302.ph6jnqzlxxqzrvnu@hirez.programming.kicks-ass.net>
        <20170519.151553.928484900690074462.davem@davemloft.net>
        <20170519193126.vd52mhacekkhq342@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: babu.moger@oracle.com, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170519193509.ewo-92HHKYkA71SdyYEFwDPk9QmGPl4YU7fEr9upEwA@z>

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 19 May 2017 21:31:26 +0200

> On Fri, May 19, 2017 at 03:15:53PM -0400, David Miller wrote:
>> However, I don't see what any of this has to do with the feedback
>> I was giving the patch author :-)
> 
> Uhm,... I think my morning brain read things like you having doubts
> about making it sparc64 only. But I could have easily misread things.
> Ignore my ramblings :-)

He was editing a sparc64-specific header, adding "queued locks" ifdefs,
which makes no sense if for SPARC64 the queued locks will always be
enabled.
