From: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Date: Thu, 21 May 2020 16:02:50 -0700
Message-ID: <202005211550.AF0E83BB@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200521211720.20236-6-yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Pavel
List-Id: linux-arch.vger.kernel.org

On Thu, May 21, 2020 at 02:17:20PM -0700, Yu-cheng Yu wrote:
> Introduce a quick test to verify shadow stack and IBT are working.

Cool! :)

I'd love to see either more of a commit log or more comments in the test
code itself. I had to spend a bit of time trying to understand how the
test was working. (i.e. using ucontext to "reset", using segv handler to
catch some of them, etc.) I have not yet figured out why you need to
send USR1/USR2 for two of them instead of direct calls?

More notes below...

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  tools/testing/selftests/x86/Makefile         |   2 +-
>  tools/testing/selftests/x86/cet_quick_test.c | 128 +++++++++++++++++++
>  2 files changed, 129 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/x86/cet_quick_test.c
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index f1bf5ab87160..26e68272117a 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -14,7 +14,7 @@ CAN_BUILD_CET := $(shell ./check_cc.sh $(CC) trivial_program.c -fcf-protection)
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>  			check_initial_reg_state sigreturn iopl ioperm \
>  			protection_keys test_vdso test_vsyscall mov_ss_trap \
> -			syscall_arg_fault
> +			syscall_arg_fault cet_quick_test
>  TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
>  			vdso_restorer
> diff --git a/tools/testing/selftests/x86/cet_quick_test.c b/tools/testing/selftests/x86/cet_quick_test.c
> new file mode 100644
> index 000000000000..e84bbbcfd26f
> --- /dev/null
> +++ b/tools/testing/selftests/x86/cet_quick_test.c
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Quick tests to verify Shadow Stack and IBT are working */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <ucontext.h>
> +
> +ucontext_t ucp;
> +int result[4] = {-1, -1, -1, -1};

I think you likely want three states: no signal, failed, and okay.
Perhaps -1 for "no signal" like you have above, zero for failed, and 1
for okay.

> +int test_id;
> +
> +void stack_hacked(unsigned long x)
> +{
> +	result[test_id] = -1;

So this is set to 0: "I absolutely bypassed the protection".

> +	test_id++;
> +	setcontext(&ucp);
> +}
> +
> +#pragma GCC push_options
> +#pragma GCC optimize ("O0")

Can you avoid compiler-specific pragmas? (Or verify that Clang also
behaves correctly here?) Maybe it's better to just build the entire file
with -O0 in the Makefile?

> +void ibt_violation(void)
> +{
> +#ifdef __i386__
> +	asm volatile("lea 1f, %eax");
> +	asm volatile("jmp *%eax");
> +#else
> +	asm volatile("lea 1f, %rax");
> +	asm volatile("jmp *%rax");
> +#endif
> +	asm volatile("1:");
> +	result[test_id] = -1;

Set to 0, and if the segv doesn't see it, we know for sure it failed.

> +	test_id++;
> +	setcontext(&ucp);
> +}
> +
> +void shstk_violation(void)
> +{
> +#ifdef __i386__
> +	unsigned long x = 0;
> +
> +	((unsigned long *)&x)[2] = (unsigned long)stack_hacked;
> +#else
> +	unsigned long long x = 0;
> +
> +	((unsigned long long *)&x)[2] = (unsigned long)stack_hacked;
> +#endif
> +}
> +#pragma GCC pop_options
> +
> +void segv_handler(int signum, siginfo_t *si, void *uc)
> +{

Does anything in siginfo_t indicate which kind of failure you're
detecting? It'd be nice to verify test_id matches the failure mode being
tested.

> +	result[test_id] = 0;
> +	test_id++;
> +	setcontext(&ucp);
> +}
> +
> +void user1_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	shstk_violation();
> +}
> +
> +void user2_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	ibt_violation();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct sigaction sa;
> +	int r;
> +
> +	r = sigemptyset(&sa.sa_mask);
> +	if (r)
> +		return -1;
> +
> +	sa.sa_flags = SA_SIGINFO;
> +
> +	/*
> +	 * Control protection fault handler
> +	 */
> +	sa.sa_sigaction = segv_handler;
> +	r = sigaction(SIGSEGV, &sa, NULL);
> +	if (r)
> +		return -1;
> +
> +	/*
> +	 * Handler to test Shadow stack
> +	 */
> +	sa.sa_sigaction = user1_handler;
> +	r = sigaction(SIGUSR1, &sa, NULL);
> +	if (r)
> +		return -1;
> +
> +	/*
> +	 * Handler to test IBT
> +	 */
> +	sa.sa_sigaction = user2_handler;
> +	r = sigaction(SIGUSR2, &sa, NULL);
> +	if (r)
> +		return -1;
> +
> +	test_id = 0;
> +	r = getcontext(&ucp);
> +	if (r)
> +		return -1;
> +
> +	if (test_id == 0)
> +		shstk_violation();
> +	else if (test_id == 1)
> +		ibt_violation();
> +	else if (test_id == 2)
> +		raise(SIGUSR1);
> +	else if (test_id == 3)
> +		raise(SIGUSR2);
> +
> +	r = 0;
> +	printf("[%s]\tShadow stack\n", result[0] ? "FAIL":"OK");

Then these are result[0] == -1 ? "untested" : (result[0] ? "OK" : "FAIL"))

> +	r += result[0];
> +	printf("[%s]\tIBT\n", result[1] ? "FAIL":"OK");
> +	r += result[1];
> +	printf("[%s]\tShadow stack in signal\n", result[2] ? "FAIL":"OK");
> +	r += result[2];
> +	printf("[%s]\tIBT in signal\n", result[3] ? "FAIL":"OK");
> +	r += result[3];
> +	return r;
> +}
> -- 
> 2.21.0
> 

-- 
Kees Cook
