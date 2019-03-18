From: Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [PATCH v11 09/14] kernel, arm64: untag user pointers in
 prctl_set_mm*
Date: Mon, 18 Mar 2019 11:47:15 +0000
Message-ID: <96675b72-d325-0682-4864-b6a96f63f8fd__4023.04140604741$1552909659$gmane$org@arm.com>
References: <cover.1552679409.git.andreyknvl@google.com>
 <c4d65de9867cb3349af6800242da0de751260c6c.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c4d65de9867cb3349af6800242da0de751260c6c.1552679409.git.andreyknvl@google.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrey Konovalov <andreyknvl@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-arm-kernel@lists.infradead.orglin
Cc: Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>
List-Id: linux-arch.vger.kernel.org

On 15/03/2019 19:51, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
>
> prctl_set_mm() and prctl_set_mm_map() use provided user pointers for vma
> lookups, which can only by done with untagged pointers.
>
> Untag user pointers in these functions.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>   kernel/sys.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..8e56d87cc6db 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1993,6 +1993,18 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>   	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
>   		return -EFAULT;
>   
> +	prctl_map->start_code	= untagged_addr(prctl_map.start_code);
> +	prctl_map->end_code	= untagged_addr(prctl_map.end_code);
> +	prctl_map->start_data	= untagged_addr(prctl_map.start_data);
> +	prctl_map->end_data	= untagged_addr(prctl_map.end_data);
> +	prctl_map->start_brk	= untagged_addr(prctl_map.start_brk);
> +	prctl_map->brk		= untagged_addr(prctl_map.brk);
> +	prctl_map->start_stack	= untagged_addr(prctl_map.start_stack);
> +	prctl_map->arg_start	= untagged_addr(prctl_map.arg_start);
> +	prctl_map->arg_end	= untagged_addr(prctl_map.arg_end);
> +	prctl_map->env_start	= untagged_addr(prctl_map.env_start);
> +	prctl_map->env_end	= untagged_addr(prctl_map.env_end);

As the buildbot suggests, those -> should be . instead :) You might want to check 
your local build with CONFIG_CHECKPOINT_RESTORE=y.

> +
>   	error = validate_prctl_map(&prctl_map);
>   	if (error)
>   		return error;
> @@ -2106,6 +2118,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
>   			      opt != PR_SET_MM_MAP_SIZE)))
>   		return -EINVAL;
>   
> +	addr = untagged_addr(addr);

This is a bit too coarse, addr is indeed used for find_vma() later on, but it is also 
used to access memory, by prctl_set_mm_mmap() and prctl_set_auxv().

Kevin

> +
>   #ifdef CONFIG_CHECKPOINT_RESTORE
>   	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
>   		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
