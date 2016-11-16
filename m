From: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
Date: Wed, 16 Nov 2016 15:22:26 +0400
Message-ID: <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV> <20161109095650.GA22804@yury-N73SV>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33270 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbcKPLW6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2016 06:22:58 -0500
Received: by mail-qt0-f173.google.com with SMTP id p16so96383092qta.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Nov 2016 03:22:58 -0800 (PST)
In-Reply-To: <20161109095650.GA22804@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, zho

> On Nov 9, 2016, at 1:56 PM, Yury Norov <ynorov@caviumnetworks.com> =
wrote:
>=20
> On Mon, Nov 07, 2016 at 01:53:59PM +0530, Yury Norov wrote:
>> Hi all,
>>=20
>> [add libc-alpha mail list]
>>=20
>> For libc-alpha: this is the part of LKML submission with latest
>> patches for aarch64/ilp32.
>> https://www.spinics.net/lists/arm-kernel/msg537846.html
>>=20
>> Glibc that I use has also included consolidation patches from =
Adhemerval
>> Zanella and me that are still not in the glibc master. The full =
series is:
>> https://github.com/norov/glibc/tree/ilp32-2.24-dev2
>>=20
>> Below is the results of glibc testsuite run for aarch64/lp64
>> in different configurations. Column names meaning:
>> kvgv: kernel is vanilla, glibc is vanilla;
>> kdgv: kernel has ilp32 patches applied, but ilp32 is disabled in =
config;=20
>>      glibc is vanilla;
>> kegv: kernel has ilp32 patches applied and ilp32 is enabled, glibc is =
vanilla;
>> kege: kernel patches are applied and enabled, glibc patches are =
applied.
>>=20
>> Only different lines are shown. Full results are in attached archive.=20=


Hi Yury,

The general requirement merging ILP32 glibc patches is that LP64 does =
not regress in any reasonable configuration.  This means that there =
should be 0 regressions between kvgv and kvge -- i.e., glibc in LP64 =
mode with and without ILP32 patches does not regress on the vanilla =
kernel.  The kvge configuration is not in your testing matrix, and I =
suggest you make sure it has no regressions before fixing the more =
"advanced" configuration of kege.

Ideally, there should be no regressions between kvgv and kege =
configurations, but I don't consider this to a requirement for glibc =
acceptance of ILP32 patches, since any regressions between kvge and kege =
configurations are likely to be on the kernel side.

Speculating on the kernel requirements for ILP32 kernel patchset, I =
think there should be 0 regressions between kvgv and kdgv =
configurations, where you have only 3 tests to investigate and fix.

[I do appreciate that there are progressions in your results as well, =
but the glibc policy is that they do not offset regressions.]

The above only concerns LP64 support in kernel and glibc.

Regarding ILP32 runtime, my opinion is that it is acceptable for ILP32 =
to have extra failures compared to LP64, since these are not =
regressions, but, rather, failures of a new configuration.  =46rom a =
superficial glance is seems that ILP32 linknamespace support requires =
attention, as well as stack unwinding (judging from NPTL failures).


--
Maxim Kuvyrkov
www.linaro.org



