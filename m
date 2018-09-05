From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 09/16] x86/bugs: add lfence mitigation to spectre v2
 and no meltdown for Hygon
Date: Wed, 5 Sep 2018 11:13:09 +0200
Message-ID: <20180905091309.GB2237@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <bf6e0e5403ae96715606366b3b5f817cbdab0dc3.1535459013.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bf6e0e5403ae96715606366b3b5f817cbdab0dc3.1535459013.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 29, 2018 at 08:44:41PM +0800, Pu Wen wrote:
> To share codes between AMD and Hygon to mitigate Spectre V2 Retpoline
> vulnerability, rename macros SPECTRE_V2_RETPOLINE_MINIMAL_AMD to
> SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE, and SPECTRE_V2_CMD_RETPOLINE_AMD
> to SPECTRE_V2_CMD_RETPOLINE_LFENCE.
> 
> As Hygon processors are not affected by meltdown vulnerability as AMD's,
> so add exception in array cpu_no_meltdown[] for Hygon.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/include/asm/nospec-branch.h |  4 ++--
>  arch/x86/kernel/cpu/bugs.c           | 28 +++++++++++++++-------------
>  arch/x86/kernel/cpu/common.c         |  1 +
>  3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index fd2a8c1..6763f9b 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -211,9 +211,9 @@
>  enum spectre_v2_mitigation {
>  	SPECTRE_V2_NONE,
>  	SPECTRE_V2_RETPOLINE_MINIMAL,
> -	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
> +	SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE,
>  	SPECTRE_V2_RETPOLINE_GENERIC,
> -	SPECTRE_V2_RETPOLINE_AMD,
> +	SPECTRE_V2_RETPOLINE_LFENCE,
>  	SPECTRE_V2_IBRS_ENHANCED,
>  };
>  
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 4c2313d..15be045 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -132,15 +132,15 @@ enum spectre_v2_mitigation_cmd {
>  	SPECTRE_V2_CMD_FORCE,
>  	SPECTRE_V2_CMD_RETPOLINE,
>  	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
> -	SPECTRE_V2_CMD_RETPOLINE_AMD,
> +	SPECTRE_V2_CMD_RETPOLINE_LFENCE,
>  };
>  
>  static const char *spectre_v2_strings[] = {
>  	[SPECTRE_V2_NONE]			= "Vulnerable",
>  	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
> -	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
> +	[SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE]	= "Vulnerable: Minimal LFENCE ASM retpoline",
>  	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
> -	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
> +	[SPECTRE_V2_RETPOLINE_LFENCE]		= "Mitigation: Full LFENCE retpoline",
>  	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
>  };

This is user-visible and with all the back'n'forth and backporting
and the whole security fiasco, I don't want to have another source of
confusion. You'll have to live with it saying "AMD" in dmesg.

> @@ -272,7 +272,7 @@ static const struct {
>  	{ "off",               SPECTRE_V2_CMD_NONE,              false },
>  	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
>  	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
> -	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
> +	{ "retpoline,lfence",     SPECTRE_V2_CMD_RETPOLINE_LFENCE,     false },
>  	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
>  	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
>  };

This even more so. Those are command line strings which we're still
communicating to people, even. So no, it needs to remain "retpoline,amd"
on Hygon.

And then to not confuse people staring at the code either, we can drop
this change too:

-     SPECTRE_V2_CMD_RETPOLINE_AMD,
+     SPECTRE_V2_CMD_RETPOLINE_LFENCE,

Which leaves this patch only with the addition of the vendor tests. The
other stuff you can drop.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
