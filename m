From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 16/18] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
Date: Wed, 7 Dec 2016 16:59:13 +0000
Message-ID: <20161207165913.GD31779@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-17-git-send-email-ynorov@caviumnetworks.com>
 <20161205163422.GG14429@e104818-lin.cambridge.arm.com>
 <20161206062508.GA17835@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161206062508.GA17835@yury-N73SV>
Sender: linux-doc-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 06, 2016 at 11:55:08AM +0530, Yury Norov wrote:
> On Mon, Dec 05, 2016 at 04:34:23PM +0000, Catalin Marinas wrote:
> > On Fri, Oct 21, 2016 at 11:33:15PM +0300, Yury Norov wrote:
> > > New aarch32 ptrace syscall handler is introduced to avoid run-time
> > > detection of the task type.
> > 
> > What's wrong with the run-time detection? If it's just to avoid a
> > negligible overhead, I would rather keep the code simpler by avoiding
> > duplicating the generic compat_sys_ptrace().
> 
> Nothing wrong. This is how Arnd asked me to do. You already asked this
> question: http://lkml.iu.edu/hypermail/linux/kernel/1604.3/00930.html

Hmm, I completely forgot about this ;). There is still an advantage to
doing run-time checking if we avoid touching core code (less acks to
gather and less code duplication).

Let's see what Arnd says but the initial patch looked simpler.

-- 
Catalin
