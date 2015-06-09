From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 2/2] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Tue, 09 Jun 2015 11:23:06 -0400
Message-ID: <557704DA.9070106@hp.com>
References: <1433802045-21298-1-git-send-email-Waiman.Long@hp.com> <1433802045-21298-3-git-send-email-Waiman.Long@hp.com> <20150609120420.GV3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:51047 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbFIPXM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 11:23:12 -0400
In-Reply-To: <20150609120420.GV3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 06/09/2015 08:04 AM, Peter Zijlstra wrote:
> On Mon, Jun 08, 2015 at 06:20:44PM -0400, Waiman Long wrote:
>> The current cmpxchg() loop in setting the _QW_WAITING flag for writers
>> in queue_write_lock_slowpath() will contend with incoming readers
>> causing possibly extra cmpxchg() operations that are wasteful. This
>> patch changes the code to do a byte cmpxchg() to eliminate contention
>> with new readers.
> This is very narrow, would not the main cost still be the cacheline
> transfers?
>
> Do you have any numbers to back this? I would feel much better about
> this if there's real numbers attached.

I have just sent out a v2 patch with the microbenchmark data for the 2nd 
patch. The extra cmpxchg() because of reader contention should have 
about the same cost of a cacheline miss. The performance gain depends on 
how often this kind of reader contention happens.

Regards,
Longman
