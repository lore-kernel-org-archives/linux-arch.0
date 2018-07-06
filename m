From: Philip Li <philip.li@intel.com>
Subject: Re: [kbuild-all] [PATCH 3/6] timex: prepare compat helpers for y2038
 changes
Date: Fri, 6 Jul 2018 08:41:33 +0800
Message-ID: <20180706004133.GA24731@intel.com>
References: <20180703054422.12089-4-deepa.kernel@gmail.com>
 <201807051322.sUohKhUO%fengguang.wu@intel.com>
 <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
 <alpine.DEB.2.21.1807052232310.1771@nanos.tec.linutronix.de>
 <CABeXuvpa6GtEOEn5HbYPnAVqqweTXLBH0KUXssGpFBzUNeayZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABeXuvpa6GtEOEn5HbYPnAVqqweTXLBH0KUXssGpFBzUNeayZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kernel test robot <fengguang.wu@intel.com>, linux-arch <linux-arch@vger.kernel.org>, kbuild test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, palmer@sifive.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@01.org, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 05, 2018 at 02:45:05PM -0700, Deepa Dinamani wrote:
> Posted v2 now.
> 
> Fengguang,
> 
> Also the make.cross script pointed to by the kernel test bot is broken
> for riscv.
> 
> I applied the following fix to compile it.
> 
> Pull request: https://github.com/intel/lkp-tests/pull/11
thanks Deepa, i will follow up with the pull request to merge it.

> 
> Thanks,
> Deepa
> 
> On Thu, Jul 5, 2018 at 1:33 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 5 Jul 2018, Deepa Dinamani wrote:
> >
> >> The error is fixed with the following patch that goes in before patch
> >> 3/6 above in the series.
> >> Let me know if I should post a v2 instead.
> >>
> >> Thanks,
> >> Deepa
> >>
> >>
> >> commit bfe4b046ed7f01154aef44fcb77d3f172929ccc2
> >> Author: Deepa Dinamani <deepa.kernel@gmail.com>
> >> Date:   Thu Jul 5 11:47:25 2018 -0700
> >>
> >>     riscv: Include asm-generic/compat.h
> >>
> >>     riscv does not enable CONFIG_COMPAT in default configurations:
> >>     defconfig, allmodconfig and nomodconfig.
> >>     And hence does not inlude definitions for compat data types.
> >>
> >>     Now that time syscalls are being reused in non CONFIG_COMPAT
> >>     modes, include asm-generic definitions for riscv.
> >>
> >>     Alternative would be to make compat_time.h to be conditional on
> >>     CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
> >>     asm/compat.h include the generic version instead.
> >>
> >>     Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> >>     Cc: palmer@sifive.com
> >>     Cc: linux-riscv@lists.infradead.org
> >
> > Post a real patch please instead of something which I have to cleanup
> > manually. A V2 of the series is probably the simplest way.
> >
> > Thanks,
> >
> >         tglx
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
