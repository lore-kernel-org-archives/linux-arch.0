Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454204;
	b=S8ooHThtpMRgLMRV2knCK0oiZTungDifRRPsNvSzTGeViqtI+YSKcBA1Dv24mNb6j/hD
	 3+mgPmPgYvUgfJ72ueI+7ZguSLfREkoi6cndJDAlJf2ACH1Ah5trcuPaIckkdKzFIPeYV
	 gOrqs/Sq9XSBPohO1M9wpqAzOms56zSu7rmM3VhvrXZIWUOkeM3DVwEFA/3pkU7vv3bON
	 TMCPgdF6vTuadTTq128MOcg/ClQWXc0CfGJi44PUIRN4Zf0PBBAf9e+elkAGyX2qi/46q
	 +nWtovXfI3Ib/YJvq1acObivShywPkD0TvklyTycRTrvRBNbAhRaMJfzQWgktvXNVdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454204;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2YWEy3yXzkSyGvhSGBePYgtC/cO54L+S1nxwTyzECTw=;
	b=ArKshfrwU0+6AfuCDDwxxhY91CZZTul+qP3ixVZ1gWFusV+9ji2X6Jf0y2d6P7LrU27a
	 rEvLG8PO53ls8ZwmqkrgkoOhhxPP1iJX54zgvfpHVQnqY+7Viq5qlI4TJUkPRbuYXMrbw
	 /J3T4HGc4sBMKOYdxrrqg2FCQPwaVFaSUfzz5JjlK0VIHxkOtnw5aSGqtmB61/uwcoYF5
	 NA671P5M/48SbYvnluBD+eIpaaOmz+Mqc5lVnXKvqxdIQ2qGklTWNvyZ1IKnXuumOOYyP
	 pUK2oJDlsdXuVoueNY+ISknpLuC98TBYcVblLyoG6Zez9u+Bhy9um1SkF1WzM7yjDYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifh1Wo2v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A5606A31E;
	Sat, 31 Oct 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifh1Wo2v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1A71F00A02;
	Sat, 31 Oct 2026 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454204;
	bh=2YWEy3yXzkSyGvhSGBePYgtC/cO54L+S1nxwTyzECTw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ifh1Wo2vgegfwcCRUi9n7tRKq9cWvZmNJ40dsUf1JmIWQK4+7HiU0YLXj0TcGl+BW
	 AfzOKs4GXljGKSxVBJCcNdeP3sm7H3f47aoUXqeD+kiy7aeSYrKBUQ61EL05dljD08
	 vdn8vhJAeKr+hp3E2sknCtBQHBFkzG+2c63lXwgroWtVF2G4YZzWxUEZ8FWukcPS9M
	 cSgJBIlWW+swCWW5adwWXxNRI+AqGX7b3QcSxntKqJxMyT3V7H4CSKZr49aFj+Ghqe
	 YvyTaLnchrsCB910nAE9mj6Ek097N6s707WGEflthZW5jgFXlj6k1vAKiE3PGUokla
	 nup74QDnnqh0A==
Content-Type: multipart/mixed; boundary="===============4446748332422042200=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6d1e44ca667bb306e38c0662e42b17d46aff989efd749624fb17d79aab6ac416@mail.kernel.org>
In-Reply-To: <20261031130959.23472-2-wanjay@amazon.com>
References: <20261031130959.23472-2-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 01/13] bpf: match program context types by name without vmlinux BTF
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:43:23 +0000 (UTC)

--===============4446748332422042200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: match program context types by name without vmlinux BTF

TL;DR: Commit message only: a "TODO-NEEDS-IHOR: Signed-off-by:" placeholder
isn't a real trailer, so the author's Signed-off-by is missing (checkpatch
would flag it). It should be fixed or removed; other series commits may have
it too.

> bpf: match program context types by name without vmlinux BTF
>
> btf_is_prog_ctx_type() and btf_validate_prog_ctx_type() decide whether
> a BTF function argument is the program's context.  They look up the
> canonical context type of the program type in bpf_ctx_convert, a type
> that only exists in the vmlinux BTF, but then use nothing but its name:
> the argument's type name is compared with it, with the __sk_buff ->
> sk_buff and xdp_md -> xdp_buff projections, and with one typedef
> resolution step for bpf_user_pt_regs_t.
>
> btf_prepare_func_args() runs this check for the main program of every
> load that carries func_info (e.g. the socket filter and cgroup programs
> systemd loads at boot) and for subprograms.  Once the vmlinux BTF is
> parsed on first use (CONFIG_DEBUG_INFO_BTF_LAZY, later in this series),
> fetching the BTF here would make all of them pay for parsing it, and
> skipping the check when the BTF is not there yet would make the
> verification result (e.g. func_info "unreliable") depend on whether
> something else parsed the BTF first.
>
> Take the names from include/linux/bpf_types.h instead: a table indexed
> by program type is built from the prog_ctx_type argument of
> BPF_PROG_TYPE(), and prog_ctx_tname() returns the struct tag, or the
> typedef name.  For bpf_user_pt_regs_t it also returns the name of the
> underlying struct, found with __builtin_types_compatible_p() the same
> way btf_validate_prog_ctx_type() already does for perf_event programs.
> The other forms are equivalent to what the BTF lookup produced:
>
>  - typedefs of integers (__u64, __u32): the old code compared the
>    typedef name and then the integer type name, which never equals a
>    struct tag; only the typedef name is compared now;
>  - "void *" (tracing, struct_ops, ext, lsm, syscall): no named context
>    type, as before;
>  - s390 typedefs bpf_user_pt_regs_t to an anonymous struct: nothing
>    matches, as before; only the __arg_ctx error message changes from
>    "should be `struct  *`" to "should be void pointer";
>  - program types that are not configured in used to index
>    bpf_ctx_convert_map[] with 0 (socket filter); they now get no name.
>    Such programs cannot be loaded anyway.
>
> find_kern_ctx_type_id() and get_kern_ctx_btf_id() still need the kernel
> context type (tracing/EXT access to a BPF program's context argument,
> bpf_cast_to_kern_ctx()).  Kernel types enter the program there, so they
> now fetch the vmlinux BTF with bpf_get_btf_vmlinux() instead of relying
> on bpf_check() having done it.
>
> No change with CONFIG_DEBUG_INFO_BTF=y.  With CONFIG_DEBUG_INFO_BTF=n,
> global subprograms taking e.g. a struct __sk_buff *ctx now verify
> instead of failing with "btf_vmlinux is malformed", as they do with =y.
>
> TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> [split the BPF_PROG_TYPE() definition over two lines]
> Signed-off-by: Jay Wang <wanjay@amazon.com>

Is the "TODO-NEEDS-IHOR: Signed-off-by:" line at the end of the commit
message meant to stay in the submitted patch?

Because of the prefix, git and checkpatch do not parse that line as a
trailer, so the only real Signed-off-by is Jay Wang's, while the patch is
authored by Ihor Solodrai.  checkpatch would report "Missing Signed-off-by:
line by nominal patch author".

Should this become a real Signed-off-by line from the author (or be removed),
as required by the Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst?  The same placeholder appears in
other commits of this series (for example 32ad8adbb1a8).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============4446748332422042200==--