>=20
> The same, plus ILP32 regressions:
>=20
> Test					kvgv	kdgv	kegv	kege	=
ilp32
> conform/ISO/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	=
FAIL
> conform/ISO11/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	=
FAIL
> conform/ISO99/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	=
FAIL
> conform/POSIX/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	=
FAIL
> conform/POSIX/sys/stat.h/linknamespace	PASS 	PASS 	PASS	=
FAIL	FAIL
> conform/UNIX98/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	=
FAIL
> conform/XOPEN2K/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	=
FAIL
> conform/XPG3/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	=
FAIL
> conform/XPG4/stdio.h/linknamespace	PASS 	PASS 	PASS	FAIL	=
FAIL
> csu/tst-atomic				PASS 	PASS 	PASS	=
FAIL	PASS
> elf/check-localplt			PASS 	PASS 	PASS	FAIL	=
FAIL
> iconvdata/mtrace-tst-loading		PASS	FAIL	PASS 	PASS	=
FAIL
> iconvdata/tst-loading			PASS	FAIL	PASS 	PASS	=
PASS
> io/check-installed-headers-c		PASS 	PASS 	PASS	FAIL	=
FAIL
> io/check-installed-headers-cxx		PASS 	PASS 	PASS	=
FAIL	FAIL
> malloc/tst-malloc-backtrace		FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-malloc-thread-exit		FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-malloc-usable		FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-mallocfork			FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-mallocstate			FAIL	PASS	PASS	=
PASS	PASS
> malloc/tst-mallopt			FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-mcheck			FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-memalign			FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-obstack			FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-posix_memalign		FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-pvalloc			FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-realloc			FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-scratch_buffer		FAIL	PASS	PASS	PASS	=
PASS
> malloc/tst-trim1			FAIL	PASS	PASS	PASS	=
PASS
> nptl/tst-eintr4				PASS 	PASS 	PASS	=
NA	NA
> posix/tst-regex2			PASS	FAIL	FAIL	FAIL	=
FAIL
> posix/tst-getaddrinfo4			PASS	PASS	FAIL	=
FAIL	PASS
> posix/tst-getaddrinfo5			PASS	PASS	FAIL	=
FAIL	PASS
> sysvipc/test-sysvmsg			NA	NA	NA	FAIL	=
PASS
> sysvipc/test-sysvsem			NA	NA	NA	FAIL	=
PASS
> sysvipc/test-sysvshm			NA	NA	NA	FAIL	=
PASS
>=20
> c++-types-check				PASS	PASS	PASS	=
PASS	FAIL
> debug/tst-backtrace4			PASS	PASS	PASS	PASS	=
FAIL
> elf/check-abi-libc			PASS	PASS	PASS	PASS	=
FAIL
> elf/tst-tls1				PASS	PASS	PASS	PASS	=
FAIL
> elf/tst-tls1-static			PASS	PASS	PASS	PASS	=
FAIL
> elf/tst-tls2				PASS	PASS	PASS	PASS	=
FAIL
> elf/tst-tls2-static			PASS	PASS	PASS	PASS	=
FAIL
> elf/tst-tls3				PASS	PASS	PASS	PASS	=
FAIL
> math/check-abi-libm			PASS	PASS	PASS	PASS	=
FAIL
> misc/tst-writev				PASS	PASS	PASS	=
PASS   	NA =20
> nptl/tst-cancel-self-canceltype		PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-cancel1			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel10			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel11			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel13			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel15			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel16			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel17			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel18			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel2			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel20			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel21			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel24			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel25			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel26			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel27			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel3			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel4			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel5			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel6			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancel7			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx10			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx11			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx13			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx15			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx16			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx17			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx18			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx2			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx20			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx21			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx3			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx4			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx5			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx6			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cancelx7			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cleanup4			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cleanupx4			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cond-except			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-cond7				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-cond8				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-fini1				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-initializers1			PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-initializers1-c11		PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-initializers1-c89		PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-initializers1-c99		PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-initializers1-gnu11		PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-initializers1-gnu89		PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-initializers1-gnu99		PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-join5				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-key3				PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-mutex8				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-mutexpi8			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-once3				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-once4				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-oncex3				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-oncex4				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-rwlock15			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-rwlock8			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-rwlock9			PASS	PASS	PASS	PASS	=
FAIL
> nptl/tst-sem11				PASS	PASS	PASS	=
PASS	FAIL
> nptl/tst-sem12				PASS	PASS	PASS	=
PASS	FAIL
> posix/bug-regex24			PASS	PASS	PASS	PASS	=
FAIL
> rt/tst-mqueue1				PASS	PASS	PASS	=
PASS	FAIL
> rt/tst-mqueue2				PASS	PASS	PASS	=
PASS	FAIL
> rt/tst-mqueue4				PASS	PASS	PASS	=
PASS	FAIL
> rt/tst-mqueue7				PASS	PASS	PASS	=
PASS	FAIL
> rt/tst-mqueue8				PASS	PASS	PASS	=
PASS	FAIL
> rt/tst-mqueue8x				PASS	PASS	PASS	=
PASS	FAIL
> stdlib/tst-makecontext3			PASS	PASS	PASS	=
PASS	FAIL
