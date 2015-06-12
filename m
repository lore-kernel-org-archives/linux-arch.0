From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/2] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Fri, 12 Jun 2015 10:45:43 +0200
Message-ID: <20150612084543.GA24472@gmail.com>
References: <1433863153-30722-1-git-send-email-Waiman.Long@hp.com>
 <1433863153-30722-3-git-send-email-Waiman.Long@hp.com>
 <20150610073512.GA17226@gmail.com>
 <557865A3.9080107@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37764 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbFLIps (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jun 2015 04:45:48 -0400
Content-Disposition: inline
In-Reply-To: <557865A3.9080107@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>


* Waiman Long <waiman.long@hp.com> wrote:

> > Mind posting the microbenchmark?
> 
> I have attached the tool that I used for testing.

Thanks, that's interesting!

Btw., we could also do something like this in user-space, in tools/perf/bench/, we 
have no 'perf bench locking' subcommand yet.

We already build and measure simple x86 kernel methods there such as memset() and 
memcpy():

 triton:~/tip> perf bench mem memcpy -r all
 # Running 'mem/memcpy' benchmark:

 Routine default (Default memcpy() provided by glibc)
 # Copying 1MB Bytes ...

       1.385195 GB/Sec
       4.982462 GB/Sec (with prefault)

 Routine x86-64-unrolled (unrolled memcpy() in arch/x86/lib/memcpy_64.S)
 # Copying 1MB Bytes ...

       1.627604 GB/Sec
       5.336407 GB/Sec (with prefault)

 Routine x86-64-movsq (movsq-based memcpy() in arch/x86/lib/memcpy_64.S)
 # Copying 1MB Bytes ...

       2.132233 GB/Sec
       4.264465 GB/Sec (with prefault)

 Routine x86-64-movsb (movsb-based memcpy() in arch/x86/lib/memcpy_64.S)
 # Copying 1MB Bytes ...

       1.490935 GB/Sec
       7.128193 GB/Sec (with prefault)

Locking primitives would certainly be more complex build in user-space - but we 
could shuffle things around in kernel headers as well to make it easier to test in 
user-space.

That's how we can build lockdep in user-space for example, see tools/lib/lockdep.

Just a thought.

Thanks,

	Ingo
