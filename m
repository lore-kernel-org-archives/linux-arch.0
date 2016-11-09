From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
Date: Wed, 9 Nov 2016 15:26:50 +0530
Message-ID: <20161109095650.GA22804@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <libc-alpha-return-74567-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <20161107082359.GA19666@yury-N73SV>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Adhemerval Zanella <adhemerval.zanella@linaro.org>, Steve Ellcey <sellcey@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 07, 2016 at 01:53:59PM +0530, Yury Norov wrote:
> Hi all,
> 
> [add libc-alpha mail list]
> 
> For libc-alpha: this is the part of LKML submission with latest
> patches for aarch64/ilp32.
> https://www.spinics.net/lists/arm-kernel/msg537846.html
> 
> Glibc that I use has also included consolidation patches from Adhemerval
> Zanella and me that are still not in the glibc master. The full series is:
> https://github.com/norov/glibc/tree/ilp32-2.24-dev2
> 
> Below is the results of glibc testsuite run for aarch64/lp64
> in different configurations. Column names meaning:
> kvgv: kernel is vanilla, glibc is vanilla;
> kdgv: kernel has ilp32 patches applied, but ilp32 is disabled in config; 
>       glibc is vanilla;
> kegv: kernel has ilp32 patches applied and ilp32 is enabled, glibc is vanilla;
> kege: kernel patches are applied and enabled, glibc patches are applied.
> 
> Only different lines are shown. Full results are in attached archive. 
 
The same, plus ILP32 regressions:

Test					kvgv	kdgv	kegv	kege	ilp32
conform/ISO/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
conform/ISO11/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
conform/ISO99/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
conform/POSIX/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
conform/POSIX/sys/stat.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
conform/UNIX98/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
conform/XOPEN2K/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
conform/XPG3/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
conform/XPG4/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	FAIL
csu/tst-atomic				PASS 	PASS 	PASS	FAIL	PASS
elf/check-localplt			PASS 	PASS 	PASS	FAIL	FAIL
iconvdata/mtrace-tst-loading		PASS	FAIL	PASS 	PASS	FAIL
iconvdata/tst-loading			PASS	FAIL	PASS 	PASS	PASS
io/check-installed-headers-c		PASS 	PASS 	PASS	FAIL	FAIL
io/check-installed-headers-cxx		PASS 	PASS 	PASS	FAIL	FAIL
malloc/tst-malloc-backtrace		FAIL	PASS	PASS	PASS	PASS
malloc/tst-malloc-thread-exit		FAIL	PASS	PASS	PASS	PASS
malloc/tst-malloc-usable		FAIL	PASS	PASS	PASS	PASS
malloc/tst-mallocfork			FAIL	PASS	PASS	PASS	PASS
malloc/tst-mallocstate			FAIL	PASS	PASS	PASS	PASS
malloc/tst-mallopt			FAIL	PASS	PASS	PASS	PASS
malloc/tst-mcheck			FAIL	PASS	PASS	PASS	PASS
malloc/tst-memalign			FAIL	PASS	PASS	PASS	PASS
malloc/tst-obstack			FAIL	PASS	PASS	PASS	PASS
malloc/tst-posix_memalign		FAIL	PASS	PASS	PASS	PASS
malloc/tst-pvalloc			FAIL	PASS	PASS	PASS	PASS
malloc/tst-realloc			FAIL	PASS	PASS	PASS	PASS
malloc/tst-scratch_buffer		FAIL	PASS	PASS	PASS	PASS
malloc/tst-trim1			FAIL	PASS	PASS	PASS	PASS
nptl/tst-eintr4				PASS 	PASS 	PASS	NA	NA
posix/tst-regex2			PASS	FAIL	FAIL	FAIL	FAIL
posix/tst-getaddrinfo4			PASS	PASS	FAIL	FAIL	PASS
posix/tst-getaddrinfo5			PASS	PASS	FAIL	FAIL	PASS
sysvipc/test-sysvmsg			NA	NA	NA	FAIL	PASS
sysvipc/test-sysvsem			NA	NA	NA	FAIL	PASS
sysvipc/test-sysvshm			NA	NA	NA	FAIL	PASS

