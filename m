From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v7 00/20] ILP32 for ARM64
Date: Mon, 30 Jan 2017 11:12:52 +0530
Message-ID: <20170130054252.GB6156@yury-N73SV>
References: <1483961397-8599-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1483961397-8599-1-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chris Metcalf <cmetcalf@ezchip.com>, philipp.tomsich@theobroma-systems.com, Joseph Myers <joseph@codesourcery.com>, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Steve Ellcey <sellcey@caviumnetworks.com>, Prasun.Kapoor@caviumnetworks.com, Andreas Schwab <schwab@suse.de>, agraf@suse.de, szabolcs.nagy@arm.com, geert@linux-m68k.org, Adam Borowski <kilobyte@angband.pl>, manuel.montezelo@gmail.com, Chris Metcalf <cmetcalf@mellanox.com>, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, Bamvor Zhangjian <bamvor.zhangjian@huawei.com>, linux-arm-kernel@lists.infradead.org, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Florian Weimer <fweimer@redhat.com>, Nathan_Lynch@mentor.com, linux-kernel@vger.ker
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 09, 2017 at 04:59:37PM +0530, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t is is used by new userspace). Also it
> deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> This version is based on linux-next from 2017-01-09. It works with
> glibc-2.25, and tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> This is not RFC anymore. I believe that all ABI and implementation
> issues are resolved now. The way that kernel clears registers top
> halves is probably the last question, and because there's no objection
> for current approach for more that 6 month, I think, community agrees
> with it.
> 
> Patches 1, 2, 3 and 8 are general, and may be applied separately.
> 
> Current version does not introduce ABI changes comparing to RFC3.
> Kernel and GLIBC trees:
> https://github.com/norov/linux/tree/ilp32-2017-01-09
> https://github.com/norov/glibc/tree/dev9

Hi Arnd, Catalin,

Is there any progress with review? I particularly ask about generic
patches (1-3, 8). They all reviewed, and most of them acked by you,
but they are still not upstreamed.

Yury
