From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 01/16] x86/cpu: Create Hygon Dhyana architecture
 support file
Date: Mon, 10 Sep 2018 18:38:21 +0200
Message-ID: <20180910163821.GD4386@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <d99e831f739308221798c9939efc6e6fc1648e0c.1536550550.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d99e831f739308221798c9939efc6e6fc1648e0c.1536550550.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 10, 2018 at 09:15:29PM +0800, Pu Wen wrote:
> Add x86 architecture support for new processor Hygon Dhyana Family

		"... for a new processor: Hygon... "

> 18h.

Instead of all that:

> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c)
> from the AMD one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana.


> In this way we can remove old AMD architecture support codes and
> generate a clear initialization flow for Hygon Dhyana CPU. It also
> reduce the long-term maintenance effort.

... simply say: "Carve out initialization code needed by Dhyana into a
separate compilation unit."

> Add Maintainer information
> for hygon.c in accordance.

That sentence is not needed - that fact is visible in the diff.

> 
> To identify Hygon Dhyana CPU, add a new vendor type X86_VENDOR_HYGON(9)
> for system recognition.

No need for that "(9)" - also visible from the diff and an
implementation detail.

> 
> To enable the config for Hygon Dhyana CPU, add a separated Kconfig
> entry(CPU_SUP_HYGON) in kernel config setup.

That sentence is not needed for the same reason as above.

> And select CPU_SUP_AMD
> to solve the dependency issues in kernel.

No, this should say: "Since Dhyana uses AMD functionality to a large
degree, select CPU_SUP_AMD which provides that functionality."

> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  MAINTAINERS                      |   6 +
>  arch/x86/Kconfig.cpu             |  14 ++
>  arch/x86/include/asm/processor.h |   3 +-
>  arch/x86/kernel/cpu/Makefile     |   1 +
>  arch/x86/kernel/cpu/hygon.c      | 408 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 431 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kernel/cpu/hygon.c

With that taken care of:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
