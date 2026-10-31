Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454941;
	b=rw1oJkEffFPRuj63tnl4CiZJVWvc6EchVuXpsp7oOBTnROToWVTk8470nuuqKejB4wXu
	 0rcfJZ1haXT8XWPVOthBqL9AdnZIyQ3WVTeTXGMiPHL+TBsvQQUfEQDpJ32gKCIIdKBji
	 2Pb787kc0whn/Z2mfNXjNha2bfLjdRs4MiJR5dvwZGx514MeEeQ3t9/r2siKBwHrCY8Rq
	 YX9m2cwlrIIBkIG+6m+qTmpYamIluzPF0IeQ2dIfi77i839g62YlcCu3GRTgQopnAQ739
	 yLdirb4+GaFuybIt0wPwJdn+YWIjTlrPFUHsruU/Dojqj4l4/f9h3pvLmf9+rFxRVpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454941;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=SfRIxaGJLK/TxQe7BtY57YPRwVwg1sw1o69yhwgKRCA=;
	b=yeFWWqEiw1QRKEb2EpfdYCkPBJEU4bIBQhIo0UG6R1NTP0u4orNesV0B2wMVg6bivtGb
	 K/iBvDPw+des4nsI9j9dH94ZtzCeuluDFEdXHUhRMtStF9GCWPTkLRoGqsyeglXmtBaKa
	 2A1jYA/BPyFG+WbkFKpeWpKu1pvrrkJXKK97nBcoRzSRFu3YSokUoD1ZgwlYsDDi8G/Wc
	 a5XY+W464oYlZqRUBXynxjq9eAC9kT5e6jlvBNfXla7XY3Vm8flByBoRUYblUOdEHfg96
	 l4arOukP4AdOxldz5JC6xkRHrATtXhR59dmQJjq/sHkjt5Avwz3rcTMOUEJgBegLrvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkwJy1a6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A2606A330;
	Sat, 31 Oct 2026 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkwJy1a6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A9C1F00A17;
	Sat, 31 Oct 2026 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454941;
	bh=SfRIxaGJLK/TxQe7BtY57YPRwVwg1sw1o69yhwgKRCA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XkwJy1a6/qqwFqlBPSbPei8mZIpqCfX3vtFkvS1gBvDkRVULFU13DWtjWdO9gmmXA
	 TfYLqVnair3D5UZh93fe+sRjslYzbJvFew9Cpbzay2PXq29BtgPzBpDOZzxAuyDKJF
	 CI1gY7BFAzYw8p6B/eUU7pcRMlWPKx6RrVdMm2qiv2Oz/Evjm12nWLOJADFt8VrsNL
	 cOM3h7q11LY8p4SHJtZC3DizwiY38lZW0aIV4LNaXc/1zpUOAwTzWeIPuqK1YKOlfc
	 BAqSGuOboHDGmvLFfO3WYqr65C6GA/7e9w8v9OYFm0pOUqRg7cFlcDXHId9L+7FoO1
	 lnGmGcR9AHOlg==
Content-Type: multipart/mixed; boundary="===============1389222973622085419=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5b30c8da1e5fa12691926f41a2a845d2a6f47ce33611c249c79350e67f4e636e@mail.kernel.org>
In-Reply-To: <20261031130959.23472-3-wanjay@amazon.com>
References: <20261031130959.23472-3-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 02/13] bpf: fetch the vmlinux BTF where kernel types enter a program
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:55:40 +0000 (UTC)

--===============1389222973622085419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: fetch the vmlinux BTF where kernel types enter a program

TL;DR:
- check_ptr_to_map_access(): without BTF, the map_ptr error now names the map
  type, not the missing BTF, and the new !btf branch looks unreachable
- Co-developed-by is followed by a placeholder, not a Signed-off-by (commit
  message)

