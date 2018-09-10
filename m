From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 03/16] x86/cpu/mtrr: Support TOP_MEM2 and get MTRR
 number
Date: Mon, 10 Sep 2018 20:06:13 +0200
Message-ID: <20180910180613.GE4386@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <cdfcd79e88e0acf254347159673355eec00a1d37.1536550550.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cdfcd79e88e0acf254347159673355eec00a1d37.1536550550.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 10, 2018 at 09:16:03PM +0800, Pu Wen wrote:
> The Hygon Dhyana CPU have a special magic MSR way to force WB for

From the last review round:

Also, it is "The ... CPU has a special..."

Please take your time and incorporate *all* review feedback - no need to
*rush* a new revision out and drop review feedback.

> memory >4GB, and support TOP_MEM2. Therefore, it is necessary to
> add Hygon Dhyana support in amd_special_default_mtrr().
> 
> The number of variable MTRRs for Hygon is 2 as AMD's.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/cpu/mtrr/cleanup.c | 3 ++-
>  arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

With that fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