c++-types-check				PASS	PASS	PASS	PASS	FAIL
debug/tst-backtrace4			PASS	PASS	PASS	PASS	FAIL
elf/check-abi-libc			PASS	PASS	PASS	PASS	FAIL
elf/tst-tls1				PASS	PASS	PASS	PASS	FAIL
elf/tst-tls1-static			PASS	PASS	PASS	PASS	FAIL
elf/tst-tls2				PASS	PASS	PASS	PASS	FAIL
elf/tst-tls2-static			PASS	PASS	PASS	PASS	FAIL
elf/tst-tls3				PASS	PASS	PASS	PASS	FAIL
math/check-abi-libm			PASS	PASS	PASS	PASS	FAIL
misc/tst-writev				PASS	PASS	PASS	PASS   	NA  
nptl/tst-cancel-self-canceltype		PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel1			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel10			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel11			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel13			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel15			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel16			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel17			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel18			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel2			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel20			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel21			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel24			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel25			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel26			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel27			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel3			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel4			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel5			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel6			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancel7			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx10			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx11			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx13			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx15			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx16			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx17			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx18			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx2			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx20			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx21			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx3			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx4			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx5			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx6			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cancelx7			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cleanup4			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cleanupx4			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cond-except			PASS	PASS	PASS	PASS	FAIL
nptl/tst-cond7				PASS	PASS	PASS	PASS	FAIL
nptl/tst-cond8				PASS	PASS	PASS	PASS	FAIL
nptl/tst-fini1				PASS	PASS	PASS	PASS	FAIL
nptl/tst-initializers1			PASS	PASS	PASS	PASS	FAIL
nptl/tst-initializers1-c11		PASS	PASS	PASS	PASS	FAIL
nptl/tst-initializers1-c89		PASS	PASS	PASS	PASS	FAIL
nptl/tst-initializers1-c99		PASS	PASS	PASS	PASS	FAIL
nptl/tst-initializers1-gnu11		PASS	PASS	PASS	PASS	FAIL
nptl/tst-initializers1-gnu89		PASS	PASS	PASS	PASS	FAIL
nptl/tst-initializers1-gnu99		PASS	PASS	PASS	PASS	FAIL
nptl/tst-join5				PASS	PASS	PASS	PASS	FAIL
nptl/tst-key3				PASS	PASS	PASS	PASS	FAIL
nptl/tst-mutex8				PASS	PASS	PASS	PASS	FAIL
nptl/tst-mutexpi8			PASS	PASS	PASS	PASS	FAIL
nptl/tst-once3				PASS	PASS	PASS	PASS	FAIL
nptl/tst-once4				PASS	PASS	PASS	PASS	FAIL
nptl/tst-oncex3				PASS	PASS	PASS	PASS	FAIL
nptl/tst-oncex4				PASS	PASS	PASS	PASS	FAIL
nptl/tst-rwlock15			PASS	PASS	PASS	PASS	FAIL
nptl/tst-rwlock8			PASS	PASS	PASS	PASS	FAIL
nptl/tst-rwlock9			PASS	PASS	PASS	PASS	FAIL
nptl/tst-sem11				PASS	PASS	PASS	PASS	FAIL
nptl/tst-sem12				PASS	PASS	PASS	PASS	FAIL
posix/bug-regex24			PASS	PASS	PASS	PASS	FAIL
rt/tst-mqueue1				PASS	PASS	PASS	PASS	FAIL
rt/tst-mqueue2				PASS	PASS	PASS	PASS	FAIL
rt/tst-mqueue4				PASS	PASS	PASS	PASS	FAIL
rt/tst-mqueue7				PASS	PASS	PASS	PASS	FAIL
rt/tst-mqueue8				PASS	PASS	PASS	PASS	FAIL
rt/tst-mqueue8x				PASS	PASS	PASS	PASS	FAIL
stdlib/tst-makecontext3			PASS	PASS	PASS	PASS	FAIL
