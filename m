From: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Subject: Re: ILP32 for ARM64 - testing with lmbench
Date: Thu, 17 Nov 2016 09:02:29 +0400
Message-ID: <266952F2-53F5-4D5E-83F0-6C8203092F67@linaro.org>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161028124659.GA24131@yury-N73SV>
 <cdf5cdf2-43af-6d7f-9e0c-72675fb83224@huawei.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35725 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbcKQFCf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Nov 2016 00:02:35 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so285345972wmd.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Nov 2016 21:02:34 -0800 (PST)
In-Reply-To: <cdf5cdf2-43af-6d7f-9e0c-72675fb83224@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, manuel.montezelo@gmail.com, linyongting@huawei.com, David Miller <davem@davemloft.net>, zhouchengming1@huawei.com

Hi Bamvor,

I'm surprised that you see this much difference from ILP32 patches on =
SPEC CPU2006int at all.  The SPEC CPU2006 benchmarks spend almost no =
time in the kernel syscalls.  I can imagine memory, TLB, and cache =
handling in the kernel could affect CPU2006 benchmarks.  Do ILP32 =
patches touch code in those areas?

Other than that, it would be interesting to check what the variance is =
between the 3 iterations of benchmark runs.  Could you check what =
relative standard deviation is between the 3 iterations -- (STDEV(RUN1, =
RUN2, RUN3) / RUNselected)?

For reference, in my [non-ILP32] benchmarking I see 1.1% for 401.bzip2,  =
0.8% for 429.mcf, 0.2% for 456.hmmer, and 0.1% for 462.libquantum.

--
Maxim Kuvyrkov
www.linaro.org



