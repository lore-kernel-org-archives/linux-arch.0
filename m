From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [RFC2 nowrap: PATCH v7 00/18] ILP32 for ARM64
Date: Wed, 17 Aug 2016 15:48:22 +0300
Message-ID: <20160817124822.GA25751@yury-N73SV>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
 <175AE090-EDA7-4A8D-9044-3FFA74AC1903@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <175AE090-EDA7-4A8D-9044-3FFA74AC1903@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: Alexander Graf <agraf@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 17, 2016 at 02:28:50PM +0200, Alexander Graf wrote:
> 
> > On 17 Aug 2016, at 13:46, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > 
> > This series enables aarch64 with ilp32 mode, and as supporting work,
> > introduces ARCH_32BIT_OFF_T configuration option that is enabled for
> > existing 32-bit architectures but disabled for new arches (so 64-bit
> > off_t is is used by new userspace).
> > 
> > This version is based on kernel v4.8-rc2.
> > It works with glibc-2.23, and tested with LTP.
> > 
> > This is RFC because there is still no solid understanding what type of registers
> > top-halves delousing we prefer. In this patchset, w0-w7 are cleared for each
> > syscall in assembler entry. The alternative approach is in introducing compat
> > wrappers which is little faster for natively routed syscalls (~2.6% for syscall
> > with no payload) but much more complicated.
> 
> So you’re saying there are 2 options:
> 
>   1) easy to get right, slightly slower, same ABI to user space as 2
>   2) harder to get right, minor performance benefit

No, ABI is little different. If 1) we pass off_t in a pair to syscalls,
if 2) - in a single register. So if 1, we 'd take some wrappers from aarch32.
See patch 12 here.

> That’s an obvious pick, no? Mark it non-RFC and stay with the clearing in assembler entry. If anyone cares about those last few percent, they can still push the harder path upstream later if they want to, but at least we’ll have the ABI stable, so that you can start using and developing for ilp32 on aarch64.
> 
> 
> Alex
