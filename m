From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 02/16] x86/cache: get cache size/leaves and setup
 cache cpumap for Dhyana
Date: Mon, 3 Sep 2018 11:57:11 +0200
Message-ID: <20180903095711.GC10249@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <ff6d0392ccdd50ca747e762ae91d9c1c210b1d82.1535459013.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff6d0392ccdd50ca747e762ae91d9c1c210b1d82.1535459013.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Patch subject needs to be of the format:

<file path(s)>: Sentence starting with a capital letter and describing
concisely the patch

Fix all your subjects pls.

On Wed, Aug 29, 2018 at 08:43:10PM +0800, Pu Wen wrote:
> Hygon Dhyana processor has the topology extensions bit in CPUID.
> With this bit kernel can get the cache info. So add support

"With this bit, the kernel... "

> in cpuid4_cache_lookup_regs() to get the correct cache size.
> 
> Dhyana also find num_cache_leaves via CPUID leaf 0x8000001d, so

"... also discovers num_cache_leaves ..."

> add Hygon support in find_num_cache_leaves().
> 
> Also add cacheinfo_hygon_init_llc_id() and init_hygon_cacheinfo()
> functions to initialize Dhyana cache info. Setup cache cpumap in
> the same way as AMD does.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/include/asm/cacheinfo.h |  1 +
>  arch/x86/kernel/cpu/cacheinfo.c  | 31 +++++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/cpu.h        |  1 +
>  arch/x86/kernel/cpu/hygon.c      |  3 +++
>  4 files changed, 34 insertions(+), 2 deletions(-)

With that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
