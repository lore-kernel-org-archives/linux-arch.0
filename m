From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 14/18] arm64: signal32: move ilp32 and aarch32 common
 code to separated file
Date: Tue, 6 Dec 2016 15:06:17 +0530
Message-ID: <20161206093617.GA21575@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-15-git-send-email-ynorov@caviumnetworks.com>
 <20161205161823.GF14429@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161205161823.GF14429@e104818-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 05, 2016 at 04:18:24PM +0000, Catalin Marinas wrote:
> On Fri, Oct 21, 2016 at 11:33:13PM +0300, Yury Norov wrote:
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 
> Please add some description, even if it means copying the subject.
> 
> > ---
> >  arch/arm64/include/asm/signal32.h        |   3 +
> >  arch/arm64/include/asm/signal32_common.h |  27 +++++++
> >  arch/arm64/kernel/Makefile               |   2 +-
> >  arch/arm64/kernel/signal32.c             | 107 ------------------------
> >  arch/arm64/kernel/signal32_common.c      | 135 +++++++++++++++++++++++++++++++
> >  5 files changed, 166 insertions(+), 108 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/signal32_common.h
> >  create mode 100644 arch/arm64/kernel/signal32_common.c
> 
> I wonder whether you can make such patches more readable by setting
> "diff.renames" to "copy" in your gitconfig (unless it's set already and
> Git cannot detect partial file code moving/copying).

I tried "git format-patch -C --find-copies-harder" - the same result.

Yury