> On Nov 17, 2016, at 7:28 AM, Zhangjian (Bamvor) =
<bamvor.zhangjian@huawei.com> wrote:
>=20
> Hi, all
>=20
> I test specint of aarch64 LP64 when aarch32 el0 disable/enabled =
respectively
> and compare with ILP32 unmerged kernel(4.8-rc6) in our arm64 board. I =
found
> that difference(ILP32 disabled/ILP32 unmerged) is bigger when aarch32 =
el0 is
> enabled, compare with aarch32 el0 disabled kernel. And bzip2, mcg, =
hmmer,
> libquantum are the top four differences[1]. Note that bigger is better =
in
> specint test.
>=20
> In order to make sure the above results, I retest these four testcases =
in
> reportable way(reference the command in the end). The result[2] show =
that
> libquantum decrease -2.09% after ILP32 enabled and aarch32 on. I think =
it is in
> significant.
>=20
> The result of lmbench is not stable in my board. I plan to dig it =
later.
>=20
> [1] The following test result is tested through --size=3Dref =
--iterations=3D3.
> 1.1 Test when aarch32_el0 is enabled.
>                        ILP32 disabled        base line
>      400.perlbench            100.00%             100%
>      401.bzip2                 99.35%             100%
>      403.gcc                  100.26%             100%
>      429.mcf                  102.75%             100%
>      445.gobmk                100.00%             100%
>      456.hmmer                 95.66%             100%
>      458.sjeng                100.00%             100%
>      462.libquantum           100.00%             100%
>      471.omnetpp              100.59%             100%
>      473.astar                 99.66%             100%
>      483.xalancbmk             99.10%             100%
>=20
> 1.2 Test when aarch32_el0 is disabled
>                        ILP32 disabled         base line
>      400.perlbench            100.22%              100%
>      401.bzip2                100.95%              100%
>      403.gcc                  100.20%              100%
>      429.mcf                  100.76%              100%
>      445.gobmk                100.36%              100%
>      456.hmmer                 97.94%              100%
>      458.sjeng                 99.73%              100%
>      462.libquantum            98.72%              100%
>      471.omnetpp              100.86%              100%
>      473.astar                 99.15%              100%
>      483.xalancbmk            100.08%              100%
>=20
> [2] The following test result is tested through: runspec =
--config=3Dmy.cfg --size=3Dtest,train,ref --noreportable =
--tune=3Dbase,peak --iterations=3D3 bzip2 mcf hmmer libquantum
> 2.1 Test when aarch32_el0 is enabled.
>                         ILP32_enabled         base line
>      401.bzip2                100.82%              100%
>      429.mcf                  100.18%              100%
>      456.hmmer                 99.64%              100%
>      462.libquantum            97.91%              100%
>=20
> Regards
>=20
> Bamvor
>=20
> On 2016/10/28 20:46, Yury Norov wrote:
>> [Add Steve Ellcey, thanks for testing on ThunderX]
>>=20
>> Lmbench-3.0-a9 testing is performed on ThunderX machine to check that
>> ILP32 series does not add performance regressions for LP64. Test
>> summary is in the table below. Our measurements doesn't show
>> significant performance regression of LP64 if ILP32 code is merged,
>> both enabled or disabled.
>>=20
>>               ILP32 enabled   ILP32  disabled   Standard Kernel
>> null syscall   0.1066          0.1121            0.1121
>>               95.09%          100.00%
>>=20
>> stat           1.3947          1.3814            1.3864
>>               100.60%         99.64%
>>=20
>> fstat          0.4459          0.4344            0.4524
>>               98.56%          96.02%
>>=20
>> open/close     4.0606          4.0411            4.0453
>>               100.38%         99.90%
>>=20
>> read           0.4819          0.5014            0.5014
>>               96.11%          100.00%
>>=20
>> Tested with linux 4.8 because 4.9-rc1 is not fixed yet for ThunderX.
>> Other system details below.
>>=20
>> Yury.
>>=20
>> ubuntu@crb6:~$ uname -a
>> Linux crb6 4.8.0+ #3 SMP Thu Oct 27 11:01:32 PDT 2016 aarch64 aarch64 =
aarch64 GNU/Linux
>>=20
>> ubuntu@crb6:~$ cat /proc/meminfo
>> MemTotal:       132011948 kB
>> MemFree:        131442672 kB
>> MemAvailable:   130695764 kB
>> Buffers:           15696 kB
>> Cached:            88088 kB
>> SwapCached:            0 kB
>> Active:            82760 kB
>> Inactive:          41336 kB
>> Active(anon):      20880 kB
>> Inactive(anon):     8576 kB
>> Active(file):      61880 kB
>> Inactive(file):    32760 kB
>> Unevictable:           0 kB
>> Mlocked:               0 kB
>> SwapTotal:      128920572 kB
>> SwapFree:       128920572 kB
>> Dirty:                 0 kB
>> Writeback:             0 kB
>> AnonPages:         20544 kB
>> Mapped:            19780 kB
>> Shmem:              9060 kB
>> Slab:              78804 kB
>> SReclaimable:      27372 kB
>> SUnreclaim:        51432 kB
>> KernelStack:        8336 kB
>> PageTables:          820 kB
>> NFS_Unstable:          0 kB
>> Bounce:                0 kB
>> WritebackTmp:          0 kB
>> CommitLimit:    194926544 kB
>> Committed_AS:     256324 kB
>> VmallocTotal:   135290290112 kB
>> VmallocUsed:           0 kB
>> VmallocChunk:          0 kB
>> AnonHugePages:         0 kB
>> ShmemHugePages:        0 kB
>> ShmemPmdMapped:        0 kB
>> CmaTotal:              0 kB
>> CmaFree:               0 kB
>> HugePages_Total:       0
>> HugePages_Free:        0
>> HugePages_Rsvd:        0
>> HugePages_Surp:        0
>> Hugepagesize:       2048 kB
>>=20
>> ubuntu@crb6:~$ cat /proc/cpuinfo
>> processor	: 0
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 1
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 2
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 3
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 4
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 5
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 6
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 7
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 8
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 9
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 10
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 11
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 12
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 13
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 14
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 15
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 16
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 17
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 18
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 19
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 20
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 21
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 22
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 23
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 24
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 25
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 26
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 27
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 28
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 29
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 30
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 31
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 32
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 33
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 34
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 35
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 36
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 37
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 38
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 39
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 40
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 41
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 42
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 43
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 44
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 45
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 46
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>> processor	: 47
>> BogoMIPS	: 200.00
>> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
>> CPU implementer	: 0x43
>> CPU architecture: 8
>> CPU variant	: 0x1
>> CPU part	: 0x0a1
>> CPU revision	: 0
>>=20
>=20
