From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 2/2] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Wed, 10 Jun 2015 12:28:19 -0400
Message-ID: <557865A3.9080107@hp.com>
References: <1433863153-30722-1-git-send-email-Waiman.Long@hp.com> <1433863153-30722-3-git-send-email-Waiman.Long@hp.com> <20150610073512.GA17226@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020306000407080007030307"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150610073512.GA17226@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

This is a multi-part message in MIME format.
--------------020306000407080007030307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2015 03:35 AM, Ingo Molnar wrote:
> * Waiman Long<Waiman.Long@hp.com>  wrote:
>
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
> Mind posting the microbenchmark?
>
> Thanks,
>
> 	Ingo

I have attached the tool that I used for testing.

Cheers,
Longman

--------------020306000407080007030307
Content-Type: application/x-gzip;
 name="locktest.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="locktest.tar.gz"

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
cNbHAHgAAA==
--------------020306000407080007030307--
