Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [217.140.110.172] ([217.140.110.172]:51226 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2388512AbfJVMd6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Oct 2019 08:33:58 -0400
Date: Tue, 22 Oct 2019 13:33:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 7/8] locking/atomics, kcsan: Add KCSAN instrumentation
Message-ID: <20191022123329.GC11583@lakrids.cambridge.arm.com>
References: <20191017141305.146193-1-elver@google.com>
 <20191017141305.146193-8-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017141305.146193-8-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191022123330.kuOkxQkFjOkEkkvXp88VDe2W-q0o991inx5wd3Tyolc@z>

On Thu, Oct 17, 2019 at 04:13:04PM +0200, Marco Elver wrote:
> This adds KCSAN instrumentation to atomic-instrumented.h.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Use kcsan_check{,_atomic}_{read,write} instead of
>   kcsan_check_{access,atomic}.
> * Introduce __atomic_check_{read,write} [Suggested by Mark Rutland].
> ---
>  include/asm-generic/atomic-instrumented.h | 393 +++++++++++-----------
>  scripts/atomic/gen-atomic-instrumented.sh |  17 +-
>  2 files changed, 218 insertions(+), 192 deletions(-)

The script changes and generated code look fine to me, so FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index e09812372b17..8b8b2a6f8d68 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -20,7 +20,7 @@ gen_param_check()
>  	# We don't write to constant parameters
>  	[ ${type#c} != ${type} ] && rw="read"
>  
> -	printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
> +	printf "\t__atomic_check_${rw}(${name}, sizeof(*${name}));\n"
>  }
>  
>  #gen_param_check(arg...)
> @@ -107,7 +107,7 @@ cat <<EOF
>  #define ${xchg}(ptr, ...)						\\
>  ({									\\
>  	typeof(ptr) __ai_ptr = (ptr);					\\
> -	kasan_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
> +	__atomic_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
>  	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
>  })
>  EOF
> @@ -148,6 +148,19 @@ cat << EOF
>  
>  #include <linux/build_bug.h>
>  #include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
> +static inline void __atomic_check_read(const volatile void *v, size_t size)
> +{
> +	kasan_check_read(v, size);
> +	kcsan_check_atomic_read(v, size);
> +}
> +
> +static inline void __atomic_check_write(const volatile void *v, size_t size)
> +{
> +	kasan_check_write(v, size);
> +	kcsan_check_atomic_write(v, size);
> +}
>  
>  EOF
>  
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 
