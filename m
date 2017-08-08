From: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [lkp-robot] [mm]  7674270022:  will-it-scale.per_process_ops
 -19.3% regression
Date: Mon, 7 Aug 2017 21:23:34 -0700
Message-ID: <93CA4B47-95C2-43A2-8E92-B142CAB1DAF7@gmail.com>
References: <20170802000818.4760-7-namit@vmware.com>
 <20170808011923.GE25554@yexl-desktop> <20170808022830.GA28570@bbox>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170808022830.GA28570@bbox>
Sender: owner-linux-mm@kvack.org
To: Minchan Kim <minchan@kernel.org>
Cc: kernel test robot <xiaolong.ye@intel.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, lkp@01.org
List-Id: linux-arch.vger.kernel.org

Minchan Kim <minchan@kernel.org> wrote:

> Hi,
>=20
> On Tue, Aug 08, 2017 at 09:19:23AM +0800, kernel test robot wrote:
>> Greeting,
>>=20
>> FYI, we noticed a -19.3% regression of will-it-scale.per_process_ops =
due to commit:
>>=20
>>=20
>> commit: 76742700225cad9df49f05399381ac3f1ec3dc60 ("mm: fix =
MADV_[FREE|DONTNEED] TLB flush miss problem")
>> url: =
https://github.com/0day-ci/linux/commits/Nadav-Amit/mm-migrate-prevent-rac=
y-access-to-tlb_flush_pending/20170802-205715
>>=20
>>=20
>> in testcase: will-it-scale
>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz =
with 64G memory
>> with following parameters:
>>=20
>> 	nr_task: 16
>> 	mode: process
>> 	test: brk1
>> 	cpufreq_governor: performance
>>=20
>> test-description: Will It Scale takes a testcase and runs it from 1 =
through to n parallel copies to see if the testcase will scale. It =
builds both a process and threads based test in order to see any =
differences between the two.
>> test-url: https://github.com/antonblanchard/will-it-scale
>=20
> Thanks for the report.
> Could you explain what kinds of workload you are testing?
>=20
> Does it calls frequently madvise(MADV_DONTNEED) in parallel on =
multiple
> threads?

According to the description it is "testcase:brk increase/decrease of =
one
page=E2=80=9D. According to the mode it spawns multiple processes, not =
threads.

Since a single page is unmapped each time, and the iTLB-loads increase
dramatically, I would suspect that for some reason a full TLB flush is
caused during do_munmap().

If I find some free time, I=E2=80=99ll try to profile the workload - but =
feel free
to beat me to it.

Nadav=20

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
