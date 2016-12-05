From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: ILP32 for ARM64 - testing with lmbench
Date: Mon, 5 Dec 2016 14:13:12 +0000
Message-ID: <20161205141312.GC14429@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161028124659.GA24131@yury-N73SV>
 <cdf5cdf2-43af-6d7f-9e0c-72675fb83224@huawei.com>
 <266952F2-53F5-4D5E-83F0-6C8203092F67@linaro.org>
 <120041af-f4e9-5b6f-36dc-7d3535a1f01c@huawei.com>
 <0adfca97-1624-8eac-8149-da447525ad65@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0adfca97-1624-8eac-8149-da447525ad65@huawei.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, Yury Norov <ynorov@caviumnetworks.com>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, matt.spencer@arm.com, "Joseph S. Myers" <joseph@codesourcery.com>, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, sellcey@caviumnetworks.com, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, agraf@suse.de, Geert Uytterhoeven <geert@linux-m68k.org>, Ding Tianhong <dingtianhong@huawei.com>, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, GNU
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 05, 2016 at 06:16:09PM +0800, Zhangjian (Bamvor) wrote:
> Do you have suggestion of next move of upstreaming ILP32?

I mentioned the steps a few time before. I'm pasting them again here:

1. Complete the review of the Linux patches and ABI (no merge yet)
2. Review the corresponding glibc patches (no merge yet)
3. Ask (Linaro, Cavium) for toolchain + filesystem (pre-built and more
   than just busybox) to be able to reproduce the testing in ARM
4. More testing (LTP, trinity, performance regressions etc.)
5. Move the ILP32 PCS out of beta (based on the results from 4)
6. Check the market again to see if anyone still needs ILP32
7. Based on 6, decide whether to merge the kernel and glibc patches

What's not explicitly mentioned in step 4 is glibc testing. Point 5 is
ARM's responsibility (toolchain folk).

> There are already the test results of lmbench and specint. Do you they
> are ok or need more data to prove no regression?

I would need to reproduce the tests myself, see step 3.

> I have also noticed that there are ILP32 failures in glibc testsuite.
> Is it the only blocker for merge ILP32(in technology part)?

It's probably not the only blocker but I have to review the kernel
patches again to make sure. I'd also like to see whether the libc-alpha
community is ok with the glibc counterpart (but don't merge the patches
until the ABI is agreed on both sides).

On performance, I want to make sure there are no regressions on
AArch32/compat and AArch64/LP64.

-- 
Catalin
