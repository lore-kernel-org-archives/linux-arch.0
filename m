Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454208;
	b=30QyD/vAcMxg2V4RZ2yrcnTtHQd3Bcr62SYFCLE7lIIA1IDOySyhxdPsxrgTyF5SgMbH
	 ab0V+c1QuhTTORjIbR+55RmkPo1o8vmdZrogbESQaQqEZSBEErrVCAKm9i2ClELTQE3PB
	 9DixuQkdcgYXfvPjxEeNcw1+v4oAM2DBZrBbm0l3MUH4PUtexIBRhc7InvRaAmerLaKdx
	 79ypfk6lL4JDi+EGxSaUYfuXxCC+RzMJGQtWLxJNsgMx5KjpfLXGB+sHzX3tCVrZfwmws
	 SVi3F4O4Z2nJRHh26LkSmjRuQN1DU4JrzsOla7Rf5d84gNM0n8InxeGVCN99Ry/iKVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454208;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=z9ugbRFtepT8lOB17TZSNPg/oII/opdNslH+HVfUMgE=;
	b=KtTMWxAbkvEbWQntyJCKmSL5se1surG+2AAaQL3K5LLTUW22LWq6oNzR3cc+A2nupYoW
	 DSXES+2Qzshi8i61EM12O8LWBGlCn0qedU7EXrCbS2riuLV02nE7L384wL+J1sKie5UN3
	 5lWvZgf5YBVMSte5kFkUaZKPwT7HNOY5sGB/o+xDL74ceLBlCcUvDYPcQUIZNqu/YoQ0t
	 OHkdsrnOp0STc8VX0D+blWPLTGjVWvPBQpttpaRpIGZdI5xcCoaMkpgBPsjmixuD7c84N
	 xDvzRpU6GdelTq3zpsEA9gprFMrpYCye/ctlUmgR6dKgLCfinyRbL1Mh8qZiWKvclKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mv1MzkWc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092860A260E;
	Sat, 31 Oct 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mv1MzkWc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C5C1F00A15;
	Sat, 31 Oct 2026 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454207;
	bh=z9ugbRFtepT8lOB17TZSNPg/oII/opdNslH+HVfUMgE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Mv1MzkWcHnurpn7lktWo6a25e8NVHuPBjDNwfX54NMYiIYWrgtDtOzGE3vO/nge6U
	 GAxecgI1db5SKk/xa2qJn8qGeDjzK/sFf2Jm265MQu4bCWZ5GO8bowbwucR+L1GVZ8
	 vrR8E7imBeWF+wRkxsSrdm5zrVgv/N3HjMTpwcbvXUSOnx7l0GQZmiYWO4VsqgF3y9
	 Ce5BbhXx1x6YlsR+RE2MPzJwMlDq/r8LabDBWU9fLcmB6Expx7oVe2roOWng3b8qW4
	 +m7ZECAHHN0dkg2YIfRSdE+nqaLs2dJdrG6qY5zth7lIZ1ZA19x/A+m+2jwMZQYdOd
	 C6ChYDq1KuNuw==
Content-Type: multipart/mixed; boundary="===============7704618518988457790=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4ff8548aae0e33d90f9b6b294e642d0de460b983ccc711b31dcbb374267d44da@mail.kernel.org>
In-Reply-To: <20261031130959.23472-9-wanjay@amazon.com>
References: <20261031130959.23472-9-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 08/13] tracing: parse the vmlinux BTF when BTF-typed output is enabled
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:43:27 +0000 (UTC)

--===============7704618518988457790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tracing: parse the vmlinux BTF when BTF-typed output is enabled

TL;DR:
- irqsoff/wakeup tracers may print function lines without arguments, since
  they never call trace_btf_prepare() and the lazy BTF may be unparsed
- Author's Signed-off-by is a TODO placeholder