> bpf: fetch the vmlinux BTF where kernel types enter a program
>
> bpf_check() fetches the vmlinux BTF up front for every program, whether
> the program uses kernel types or not.  That is free today because the
> BTF is parsed at boot anyway.  Once it can be parsed on first use
> (CONFIG_DEBUG_INFO_BTF_LAZY, later in this series), it would make every
> program load pay for parsing 5-7 MB of BTF, including the socket filters
> systemd loads at boot.
> Drop the up-front fetch and fetch where kernel types enter the verifier
> state instead:
>  - bpf_add_kfunc_call(), for the first kfunc call of a program;
>  - check_ptr_to_map_access(), for map_ptr field access;
>  - check_pseudo_btf_id(), for ldimm64 of a kernel variable (ksym);
>  - check_helper_call(), for helpers whose prototype takes
>    ARG_PTR_TO_BTF_ID or returns RET_PTR_TO_BTF_ID, and for
>    bpf_snprintf_btf() and bpf_seq_printf_btf(), which take a kernel
>    type id inside struct btf_ptr (helper_uses_vmlinux_btf()).
> The other ways in already fetch the BTF themselves: attach_btf in
> bpf_prog_load(), struct_ops map creation, CO-RE candidate lookup,
> bpf_find_btf_id(), btf_prepare_func_args() for kernel-typed arguments
> and the kernel context type lookups.  The remaining reads of the
> btf_vmlinux global in the verifier are on paths dominated by one of
> these fetches.  A program that uses none of them, such as a socket
> filter, does not need the vmlinux BTF any more, and verifies the same
> whether or not it has been parsed.
> Four related changes keep it that way:
>  - The "in-kernel BTF is malformed" check in bpf_check() read the
>    global right after the up-front fetch.  Without the fetch it would
>    pass or fail depending on whether something else had parsed the BTF
>    before, so drop it; every fetch point reports a missing BTF itself
>    and passes on an error of the parse, as that check did.
>  - check_ptr_to_map_access() checks allow_ptr_leaks before it fetches
>    the BTF, and bpf_prog_load() falls back to the vmlinux BTF for an
>    attach_btf_id only with CAP_BPF, which all program types that take
>    one need, so that an unprivileged load cannot make the kernel parse
>    it only to be refused.  The map_ptr permission error can then not
>    name the map's struct any more and says "map_ptr access is allowed
>    only to CAP_PERFMON and CAP_SYS_ADMIN".  A ksym, which unprivileged
>    programs may use, still parses it.
>  - Add bpf_peek_btf_vmlinux(), which returns the vmlinux BTF only if it
>    is parsed already, and use it in bpf_btf_printf_prepare().  The BTF
>    printf helpers run in program context, which may be atomic, and the
>    verifier has fetched the BTF for every program that calls them.
>  - is_kfunc_dynptr_write(), reached from the argument checks that
>    helpers and kfuncs share, compared meta->btf with the global, which
>    a helper's NULL matches while the global is NULL.  Check that the
>    call is a kfunc first, as the other kfunc predicates there do.
> Helpers taking ARG_PTR_TO_BTF_ID_SOCK_COMMON are left out on purpose:
> they take sockets without BTF types too, the shared argument check reads
> the global only for a PTR_TO_BTF_ID register, and every source of such
> a register fetched the BTF.
> No functional change with CONFIG_DEBUG_INFO_BTF=y, where kfunc
> registrations at boot parse the BTF, other than that error message and
> that, if the vmlinux BTF fails to parse (a broken toolchain), programs
> that use no kernel types now load instead of failing.  Without BTF the
> new helper check is compiled out and the existing error paths are
> unchanged.
> Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Jay Wang <wanjay@amazon.com>

This isn't a bug, but the Co-developed-by: tag is followed by a placeholder
line, "TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai
<ihor.solodrai@linux.dev>", rather than a real Signed-off-by: line.

Documentation/process/submitting-patches.rst asks for a Co-developed-by: to
be immediately followed by that co-author's Signed-off-by:.  Should the
placeholder be replaced with the real tag before this is applied?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b6c0674ff6a..18b2bd009d58 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6867,30 +6883,33 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
>  	enum bpf_type_flag flag = 0;
>  	const struct btf_type *t;
>  	const char *tname;
> +	struct btf *btf;
>  	u32 btf_id;
>  	int ret;
>
> -	if (!btf_vmlinux) {
> -		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_BTF\n");
> -		return -ENOTSUPP;
> -	}
> -
>  	if (!map->ops->map_btf_id || !*map->ops->map_btf_id) {
>  		verbose(env, "map_ptr access not supported for map type %d\n",
>  			map->map_type);
>  		return -ENOTSUPP;
>  	}
>
> -	t = btf_type_by_id(btf_vmlinux, *map->ops->map_btf_id);
> -	tname = btf_name_by_offset(btf_vmlinux, t->name_off);
> -
> +	/* before the BTF fetch: unprivileged loads must not parse it */
>  	if (!env->allow_ptr_leaks) {
> -		verbose(env,
> -			"'struct %s' access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
> -			tname);
> +		verbose(env, "map_ptr access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n");
>  		return -EPERM;
>  	}
>
> +	btf = bpf_get_btf_vmlinux();
> +	if (IS_ERR(btf))
> +		return vmlinux_btf_err(env, btf);
> +	if (!btf) {
> +		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_BTF\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	t = btf_type_by_id(btf, *map->ops->map_btf_id);
> +	tname = btf_name_by_offset(btf, t->name_off);
> +
>  	if (off < 0) {

Can the new "if (!btf)" branch ever be reached?

Without CONFIG_DEBUG_INFO_BTF, every map type's .map_btf_id points at a
zero-filled array:

include/linux/btf_ids.h:
    #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_unused name[1];

so "!*map->ops->map_btf_id" is true for every map, and the function returns
at the first check with "map_ptr access not supported for map type %d".

With CONFIG_DEBUG_INFO_BTF=y, bpf_get_btf_vmlinux() returns either a BTF or
an ERR_PTR, never NULL, so the branch is unreachable in that configuration
too.

Before this patch, "if (!btf_vmlinux)" was the first test.  On a kernel
without BTF, a privileged program doing "r0 = *(u32 *)(map_ptr + off)" was
told:

    map_ptr access not supported without CONFIG_DEBUG_INFO_BTF

It is now told, for example:

    map_ptr access not supported for map type 1

That message points at the map type rather than at the missing BTF.  The
errno (-ENOTSUPP) is unchanged.

This also looks at odds with the commit message statement "Without BTF the
new helper check is compiled out and the existing error paths are
unchanged."

Would an early IS_ENABLED(CONFIG_DEBUG_INFO_BTF) test with the old message,
placed before the map_btf_id check, be a way to keep the old diagnostic?  It
would not fetch or parse anything, so the allow_ptr_leaks-before-fetch
ordering would stay as is.

No later commit in the series changes check_ptr_to_map_access().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============1389222973622085419==--
