From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 3/3] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Thu, 25 Jun 2015 16:33:36 -0400
Message-ID: <558C65A0.5040005@hp.com>
References: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com> <1434729002-57724-4-git-send-email-Waiman.Long@hp.com> <20150625183521.GV19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:10078 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbbFYUdi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2015 16:33:38 -0400
In-Reply-To: <20150625183521.GV19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 06/25/2015 02:35 PM, Peter Zijlstra wrote:
> On Fri, Jun 19, 2015 at 11:50:02AM -0400, Waiman Long wrote:
>> The current cmpxchg() loop in setting the _QW_WAITING flag for writers
>> in queue_write_lock_slowpath() will contend with incoming readers
>> causing possibly extra cmpxchg() operations that are wasteful. This
>> patch changes the code to do a byte cmpxchg() to eliminate contention
>> with new readers.
>>
>> A multithreaded microbenchmark running 5M read_lock/write_lock loop
>> on a 8-socket 80-core Westmere-EX machine running 4.0 based kernel
>> with the qspinlock patch have the following execution times (in ms)
>> with and without the patch:
>>
>> With R:W ratio = 5:1
>>
>> 	Threads	   w/o patch	with patch	% change
>> 	-------	   ---------	----------	--------
>> 	   2	     990 	    895		  -9.6%
>> 	   3	    2136 	   1912		 -10.5%
>> 	   4	    3166	   2830		 -10.6%
>> 	   5	    3953	   3629		  -8.2%
>> 	   6	    4628	   4405		  -4.8%
>> 	   7	    5344	   5197		  -2.8%
>> 	   8	    6065	   6004		  -1.0%
>> 	   9	    6826	   6811		  -0.2%
>> 	  10	    7599	   7599		   0.0%
>> 	  15	    9757	   9766		  +0.1%
>> 	  20	   13767	  13817		  +0.4%
>>
>> With small number of contending threads, this patch can improve
>> locking performance by up to 10%. With more contending threads,
>> however, the gain diminishes.
>>
>> With the extended qrwlock structure defined in asm-generic/qrwlock,
>> the queue_write_unlock() function is also simplified to a
>> smp_store_release() call.
>>
>> Signed-off-by: Waiman Long<Waiman.Long@hp.com>
> This one does not in fact apply, seeing how I applied a previous
> version.
>
> Please send an incremental patch if you still want to change things to
> this form.

I saw that Ingo has merged a previous version of the patch. I am fine 
with that version. As Will is working on a qrwlock patch to enable ARM 
to use it, I will let him make the structure move to qrwlock.h if he 
choose to do so.

Cheers,
Longman
