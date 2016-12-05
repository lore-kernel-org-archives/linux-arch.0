From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
Date: Mon, 5 Dec 2016 17:58:09 +0800
Message-ID: <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV> <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
 <1479419136.908.90.camel@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <libc-alpha-return-75455-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1479419136.908.90.camel@caviumnetworks.com>
To: Steve Ellcey <sellcey@caviumnetworks.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, "Dr.
 Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, zh
List-Id: linux-arch.vger.kernel.org

Hi, Steve

On 2016/11/18 5:45, Steve Ellcey wrote:
> On Wed, 2016-11-16 at 15:22 +0400, Maxim Kuvyrkov wrote:
>>>
>>> On Nov 9, 2016, at 1:56 PM, Yury Norov <ynorov@caviumnetworks.com>
>>> wrote:
>>>
>>>>
>>>> Below is the results of glibc testsuite run for aarch64/lp64
>
> I have been running the glibc testsuite as well.  I have only run it on
> an ILP32 enabled kernel.  Using that kernel, top-of-tree glibc, and the
> ILP32 glibc patches I have no LP64 regressions.  There are 5 failures
> in LP64 mode but I get them with vanilla top-of-tree glibc sources too.
> They are:
> 	nptl/eintr1 (I actually don't run this because it kills the 'make check')
> 	debug/tst-backtrace5
> 	debug/tst-backtrace6
> 	nptl/tst-stack4
> 	nptl/tst-thread_local1
>
> In ILP32 mode I get 33 failures, they include the above failures (minus
> nptl/tst-thread_local1) plus:
>
> 	c++-types-check
> 	conform/ISO11/inttypes.h/conform
> 	conform/ISO11/stdint.h/conform
> 	conform/ISO99/inttypes.h/conform
> 	conform/ISO99/stdint.h/conform
> 	conform/POSIX2008/inttypes.h/conform
> 	conform/POSIX2008/stdint.h/conform
> 	conform/XOPEN2K/inttypes.h/conform
> 	conform/XOPEN2K/stdint.h/conform
> 	conform/XOPEN2K8/inttypes.h/conform
> 	conform/XOPEN2K8/stdint.h/conform
> 	elf/tst-tls1
> 	elf/tst-tls1-static
> 	elf/tst-tls2
> 	elf/tst-tls2-static
> 	elf/tst-tls3
> 	math/check-abi-libm
> 	math/test-double
> 	math/test-double-finite
> 	math/test-float
> 	math/test-float-finite
> 	misc/tst-sync_file_range
> 	nptl/tst-cancel26
> 	nptl/tst-cancel27
> 	nptl/tst-sem3
> 	rt/tst-mqueue1
> 	rt/tst-mqueue2
> 	rt/tst-mqueue4
> 	rt/tst-mqueue7
> 	stdlib/tst-makecontext3
>
> I am currently looking at these ILP32 regressions (starting with the
> tls failures) to see if I can figure out what is happening with them.
Is there some progresses on it? We could collabrate to fix those issues.

Regards

Bamvor
>
> Steve Ellcey
> sellcey@caviumnetworks.com
>
