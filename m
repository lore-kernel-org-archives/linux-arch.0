From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: ILP32 for ARM64 - testing with lmbench
Date: Thu, 17 Nov 2016 11:28:48 +0800
Message-ID: <cdf5cdf2-43af-6d7f-9e0c-72675fb83224@huawei.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161028124659.GA24131@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161028124659.GA24131@yury-N73SV>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, sellcey@caviumnetworks.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, Ding Tianhong <dingtianhong@huawei.com>, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, hanjun.guo@linaro.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

Hi, all

I test specint of aarch64 LP64 when aarch32 el0 disable/enabled respectively
and compare with ILP32 unmerged kernel(4.8-rc6) in our arm64 board. I found
that difference(ILP32 disabled/ILP32 unmerged) is bigger when aarch32 el0 is
enabled, compare with aarch32 el0 disabled kernel. And bzip2, mcg, hmmer,
libquantum are the top four differences[1]. Note that bigger is better in
specint test.

In order to make sure the above results, I retest these four testcases in
reportable way(reference the command in the end). The result[2] show that
libquantum decrease -2.09% after ILP32 enabled and aarch32 on. I think it is in
significant.

The result of lmbench is not stable in my board. I plan to dig it later.

[1] The following test result is tested through --size=ref --iterations=3.
1.1 Test when aarch32_el0 is enabled.
                         ILP32 disabled        base line
       400.perlbench            100.00%             100%
       401.bzip2                 99.35%             100%
       403.gcc                  100.26%             100%
       429.mcf                  102.75%             100%
       445.gobmk                100.00%             100%
       456.hmmer                 95.66%             100%
       458.sjeng                100.00%             100%
       462.libquantum           100.00%             100%
       471.omnetpp              100.59%             100%
       473.astar                 99.66%             100%
       483.xalancbmk             99.10%             100%

1.2 Test when aarch32_el0 is disabled
                         ILP32 disabled         base line
       400.perlbench            100.22%              100%
       401.bzip2                100.95%              100%
       403.gcc                  100.20%              100%
       429.mcf                  100.76%              100%
       445.gobmk                100.36%              100%
       456.hmmer                 97.94%              100%
       458.sjeng                 99.73%              100%
       462.libquantum            98.72%              100%
       471.omnetpp              100.86%              100%
       473.astar                 99.15%              100%
       483.xalancbmk            100.08%              100%

[2] The following test result is tested through: runspec --config=my.cfg --size=test,train,ref --noreportable --tune=base,peak --iterations=3 bzip2 mcf hmmer libquantum
2.1 Test when aarch32_el0 is enabled.
                          ILP32_enabled         base line
       401.bzip2                100.82%              100%
       429.mcf                  100.18%              100%
       456.hmmer                 99.64%              100%
       462.libquantum            97.91%              100%

Regards

Bamvor

On 2016/10/28 20:46, Yury Norov wrote:
> [Add Steve Ellcey, thanks for testing on ThunderX]
>
> Lmbench-3.0-a9 testing is performed on ThunderX machine to check that
> ILP32 series does not add performance regressions for LP64. Test
> summary is in the table below. Our measurements doesn't show
> significant performance regression of LP64 if ILP32 code is merged,
> both enabled or disabled.
>
>                ILP32 enabled   ILP32  disabled   Standard Kernel
> null syscall   0.1066          0.1121            0.1121
>                95.09%          100.00%
>
> stat           1.3947          1.3814            1.3864
>                100.60%         99.64%
>
> fstat          0.4459          0.4344            0.4524
>                98.56%          96.02%
>
> open/close     4.0606          4.0411            4.0453
>                100.38%         99.90%
>
> read           0.4819          0.5014            0.5014
>                96.11%          100.00%
>
> Tested with linux 4.8 because 4.9-rc1 is not fixed yet for ThunderX.
> Other system details below.
>
> Yury.
>
> ubuntu@crb6:~$ uname -a
> Linux crb6 4.8.0+ #3 SMP Thu Oct 27 11:01:32 PDT 2016 aarch64 aarch64 aarch64 GNU/Linux
>
> ubuntu@crb6:~$ cat /proc/meminfo
> MemTotal:       132011948 kB
> MemFree:        131442672 kB
> MemAvailable:   130695764 kB
> Buffers:           15696 kB
> Cached:            88088 kB
> SwapCached:            0 kB
> Active:            82760 kB
> Inactive:          41336 kB
> Active(anon):      20880 kB
> Inactive(anon):     8576 kB
> Active(file):      61880 kB
> Inactive(file):    32760 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:      128920572 kB
> SwapFree:       128920572 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:         20544 kB
> Mapped:            19780 kB
> Shmem:              9060 kB
> Slab:              78804 kB
> SReclaimable:      27372 kB
> SUnreclaim:        51432 kB
> KernelStack:        8336 kB
> PageTables:          820 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:    194926544 kB
> Committed_AS:     256324 kB
> VmallocTotal:   135290290112 kB
> VmallocUsed:           0 kB
> VmallocChunk:          0 kB
> AnonHugePages:         0 kB
> ShmemHugePages:        0 kB
> ShmemPmdMapped:        0 kB
> CmaTotal:              0 kB
> CmaFree:               0 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
>
> ubuntu@crb6:~$ cat /proc/cpuinfo
> processor	: 0
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 1
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 2
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 3
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 4
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 5
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 6
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 7
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 8
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 9
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 10
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 11
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 12
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 13
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 14
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 15
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 16
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 17
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 18
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 19
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 20
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 21
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 22
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 23
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 24
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 25
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 26
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 27
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 28
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 29
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 30
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 31
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 32
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 33
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 34
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 35
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 36
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 37
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 38
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 39
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 40
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 41
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 42
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 43
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 44
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 45
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 46
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
> processor	: 47
> BogoMIPS	: 200.00
> Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer	: 0x43
> CPU architecture: 8
> CPU variant	: 0x1
> CPU part	: 0x0a1
> CPU revision	: 0
>
