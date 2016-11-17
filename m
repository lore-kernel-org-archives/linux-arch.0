From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
Date: Thu, 17 Nov 2016 08:50:56 -0700
Message-ID: <20161117155056.6xkldspks6dwoj7z@localhost>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV>
 <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Cc: linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, Yury Norov <ynorov@caviumnetworks.com>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, "Joseph S. Myers" <joseph@codesourcery.com>, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Steve Ellcey <sellcey@caviumnetworks.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, agraf@suse.de, Geert Uytterhoeven <geert@linux-m68k.org>, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, GNU C Library <libc-alpha@sourceware.org>, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Adhemerval Zanella <adhemerval.zanella@linaro.org>, schwidefsky@de.ibm.com, davem@
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 16, 2016 at 03:22:26PM +0400, Maxim Kuvyrkov wrote:
> Regarding ILP32 runtime, my opinion is that it is acceptable for ILP32
> to have extra failures compared to LP64, since these are not
> regressions, but, rather, failures of a new configuration.

I disagree with this. We definitely need to understand why they fail,
otherwise we run the risk of potential glibc or kernel implementation
bugs becoming ABI.

-- 
Catalin
