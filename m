From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/19] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Thu, 11 Aug 2016 17:16:45 +0200
Message-ID: <6457502.FRufylo3sd@wuerfel>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com> <3043310.yXUR8Er0VK@wuerfel> <20160811145000.GB18366@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:50075 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcHKPSL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2016 11:18:11 -0400
In-Reply-To: <20160811145000.GB18366@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Yury Norov <ynorov@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Hanjun Guo <guohanjun@huawei.com>

On Thursday, August 11, 2016 3:50:00 PM CEST Catalin Marinas wrote:
> On Thu, Aug 11, 2016 at 10:53:01AM +0200, Arnd Bergmann wrote:
> > On Thursday, August 11, 2016 3:35:01 PM CEST Zhangjian (Bamvor) wrote:
> > > On 2016/6/18 7:54, Yury Norov wrote:
> > > > From: Andrew Pinski <apinski@cavium.com>
> > > >
> > > > In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
> > > > which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
> > > >
> > > >  From now, AARCH32_EL0 (former COMPAT) config option means the support of
> > > > AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
> > > > and COMPAT indicates that one of them, or both, is enabled.
> > > >
> > > > Where needed, CONFIG_COMPAT is changed over to use CONFIG_AARCH32_EL0 instead
> > > >
> > > > Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> > > > Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
> > > > Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> > > > Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> > > > Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> > > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > > ...
> > > > diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> > > > index c173d32..af200a8 100644
> > > > --- a/arch/arm64/kernel/cpuinfo.c
> > > > +++ b/arch/arm64/kernel/cpuinfo.c
> > > > @@ -134,15 +134,17 @@ static int c_show(struct seq_file *m, void *v)
> > > >   		 */
> > > >   		seq_puts(m, "Features\t:");
> > > >   		if (compat) {
> > > > -#ifdef CONFIG_COMPAT
> > > > -			for (j = 0; compat_hwcap_str[j]; j++)
> > > > -				if (compat_elf_hwcap & (1 << j))
> > > > -					seq_printf(m, " %s", compat_hwcap_str[j]);
> > > > -
> > > > -			for (j = 0; compat_hwcap2_str[j]; j++)
> > > > -				if (compat_elf_hwcap2 & (1 << j))
> > > > -					seq_printf(m, " %s", compat_hwcap2_str[j]);
> > > > -#endif /* CONFIG_COMPAT */
> > > > +#ifdef CONFIG_AARCH32_EL0
> > > I saw that compat_hwcap_str and compat_hwcap2_str is defined when
> > > "CONFIG_COMPAT" is true. Why we only change it to CONFIG_AARCH32_EL0
> > > in c show()?
> > > > +			if (personality(current->personality) == PER_LINUX32) {
> > > And "compat" is "personality(current->personality) == PER_LINUX32;",
> > > it seems that there is no need to add this twice.
> > 
> > I think it would be best to remove the #ifdef here completely,
> > the PER_LINUX32 concept is not strictly tied to the emulation
> > of ARM binaries, it literally just changes the output of
> > /proc/cpuinfo and 'uname',
> 
> It's not strictly related to ARM binaries, however it is related to
> AArch32 CPU features being supported and detected by the kernel.
> Currently, with CONFIG_COMPAT disabled, we won't have access to a
> (meaningful) compat_elf_hwcap.

Ah, makes sense. In that case, using CONFIG_AARCH32_EL0 sounds like
the right thing to do here, though I guess we can just drop the
"if (compat)" check, as we specifically want to print the supported
features of the CPU, and they are still present even if a
process with PER_LINUX reads them.

> > and you can have ARM binaries with
> > PER_LINUX (using the arm64 uname) just like you can have
> > arm64 binaries running with PER_LINUX32.
> 
> I was actually looking to enforce the 32-bit binaries to only see
> PER_LINUX32, though with a risk of breaking the ABI. OTOH, people are
> abusing this and write 32-bit apps relying on the 64-bit /proc/cpuinfo:
> 
> http://lkml.kernel.org/g/1464706504-25224-3-git-send-email-catalin.marinas@arm.com
> 
> (you were summoned on that discussion couple of times ;))

Hmm, I thought I saw the thread and didn't have any good idea for
the uname information, but didn't notice it was for /proc/cpuinfo.

What's wrong with always showing both the 32-bit and the 64-bit
hwcap strings here (minus the duplicates, which hopefully have
the same meaning here)?

	Arnd
