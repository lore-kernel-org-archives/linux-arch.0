From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/2] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Wed, 10 Jun 2015 09:35:12 +0200
Message-ID: <20150610073512.GA17226@gmail.com>
References: <1433863153-30722-1-git-send-email-Waiman.Long@hp.com>
 <1433863153-30722-3-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36268 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbbFJHfR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jun 2015 03:35:17 -0400
Content-Disposition: inline
In-Reply-To: <1433863153-30722-3-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>


* Waiman Long <Waiman.Long@hp.com> wrote:

> The current cmpxchg() loop in setting the _QW_WAITING flag for writers
> in queue_write_lock_slowpath() will contend with incoming readers
> causing possibly extra cmpxchg() operations that are wasteful. This
> patch changes the code to do a byte cmpxchg() to eliminate contention
> with new readers.
> 
> A multithreaded microbenchmark running 5M read_lock/write_lock loop
> on a 8-socket 80-core Westmere-EX machine running 4.0 based kernel
> with the qspinlock patch have the following execution times (in ms)
> with and without the patch:
> 
> With R:W ratio = 5:1
> 
> 	Threads	   w/o patch	with patch	% change
> 	-------	   ---------	----------	--------
> 	   2	     990 	    895		  -9.6%
> 	   3	    2136 	   1912		 -10.5%
> 	   4	    3166	   2830		 -10.6%
> 	   5	    3953	   3629		  -8.2%
> 	   6	    4628	   4405		  -4.8%
> 	   7	    5344	   5197		  -2.8%
> 	   8	    6065	   6004		  -1.0%
> 	   9	    6826	   6811		  -0.2%
> 	  10	    7599	   7599		   0.0%
> 	  15	    9757	   9766		  +0.1%
> 	  20	   13767	  13817		  +0.4%
> 
> With small number of contending threads, this patch can improve
> locking performance by up to 10%. With more contending threads,
> however, the gain diminishes.

Mind posting the microbenchmark?

Thanks,

	Ingo
