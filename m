From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 16/18] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
Date: Fri, 6 Jan 2017 02:10:03 +0530
Message-ID: <20170105204003.GA7437@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161206062508.GA17835@yury-N73SV>
 <20161207165913.GD31779@e104818-lin.cambridge.arm.com>
 <3703608.GKr1zzErMk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3703608.GKr1zzErMk@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, Catalin Marinas <catalin.marinas@arm.com>, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 07, 2016 at 09:40:13PM +0100, Arnd Bergmann wrote:
> On Wednesday, December 7, 2016 4:59:13 PM CET Catalin Marinas wrote:
> > On Tue, Dec 06, 2016 at 11:55:08AM +0530, Yury Norov wrote:
> > > On Mon, Dec 05, 2016 at 04:34:23PM +0000, Catalin Marinas wrote:
> > > > On Fri, Oct 21, 2016 at 11:33:15PM +0300, Yury Norov wrote:
> > > > > New aarch32 ptrace syscall handler is introduced to avoid run-time
> > > > > detection of the task type.
> > > > 
> > > > What's wrong with the run-time detection? If it's just to avoid a
> > > > negligible overhead, I would rather keep the code simpler by avoiding
> > > > duplicating the generic compat_sys_ptrace().
> > > 
> > > Nothing wrong. This is how Arnd asked me to do. You already asked this
> > > question: http://lkml.iu.edu/hypermail/linux/kernel/1604.3/00930.html
> > 
> > Hmm, I completely forgot about this ;). There is still an advantage to
> > doing run-time checking if we avoid touching core code (less acks to
> > gather and less code duplication).
> > 
> > Let's see what Arnd says but the initial patch looked simpler.
> 
> I don't currently have either version of the patch in my inbox
> (the archive is on a different machine), but in general I'd still
> think it's best to avoid the runtime check for aarch64-ilp32
> altogether. I'd have to look at the overall kernel source to
> see if it's worth avoiding one or two instances though, or
> if there are an overwhelming number of other checks that we
> can't avoid at all.
> 
> Regarding ptrace, I notice that arch/tile doesn't even use
> the compat entry point for its ilp32 user space on 64-bit
> kernels, it just calls the regular 64-bit one. Would that
> help here?

ILP32 tasks has unique context that is not like aarch64 or aarch32,
so we have to have unique ptrace handler. I prepared the patch for
ptrace with runtime ABI detection, as Catalin said, see there:
https://github.com/norov/linux/commit/1f66dc22a4450b192e83458f2c3cc0e79f53e670

If it's OK, I'd like to update submission.

Yury
