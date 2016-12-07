From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: use hardware ARCNUM in smp_processor_id()
Date: Wed, 7 Dec 2016 11:03:39 -0800
Message-ID: <718dad11-573a-294a-b9df-8ada0d49fcee@synopsys.com>
References: <1481124922-30942-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1481124922-30942-1-git-send-email-abrodkin@synopsys.com>
Sender: stable-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 12/07/2016 07:36 AM, Alexey Brodkin wrote:
> We used to think that ARC cores in SMP SoC start
> consequentially, i.e. core0 -> core1 -> core2 -> core4.
>
> Moreover we treat core0 as a master core which does some
> low-level initialization before allowing other cores to
> start doing real stuff.
>
> In that case everything works as expected - smp_processor_id()
> returns expected values for all cores, i.e.:
>  0 for core0
>  1 for core1 etc.
>
> But what if instead of core0 we want core1 to be the master?
> That might be the case if we want to use only one core out of
> SMP setup and that core is not core0 or for some other reason
> modify core start-up sequence to say: core3 -> core1 > ...
>
> In that case smp_processor_id() returns values that differ
> from real hardware core index. For the first/master core that
> we'l get 0, the next one will be 1 etc.

But then the problem is you are not setting up thread_info->cpu correctly. And
that needs fixing.
Say we already had ur next patch which doesn't assume 0 based masters, then is
this patch still needed.

Essentially this change can be taken as an optimization (mem vz. aux reg read) but
I don't think it is a fix !

> The problem here is we'll use improper cpu indexes in MCIP commands
> and inevitably commands will be sent to unexpected cores causing all
> sorts of unexpected behavior.
>
> But if we use hardware core index out out IDENTITY AUX reg that problem
> won't happen because cpu value will match its hardware index.
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/arc/include/asm/smp.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arc/include/asm/smp.h b/arch/arc/include/asm/smp.h
> index 0861007d9ef3..5aad65d3defd 100644
> --- a/arch/arc/include/asm/smp.h
> +++ b/arch/arc/include/asm/smp.h
> @@ -14,8 +14,9 @@
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/threads.h>
> +#include <asm/arcregs.h>
>  
> -#define raw_smp_processor_id() (current_thread_info()->cpu)
> +#define raw_smp_processor_id() ((int)(read_aux_reg(AUX_IDENTITY) >> 8) & 0xFF)
>  
>  /* including cpumask.h leads to cyclic deps hence this Forward declaration */
>  struct cpumask;
