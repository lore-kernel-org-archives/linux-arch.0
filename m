From: Minchan Kim <minchan@kernel.org>
Subject: Re: [lkp-robot] [mm]  7674270022:  will-it-scale.per_process_ops
 -19.3% regression
Date: Tue, 8 Aug 2017 11:28:30 +0900
Message-ID: <20170808022830.GA28570@bbox>
References: <20170802000818.4760-7-namit@vmware.com>
 <20170808011923.GE25554@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170808011923.GE25554@yexl-desktop>
Sender: owner-linux-mm@kvack.org
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Nadav Amit <namit@vmware.com>, linux-mm@kvack.org, nadav.amit@gmail.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, lkp@01.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Tue, Aug 08, 2017 at 09:19:23AM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -19.3% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 76742700225cad9df49f05399381ac3f1ec3dc60 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem")
> url: https://github.com/0day-ci/linux/commits/Nadav-Amit/mm-migrate-prevent-racy-access-to-tlb_flush_pending/20170802-205715
> 
> 
> in testcase: will-it-scale
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> with following parameters:
> 
> 	nr_task: 16
> 	mode: process
> 	test: brk1
> 	cpufreq_governor: performance
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale

Thanks for the report.
Could you explain what kinds of workload you are testing?

Does it calls frequently madvise(MADV_DONTNEED) in parallel on multiple
threads?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
