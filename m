Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0111.outbound.protection.outlook.com ([207.46.100.111]:6167
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754466AbcFPVZp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jun 2016 17:25:45 -0400
Message-ID: <5763194F.80109@hpe.com>
Date: Thu, 16 Jun 2016 17:25:35 -0400
From: Waiman Long <waiman.long@hpe.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH-tip v2 2/6] locking/rwsem: Stop active read lock ASAP
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com> <1465944489-43440-3-git-send-email-Waiman.Long@hpe.com> <20160615172242.GQ30921@twins.programming.kicks-ass.net> <5761A9DE.6040702@hpe.com> <20160616021436.GA7765@linux-80c1.suse>
In-Reply-To: <20160616021436.GA7765@linux-80c1.suse>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160616212535.N9ElYWjwn3TzIsla1FKx018CrwJ9ZCUVNXggS6GCliQ@z>

On 06/15/2016 10:14 PM, Davidlohr Bueso wrote:
> On Wed, 15 Jun 2016, Waiman Long wrote:
>
>> I think there will be a little bit of performance impact for a 
>> workload that produce just the right amount of rwsem contentions. 
>
> I'm not saying the change doesn't make sense, but this is the sort of
> thing that will show nice numbers in one workload and go bite you in
> another.
>
> Thanks,
> Davidlohr

I would certainly agree if the additional atomic op is in the fastpath. 
Since it is in the slowpath, one additional atomic op will just be a 
small part of the whole rwsem_down_read_failed() function. I doubt if 
the performance degradation, if any, can be even noticeable.

Cheers,
Longman
