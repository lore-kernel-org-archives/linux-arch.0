From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [RFC3 nowrap: PATCH v7 00/18] ILP32 for ARM64
Date: Wed, 30 Nov 2016 10:32:09 +0530
Message-ID: <20161130050209.GB18796@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-doc-owner@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 21, 2016 at 11:32:59PM +0300, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode, and as supporting work,
> introduces ARCH_32BIT_OFF_T configuration option that is enabled for
> existing 32-bit architectures but disabled for new arches (so 64-bit
> off_t is is used by new userspace).
> 
> This version is based on kernel v4.9-rc1.  It works with glibc-2.24,
> and tested with LTP.
> 
> This version contains ABI changes, and should be used with new glibc
> version. See links below.
> 
> This is RFC because there is still no solid understanding what type
> of registers top-halves delousing we prefer and it affects ABI. In
> this patchset, w0-w7 are cleared for each syscall in assembler entry.
> 
> The alternative approach is in introducing compat wrappers which is
> little faster for natively routed syscalls (~2.6% for syscall with
> no payload) but much more complicated.

Hi all,

Steve Ellcey submitted glibc patches for ILP32:
https://www.sourceware.org/ml/libc-alpha/2016-11/msg01071.html
It implicitly assumes that kernel clears top halves of registers for
all syscalls in assembly entry. That patches are going to be taken.
It it happens, we will have no choice on kernel side how to clear top
halves anymore.

For me current version is OK, and I see no problems with it. I just
write this email to remind that it's still RFC, and this is the last
chance to get back to wrappers. 

Yury.
