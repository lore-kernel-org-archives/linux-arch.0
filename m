From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: ILP32 for ARM64 - testing with lmbench
Date: Sun, 11 Dec 2016 17:38:06 +0530
Message-ID: <20161211120806.GA5973@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161028124659.GA24131@yury-N73SV>
 <cdf5cdf2-43af-6d7f-9e0c-72675fb83224@huawei.com>
 <266952F2-53F5-4D5E-83F0-6C8203092F67@linaro.org>
 <120041af-f4e9-5b6f-36dc-7d3535a1f01c@huawei.com>
 <0adfca97-1624-8eac-8149-da447525ad65@huawei.com>
 <20161205141312.GC14429@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:16066
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752228AbcLKMIW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Dec 2016 07:08:22 -0500
Content-Disposition: inline
In-Reply-To: <20161205141312.GC14429@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, matt.spencer@arm.com, "Joseph S. Myers" <joseph@codesourcery.com>, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, sellcey@caviumnetworks.com, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, agraf@suse.de, Geert Uytterhoeven <geert@linux-m68k.org>, Ding Tianhong <dingtianhong@huawei.com>, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.orglinux-ar

On Mon, Dec 05, 2016 at 02:13:12PM +0000, Catalin Marinas wrote:
> On Mon, Dec 05, 2016 at 06:16:09PM +0800, Zhangjian (Bamvor) wrote:
> > Do you have suggestion of next move of upstreaming ILP32?
> 
> I mentioned the steps a few time before. I'm pasting them again here:
> 
> 1. Complete the review of the Linux patches and ABI (no merge yet)
> 2. Review the corresponding glibc patches (no merge yet)
> 3. Ask (Linaro, Cavium) for toolchain + filesystem (pre-built and more
>    than just busybox) to be able to reproduce the testing in ARM
> 4. More testing (LTP, trinity, performance regressions etc.)
> 5. Move the ILP32 PCS out of beta (based on the results from 4)
> 6. Check the market again to see if anyone still needs ILP32
> 7. Based on 6, decide whether to merge the kernel and glibc patches
> 
> What's not explicitly mentioned in step 4 is glibc testing. Point 5 is
> ARM's responsibility (toolchain folk).
> 
> > There are already the test results of lmbench and specint. Do you they
> > are ok or need more data to prove no regression?
> 
> I would need to reproduce the tests myself, see step 3.

Hi Catalin,

> 3. Ask (Linaro, Cavium) for toolchain + filesystem (pre-built and more
>    than just busybox) to be able to reproduce the testing in ARM

This is the Andrew's toolchain I use to build kernel, GLIBC, binutils etc:
https://drive.google.com/open?id=0B93nHerV55yNVlVKaXpOOHQtbW8
It's not the latest build but it works well to me.

This archive contains 4.9-rc8 kernel, initrd, sys-root, qemu image based on
ilp32 busybox. 
https://drive.google.com/open?id=0B93nHerV55yNbVo0bko0bWlQeFE

I can start linux on qemu and run basic commands and tests in ilp32
mode. This is my first attempt to create rootfs, and this is very basic
busybox + sys-root.  But it lets me start lp64 and ilp32 apps (find
example there). If you need something more, let me know and I'll add
it. You can also use any professional distro with this ilp32-enabled
kernel, just copy sys-root there (like I actually do - I run Ubuntu
14 daily). 

BTW. This is of course good idea to build and test ilp32 user
environment, but in real life I think ilp32 apps will work in lp64
userspace.

> 4. More testing (LTP, trinity, performance regressions etc.)

I also built and ran trinity. After ~24 hours I found all trinity
threads stalled for lp64, and after another 24 hours I found it
running but slower for ilp32. Kernel was alive in both cases. 

Yury.
