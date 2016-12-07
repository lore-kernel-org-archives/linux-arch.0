From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: use hardware ARCNUM in smp_processor_id()
Date: Wed, 7 Dec 2016 10:58:18 -0800
Message-ID: <8ff93d94-b75b-633f-58a8-962a767aa1df@synopsys.com>
References: <1481124922-30942-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:45016 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932245AbcLGS62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2016 13:58:28 -0500
In-Reply-To: <1481124922-30942-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Peter Zijlstra <peterz@infradead.org>

+CC PeterZ, Andy

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
>
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

So I also wondered about this when debugging the SMP bringup on FPGA last year. It
seems kernel code never changes this field and only sets it up so it would be OK
to do above.

However most arches seem to use the per thread "soft" value (x86 uses a per cpu
"soft" value"), blackfin seems to be using a hardware value.
However if the value can't possibly be changes (by say scheduler etc) then there
is no point retrieving it from memory - if it is relatively cheap derive it from
to core reg.

Peter, Andy ?

-Vineet

>  
>  /* including cpumask.h leads to cyclic deps hence this Forward declaration */
>  struct cpumask;
