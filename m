From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
Date: Tue, 21 Jul 2020 16:09:29 +0200
Message-ID: <20200721140929.GB10769@hirez.programming.kicks-ass.net>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-5-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgGUOJi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:09:38 -0400
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-5-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, will@kernel.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30:12PM +0200, Marco Elver wrote:
> Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks for the builtin atomics
> instrumentation.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Added to this series, as it would otherwise cause patch conflicts.
> ---
>  kernel/kcsan/core.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 4633baebf84e..f53524ea0292 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -892,14 +892,17 @@ EXPORT_SYMBOL(__tsan_init);
>  	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
>  	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
>  	{                                                                                          \
> -		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
> +		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> +			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);              \
>  		return __atomic_load_n(ptr, memorder);                                             \
>  	}                                                                                          \
>  	EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
>  	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
>  	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
>  	{                                                                                          \
> -		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
> +		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> +			check_access(ptr, bits / BITS_PER_BYTE,                                    \
> +				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);                    \
>  		__atomic_store_n(ptr, v, memorder);                                                \
>  	}                                                                                          \
>  	EXPORT_SYMBOL(__tsan_atomic##bits##_store)
> @@ -908,8 +911,10 @@ EXPORT_SYMBOL(__tsan_init);
>  	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
>  	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
>  	{                                                                                          \
> -		check_access(ptr, bits / BITS_PER_BYTE,                                            \
> -			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
> +		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> +			check_access(ptr, bits / BITS_PER_BYTE,                                    \
> +				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> +					     KCSAN_ACCESS_ATOMIC);                                 \
>  		return __atomic_##op##suffix(ptr, v, memorder);                                    \
>  	}                                                                                          \
>  	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
> @@ -937,8 +942,10 @@ EXPORT_SYMBOL(__tsan_init);
>  	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
>  							      u##bits val, int mo, int fail_mo)    \
>  	{                                                                                          \
> -		check_access(ptr, bits / BITS_PER_BYTE,                                            \
> -			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
> +		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> +			check_access(ptr, bits / BITS_PER_BYTE,                                    \
> +				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> +					     KCSAN_ACCESS_ATOMIC);                                 \
>  		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
>  	}                                                                                          \
>  	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
> @@ -949,8 +956,10 @@ EXPORT_SYMBOL(__tsan_init);
>  	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
>  							   int mo, int fail_mo)                    \
>  	{                                                                                          \
> -		check_access(ptr, bits / BITS_PER_BYTE,                                            \
> -			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
> +		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> +			check_access(ptr, bits / BITS_PER_BYTE,                                    \
> +				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> +					     KCSAN_ACCESS_ATOMIC);                                 \
>  		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
>  		return exp;                                                                        \
>  	}                                                                                          \


*groan*, that could really do with a bucket of '{', '}'. Also, it is
inconsistent in style with the existing use in
DEFINE_TSAN_VOLATILE_READ_WRITE() where the define causes an early
return.
