From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH 02/18] arm64: ilp32: add documentation on the ILP32 ABI
 for ARM64
Date: Mon, 24 Oct 2016 12:36:27 -0400
Message-ID: <352ff60e-3975-8421-3274-3a904c0ac642@mellanox.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-3-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477081997-4770-3-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kilobyte@angband.pl, manuel.montezelo@gmail.com, zhouchengming1@huawei.com, pinskia@gmail.com, szabolcs.nagy@arm.com, Nathan_Lynch@mentor.com, heiko.carstens@de.ibm.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, schwidefsky@de.ibm.com, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, linyongting@huawei.com, davem@davemloft.net, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On 10/21/2016 4:33 PM, Yury Norov wrote:
> Based on Andrew Pinski's patch-series.
>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>   Documentation/arm64/ilp32.txt | 46 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 Documentation/arm64/ilp32.txt
>
> diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
> new file mode 100644
> index 0000000..b96c18f
> --- /dev/null
> +++ b/Documentation/arm64/ilp32.txt
> @@ -0,0 +1,46 @@
> +ILP32 AARCH64 SYSCALL ABI
> +=========================
> +
> +This document describes the ILP32 syscall ABI and where it differs
> +from the generic compat linux syscall interface.
> +
> +AARCH64/ILP32 userspace can potentially access top halves of registers that
> +are passed as syscall arguments, so such registers (w0-w7) are deloused.

I'm not sure what "potentially access" here means: I think what you want to say
is that userspace can pass garbage in the top half, but you should be clearer about
what you mean here.  Also, you shouldn't use "deloused" here, since it's not a term
that's defined elsewhere in the kernel, even though it's been used colloquially on LKML.
Provide an actual implementation definition, like "have their top 32 bits zeroed".

> +AARCH64/ILP32 provides next types turned to 64-bit (comparing to AARCH32):

What does "turned" mean here?  And I "next types" isn't standard English; you want
to say something like "the following types".  Likewise later with "next syscalls".

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
