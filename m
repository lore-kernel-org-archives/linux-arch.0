From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/19] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Thu, 11 Aug 2016 10:53:01 +0200
Message-ID: <3043310.yXUR8Er0VK@wuerfel>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-6-git-send-email-ynorov@caviumnetworks.com>
 <57AC2AA5.1030808@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <57AC2AA5.1030808@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, libc-alpha@sourceware.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Thursday, August 11, 2016 3:35:01 PM CEST Zhangjian (Bamvor) wrote:
> On 2016/6/18 7:54, Yury Norov wrote:
> > From: Andrew Pinski <apinski@cavium.com>
> >
> > In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
> > which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
> >
> >  From now, AARCH32_EL0 (former COMPAT) config option means the support of
> > AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
> > and COMPAT indicates that one of them, or both, is enabled.
> >
> > Where needed, CONFIG_COMPAT is changed over to use CONFIG_AARCH32_EL0 instead
> >
> > Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> > Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
> > Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> > Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> > Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ...
> > diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> > index c173d32..af200a8 100644
> > --- a/arch/arm64/kernel/cpuinfo.c
> > +++ b/arch/arm64/kernel/cpuinfo.c
> > @@ -134,15 +134,17 @@ static int c_show(struct seq_file *m, void *v)
> >   		 */
> >   		seq_puts(m, "Features\t:");
> >   		if (compat) {
> > -#ifdef CONFIG_COMPAT
> > -			for (j = 0; compat_hwcap_str[j]; j++)
> > -				if (compat_elf_hwcap & (1 << j))
> > -					seq_printf(m, " %s", compat_hwcap_str[j]);
> > -
> > -			for (j = 0; compat_hwcap2_str[j]; j++)
> > -				if (compat_elf_hwcap2 & (1 << j))
> > -					seq_printf(m, " %s", compat_hwcap2_str[j]);
> > -#endif /* CONFIG_COMPAT */
> > +#ifdef CONFIG_AARCH32_EL0
> I saw that compat_hwcap_str and compat_hwcap2_str is defined when
> "CONFIG_COMPAT" is true. Why we only change it to CONFIG_AARCH32_EL0
> in c show()?
> > +			if (personality(current->personality) == PER_LINUX32) {
> And "compat" is "personality(current->personality) == PER_LINUX32;",
> it seems that there is no need to add this twice.

I think it would be best to remove the #ifdef here completely,
the PER_LINUX32 concept is not strictly tied to the emulation
of ARM binaries, it literally just changes the output of
/proc/cpuinfo and 'uname', and you can have ARM binaries with
PER_LINUX (using the arm64 uname) just like you can have
arm64 binaries running with PER_LINUX32.

	Arnd
