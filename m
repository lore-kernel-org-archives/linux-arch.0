From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 6/6] x86/alternatives: remove text_poke() return
 value
Date: Wed, 29 Aug 2018 18:52:22 +0900
Message-ID: <20180829185222.e85026ff22638002a1df70e0@kernel.org>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-7-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829081147.184610-7-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 29 Aug 2018 01:11:47 -0700
Nadav Amit <namit@vmware.com> wrote:

> The return value of text_poke() is meaningless - it is one of the
> function inputs. One day someone may allow the callers to deal with
> text_poke() failures, if those actually happen.
> 
> In the meanwhile, remove the return value.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/text-patching.h | 2 +-
>  arch/x86/kernel/alternative.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index ffe7902cc326..1f73f71b4de2 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -34,7 +34,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>   * On the local CPU you need to be protected again NMI or MCE handlers seeing an
>   * inconsistent instruction while you patch.
>   */
> -extern void *text_poke(void *addr, const void *opcode, size_t len);
> +extern void text_poke(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
>  extern int after_bootmem;
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 0feac3dfabe9..45b7fdeaed90 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -795,7 +795,7 @@ static void text_poke_safe(void *addr, const void *opcode, size_t len,
>   *
>   * Note: Must be called under text_mutex.
>   */
> -void *text_poke(void *addr, const void *opcode, size_t len)
> +void text_poke(void *addr, const void *opcode, size_t len)
>  {
>  	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
>  	struct page *pages[2] = {0};

Could you also remove "return addr;" in this patch ?

Thank you,

> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
