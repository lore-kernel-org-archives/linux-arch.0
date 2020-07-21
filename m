From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/8] locking/atomics: Use read-write instrumentation for
 atomic RMWs
Date: Tue, 21 Jul 2020 16:18:59 +0200
Message-ID: <20200721141859.GC10769@hirez.programming.kicks-ass.net>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-9-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-9-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, will@kernel.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 12:30:16PM +0200, Marco Elver wrote:

> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index 6afadf73da17..5cdcce703660 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -5,9 +5,10 @@ ATOMICDIR=$(dirname $0)
>  
>  . ${ATOMICDIR}/atomic-tbl.sh
>  
> -#gen_param_check(arg)
> +#gen_param_check(meta, arg)
>  gen_param_check()
>  {
> +	local meta="$1"; shift
>  	local arg="$1"; shift
>  	local type="${arg%%:*}"
>  	local name="$(gen_param_name "${arg}")"
> @@ -17,17 +18,24 @@ gen_param_check()
>  	i) return;;
>  	esac
>  
> -	# We don't write to constant parameters
> -	[ ${type#c} != ${type} ] && rw="read"
> +	if [ ${type#c} != ${type} ]; then
> +		# We don't write to constant parameters
> +		rw="read"
> +	elif [ "${meta}" != "s" ]; then
> +		# Atomic RMW
> +		rw="read_write"
> +	fi

If we have meta, should we then not be consistent and use it for read
too? Mark?

>  
>  	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
>  }
>  
> -#gen_param_check(arg...)
> +#gen_params_checks(meta, arg...)
>  gen_params_checks()
>  {
> +	local meta="$1"; shift
> +
>  	while [ "$#" -gt 0 ]; do
> -		gen_param_check "$1"
> +		gen_param_check "$meta" "$1"
>  		shift;
>  	done
>  }
> @@ -77,7 +85,7 @@ gen_proto_order_variant()
>  
>  	local ret="$(gen_ret_type "${meta}" "${int}")"
>  	local params="$(gen_params "${int}" "${atomic}" "$@")"
> -	local checks="$(gen_params_checks "$@")"
> +	local checks="$(gen_params_checks "${meta}" "$@")"
>  	local args="$(gen_args "$@")"
>  	local retstmt="$(gen_ret_stmt "${meta}")"
>  
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 