>     tracing: parse the vmlinux BTF when BTF-typed output is enabled
>
>     func-args of the function tracer, and funcgraph-args and
>     funcgraph-retval of the function_graph tracer, print arguments and
>     return values by their BTF types: print_function_args() and
>     btf_trim_retval() look the function up with btf_find_func_proto(),
>     which parses the vmlinux BTF if nobody has yet.  Since commit
>     42643ba35deb ("tracing: Avoid BTF lookup in atomic context") they do not
>     do that in atomic context, but they still can in the readers of the
>     trace: s_show() and tracing_read_pipe() print under trace_event_sem and
>     the trace access lock, while the tracer keeps recording, by default
>     into the buffer being read.
>
>     Today the BTF is always parsed at boot, so this cannot happen.  To keep
>     it that way once the vmlinux BTF can be parsed on first use
>     (CONFIG_DEBUG_INFO_BTF_LAZY, later in this series), parse it when such
>     output is enabled instead: trace_btf_prepare() is called from
>     select_trace_function() when func-args is set, from graph_trace_init()
>     when funcgraph-args or funcgraph-retval is set, and from
>     func_graph_set_flag() when either is turned on, all with
>     trace_types_lock held.  The two printers only peek at the BTF and fall
>     back to the output without it if it is not parsed, which then cannot
>     happen while the option is in effect.
>
>     "trace_options=" on the command line sets the options from
>     early_trace_init() in start_kernel(), with interrupts disabled and
>     before btf_alloc_id() can allocate; while the system is still booting
>     (system_state < SYSTEM_SCHEDULING) trace_btf_prepare() only records the
>     request, and a core_initcall parses the BTF.
>
>     Reading an event's btf_ids file looks the BTF up under event_mutex;
>     parse it before taking the mutex, as the CO-RE candidate lookup does
>     before cand_cache_mutex.
>
>     No functional change with today's eager parse, except that with such
>     an option on the command line the BTF is parsed at core_initcall time,
>     before the initcalls that would otherwise parse it.
>
>     TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>     [moved trace_func_args_prepare() to trace_btf.c as trace_btf_prepare();
>      extended it to funcgraph-retval and the btf_ids file; the printers check
>      the BTF with bpf_peek_btf_vmlinux() in front of btf_find_func_proto()]
>     Signed-off-by: Jay Wang <wanjay@amazon.com>

The patch is authored by Ihor Solodrai, but the only Signed-off-by in the
trailer block is Jay Wang's.  Is this line meant to be the author's
sign-off?

    TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

With the "TODO-NEEDS-IHOR:" prefix it is not a Signed-off-by tag, so the
patch carries no sign-off from its author, which
Documentation/process/submitting-patches.rst requires.  The placeholder
text would also end up in the changelog as is.

Should the prefix be dropped before this is applied?

> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index a5ad76175d10..cdb926c9d4e2 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c

[ ... ]

> @@ -739,6 +739,9 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  	if (lookup_symbol_name(func, name))
>  		goto out;
>  
> +	/* see trace_btf_prepare() */
> +	if (IS_ERR_OR_NULL(bpf_peek_btf_vmlinux()))
> +		goto out;
>  	/* TODO: Pass module name here too */
>  	t = btf_find_func_proto(name, &btf);
>  	if (IS_ERR_OR_NULL(t))

Are func-args, funcgraph-args and funcgraph-retval the only producers of
entries that carry arguments?

Since commit 76fe0337c219 ("ftrace: Add arguments to function tracer"), the
latency tracers pass fregs straight to trace_function(), whatever the
func-args option says:

irqsoff_tracer_call() (kernel/trace/trace_irqsoff.c):
	trace_function(tr, ip, parent_ip, trace_ctx, fregs);

wakeup_tracer_call() (kernel/trace/trace_sched_wakeup.c):
	trace_function(tr, ip, parent_ip, trace_ctx, fregs);

trace_function() reserves room for FTRACE_REGS_MAX_ARGS arguments and
stores them whenever fregs is non-NULL.  On x86_64 and arm64, which are the
only architectures CONFIG_DEBUG_INFO_BTF_LAZY allows, ftrace_caller always
passes a non-NULL fregs.

When the irqsoff, preemptoff, preemptirqsoff, wakeup, wakeup_rt or
wakeup_dl tracer runs with function tracing on (the default, not in
display-graph mode), irqsoff_print_line()/wakeup_print_line() return
TRACE_TYPE_UNHANDLED.  The entry then goes through:

trace_fn_trace()
  print_fn_trace()
    print_function_args()

with args != NULL.

None of these tracers calls trace_btf_prepare(), and they have no func-args
option that would.  With CONFIG_DEBUG_INFO_BTF_LAZY (added later in this
series by 66c4a6a9293d, e46b5971bc91 and cae96a9f7395), if nothing else has
parsed the vmlinux BTF yet, the peek returns NULL and every function line
in these tracers prints as "func()" where it used to print
"func(a=..., b=0x...)".  Before this patch the reader would have parsed the
BTF on demand.

The same applies to a boot-mapped persistent instance that holds the
previous boot's func-args entries.  It is read-only and no tracer is
started on it, so nothing prepares the BTF.

The commit message says the fallback "then cannot happen while the option
is in effect", and the comment above trace_btf_prepare() lists only
func-args, funcgraph-args and funcgraph-retval.  Neither covers these
producers, and no later commit in 38e2751cdb40..4d32ca0c95ea touches
trace_irqsoff.c or trace_sched_wakeup.c or adds another
trace_btf_prepare() call.

Should the irqsoff/wakeup tracers call trace_btf_prepare() from their init
when function tracing records args, or should their trace_function() calls
pass NULL fregs unless args are wanted?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============7704618518988457790==--
