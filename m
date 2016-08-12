From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 05/19] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Fri, 12 Aug 2016 15:36:12 +0100
Message-ID: <20160812143612.GH12939@e104818-lin.cambridge.arm.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <6457502.FRufylo3sd@wuerfel>
 <20160811163003.GD18366@e104818-lin.cambridge.arm.com>
 <2034620.lN3lAEBAXs@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2034620.lN3lAEBAXs@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, libc-alpha@sourceware.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 11, 2016 at 10:29:03PM +0200, Arnd Bergmann wrote:
> On Thursday, August 11, 2016 5:30:03 PM CEST Catalin Marinas wrote:
> > > > > and you can have ARM binaries with
> > > > > PER_LINUX (using the arm64 uname) just like you can have
> > > > > arm64 binaries running with PER_LINUX32.
> > > > 
> > > > I was actually looking to enforce the 32-bit binaries to only see
> > > > PER_LINUX32, though with a risk of breaking the ABI. OTOH, people are
> > > > abusing this and write 32-bit apps relying on the 64-bit /proc/cpuinfo:
> > > > 
> > > > http://lkml.kernel.org/g/1464706504-25224-3-git-send-email-catalin.marinas@arm.com
> > > > 
> > > > (you were summoned on that discussion couple of times ;))
> > > 
> > > Hmm, I thought I saw the thread and didn't have any good idea for
> > > the uname information, but didn't notice it was for /proc/cpuinfo.
> > > 
> > > What's wrong with always showing both the 32-bit and the 64-bit
> > > hwcap strings here (minus the duplicates, which hopefully have
> > > the same meaning here)?
> > 
> > As I said above, some of them have the same name (which may be a good
> > thing at a first look) but we don't have an architecture guarantee that
> > the feature is present in both AArch32 and AArch64 modes (e.g. AES may
> > only be available in AArch64).
> 
> Is this the case on actual implementations that exist today? If they
> are actually always both present, we might be able to get away with it.

It may be fine on current implementations but what would we do when/if
we actually find such discrepancy? It's not just ARM Ltd designing the
chips, so as long as the architecture doesn't mandate it you may find
strange implementations.

Imposing such restriction in the architecture doesn't make sense if the
only reason is the /proc/cpuinfo file (and I can't think of any other
reason why this should be enforced).

What I'm worried about is 32-bit apps running on an arm64 kernel and
making use of the 64-bit /proc/cpuinfo without any guarantee that the
AArch32 state has such features. In my patch proposal linked above I
wanted to always force the compat /proc/cpuinfo for 32-bit tasks.

-- 
Catalin
