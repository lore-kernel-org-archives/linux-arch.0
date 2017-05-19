Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55946 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdESTbh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2017 15:31:37 -0400
Date: Fri, 19 May 2017 21:31:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/6] arch/sparc: Enable queued rwlocks for SPARC
Message-ID: <20170519193126.vd52mhacekkhq342@hirez.programming.kicks-ass.net>
References: <1495154170-854693-5-git-send-email-babu.moger@oracle.com>
 <20170518.223113.1783186374793423172.davem@davemloft.net>
 <20170519090302.ph6jnqzlxxqzrvnu@hirez.programming.kicks-ass.net>
 <20170519.151553.928484900690074462.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170519.151553.928484900690074462.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: babu.moger@oracle.com, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170519193126.aHo4rMVoOEbSSCTW_uiiB1EACQ-0cFG-Cn7A-GZ-mNc@z>

On Fri, May 19, 2017 at 03:15:53PM -0400, David Miller wrote:
> However, I don't see what any of this has to do with the feedback
> I was giving the patch author :-)

Uhm,... I think my morning brain read things like you having doubts
about making it sparc64 only. But I could have easily misread things.
Ignore my ramblings :-)
