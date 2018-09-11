From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 09/16] x86/bugs: Add mitigation to spectre and no
 meltdown for Hygon Dhyana
Date: Tue, 11 Sep 2018 12:38:28 +0200
Message-ID: <20180911103828.GF12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <191ce6b53269e90fdc26ee49ef337b905bd7d99c.1536550550.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <191ce6b53269e90fdc26ee49ef337b905bd7d99c.1536550550.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 10, 2018 at 09:17:40PM +0800, Pu Wen wrote:
> The Hygon Dhyana CPU has the same speculative execution as AMD family
> 17h, so share AMD spectre mitigation code for Hygon Dhyana.
> 
> Also Hygon Dhyana is not affected by meltdown vulnerability as AMD,
> so add the exception for Hygon Dhyana.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/cpu/bugs.c   | 6 ++++--
>  arch/x86/kernel/cpu/common.c | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 40bdaea..726010d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -312,8 +312,9 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>  	}
>  
>  	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
> +	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
>  	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
> -		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
> +		pr_err("retpoline,amd selected but CPU is not AMD or Hygon. Switching to AUTO select\n");

Didn't we say, no user-visible changes pls?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
