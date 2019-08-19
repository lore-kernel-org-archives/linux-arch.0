From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 3/5] arm64: Change the tagged_addr sysctl control
 semantics to only prevent the opt-in
Date: Mon, 19 Aug 2019 17:47:14 +0200
Message-ID: <CAAeHK+wSw6x8EpPc5-7tBnxEjKfYGfH6mUEh013YjKBCy40AZA@mail.gmail.com>
References: <20190815154403.16473-1-catalin.marinas@arm.com>
 <20190815154403.16473-4-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190815154403.16473-4-catalin.marinas@arm.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 15, 2019 at 5:44 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> First rename the sysctl control to abi.tagged_addr_disabled and make it
> default off (zero). When abi.tagged_addr_disabled == 1, only block the
> enabling of the TBI ABI via prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE).
> Getting the status of the ABI or disabling it is still allowed.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  arch/arm64/kernel/process.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 76b7c55026aa..03689c0beb34 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -579,17 +579,22 @@ void arch_setup_new_exec(void)
>  /*
>   * Control the relaxed ABI allowing tagged user addresses into the kernel.
>   */
> -static unsigned int tagged_addr_prctl_allowed = 1;
> +static unsigned int tagged_addr_disabled;
>
>  long set_tagged_addr_ctrl(unsigned long arg)
>  {
> -       if (!tagged_addr_prctl_allowed)
> -               return -EINVAL;
>         if (is_compat_task())
>                 return -EINVAL;
>         if (arg & ~PR_TAGGED_ADDR_ENABLE)
>                 return -EINVAL;
>
> +       /*
> +        * Do not allow the enabling of the tagged address ABI if globally
> +        * disabled via sysctl abi.tagged_addr_disabled.
> +        */
> +       if (arg & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
> +               return -EINVAL;
> +
>         update_thread_flag(TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
>
>         return 0;
> @@ -597,8 +602,6 @@ long set_tagged_addr_ctrl(unsigned long arg)
>
>  long get_tagged_addr_ctrl(void)
>  {
> -       if (!tagged_addr_prctl_allowed)
> -               return -EINVAL;
>         if (is_compat_task())
>                 return -EINVAL;
>
> @@ -618,9 +621,9 @@ static int one = 1;
>
>  static struct ctl_table tagged_addr_sysctl_table[] = {
>         {
> -               .procname       = "tagged_addr",
> +               .procname       = "tagged_addr_disabled",
>                 .mode           = 0644,
> -               .data           = &tagged_addr_prctl_allowed,
> +               .data           = &tagged_addr_disabled,
>                 .maxlen         = sizeof(int),
>                 .proc_handler   = proc_dointvec_minmax,
>                 .extra1         = &zero,
