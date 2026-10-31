Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452232;
	b=jGYw4leYa2Z3wHBn1eS6iu8AJPwk2k/F/NpR0zWSNa7nhlMkz4POO4IHXqfz6hVd0ubP
	 it/kLvInytR1O0L5QEAktZ92WiWk5uNhjuXXFdwrRh6txLrVOHSq+umy3Qv/zLpMjYSrK
	 xj9tS/S+jWWw/bTRrhGw6bFQefZ08Hm72RVbdzY4mEcYqXJ8c70c9LNAgrhwr57HSpM4B
	 5+bJZJTl6YIeUjFeDkPAs6S35Y2CPVZY68WeHk0/NLIVQ7ONf+Ln0bITf/+PKGQMfGaJQ
	 PCTgSE1rW9pWIbkVPPWQWXDwUHREgxS5uQ7cvGKz//6nGIkKbDwFUhAQYMiiPWmsG2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=lGRAs4vt5KMPZuu9CZXHUwbaZTBRFd/ZBV6OBn1gtmE=;
	b=wfnIreY8QZnelS3URrXG+472bLN6uhoTLmnqQ9iZJU2JEg1Wzsqbz+nh0D+uJwcDQZ+Z
	 gRq0A/WZHZO3hgjXjKTDHy1NK9aZYn4GeIXJBxSEZJVWwElhKG4apPoWPkqvU0SH8fJb3
	 /zOO/oKVceNkCllE3ohG5x2QMIRK0w3+rYWe8o3QtxcguLKTSz5shianh0Kji+BrBnBzZ
	 6EJQ3H42JyDr5i3dxsh0RORQqdkBlbTuMfP2IMAEZZqqiMTu8HLIZ5kjj3diwvUCA+ojh
	 YDRvzGofDx2ruTqdbIlUjhaCHMACISTIQ189lNEN/vYrAYtpomaBcVZoGwWldTGFJWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=M9oUDbF0;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591A606A31D;
	Sat, 31 Oct 2026 13:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0591A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=M9oUDbF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452232; x=1824988232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGRAs4vt5KMPZuu9CZXHUwbaZTBRFd/ZBV6OBn1gtmE=;
  b=M9oUDbF0jAItySpEJLGwSmTYuN0hzxJE2lgGE6zA9qNxAvvwhIJUkM/H
   Cmo4W1cvcEa612bB969WqGJS9UbQMIuqCH4H+pPojbAdvxKkGeK/ZCMRa
   COpvasfZaSPkz/Rqw7/jKusa6jrWpU5AYyvkrWTgoy3vFsm4AigCcUhOp
   il7294A2dZWA3uPVJHBrPltsnUX9HR+OocjDGxzjsWq2CRbrJGkDcycym
   qgACTCj9cuUH1PsHK/XuEj1g0ZeZYKBpGyH0ol06eSg1Eb9mIdSeSsNu+
   Pxv0DEM9laH7vcneZxtVaURXfHqU78G64CcoIf/viC2qOBj3y7hFWH3Al
   w==;
X-CSE-ConnectionGUID: p2esLNy9SZGMFYt3wJkW6g==
X-CSE-MsgGUID: QWc5z/nASLO2oU2J0tPWtA==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32528560"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:10:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:17552]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id 112056f9-52d1-46ec-849b-6ead07ea6cc2; Sat, 31 Oct 2026 13:10:31 +0000 (UTC)
X-Farcaster-Flow-ID: 112056f9-52d1-46ec-849b-6ead07ea6cc2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:10:31 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:10:30 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire
	<almagui@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, <linux-arch@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, "Martin
 Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 02/13] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Sat, 31 Oct 2026 13:09:48 +0000
Message-ID: <20261031130959.23472-3-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031130959.23472-1-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

bpf_check() fetches the vmlinux BTF up front for every program, whether
the program uses kernel types or not.  That is free today because the
BTF is parsed at boot anyway.  Once it can be parsed on first use
(CONFIG_DEBUG_INFO_BTF_LAZY, later in this series), it would make every
program load pay for parsing 5-7 MB of BTF, including the socket filters
systemd loads at boot.

Drop the up-front fetch and fetch where kernel types enter the verifier
state instead:

 - bpf_add_kfunc_call(), for the first kfunc call of a program;
 - check_ptr_to_map_access(), for map_ptr field access;
 - check_pseudo_btf_id(), for ldimm64 of a kernel variable (ksym);
 - check_helper_call(), for helpers whose prototype takes
   ARG_PTR_TO_BTF_ID or returns RET_PTR_TO_BTF_ID, and for
   bpf_snprintf_btf() and bpf_seq_printf_btf(), which take a kernel
   type id inside struct btf_ptr (helper_uses_vmlinux_btf()).

The other ways in already fetch the BTF themselves: attach_btf in
bpf_prog_load(), struct_ops map creation, CO-RE candidate lookup,
bpf_find_btf_id(), btf_prepare_func_args() for kernel-typed arguments
and the kernel context type lookups.  The remaining reads of the
btf_vmlinux global in the verifier are on paths dominated by one of
these fetches.  A program that uses none of them, such as a socket
filter, does not need the vmlinux BTF any more, and verifies the same
whether or not it has been parsed.

Four related changes keep it that way:

 - The "in-kernel BTF is malformed" check in bpf_check() read the
   global right after the up-front fetch.  Without the fetch it would
   pass or fail depending on whether something else had parsed the BTF
   before, so drop it; every fetch point reports a missing BTF itself
   and passes on an error of the parse, as that check did.

 - check_ptr_to_map_access() checks allow_ptr_leaks before it fetches
   the BTF, and bpf_prog_load() falls back to the vmlinux BTF for an
   attach_btf_id only with CAP_BPF, which all program types that take
   one need, so that an unprivileged load cannot make the kernel parse
   it only to be refused.  The map_ptr permission error can then not
   name the map's struct any more and says "map_ptr access is allowed
   only to CAP_PERFMON and CAP_SYS_ADMIN".  A ksym, which unprivileged
   programs may use, still parses it.

 - Add bpf_peek_btf_vmlinux(), which returns the vmlinux BTF only if it
   is parsed already, and use it in bpf_btf_printf_prepare().  The BTF
   printf helpers run in program context, which may be atomic, and the
   verifier has fetched the BTF for every program that calls them.

 - is_kfunc_dynptr_write(), reached from the argument checks that
   helpers and kfuncs share, compared meta->btf with the global, which
   a helper's NULL matches while the global is NULL.  Check that the
   call is a kfunc first, as the other kfunc predicates there do.

Helpers taking ARG_PTR_TO_BTF_ID_SOCK_COMMON are left out on purpose:
they take sockets without BTF types too, the shared argument check reads
the global only for a PTR_TO_BTF_ID register, and every source of such
a register fetched the BTF.

No functional change with CONFIG_DEBUG_INFO_BTF=y, where kfunc
registrations at boot parse the BTF, other than that error message and
that, if the vmlinux BTF fails to parse (a broken toolchain), programs
that use no kernel types now load instead of failing.  Without BTF the
new helper check is compiled out and the existing error paths are
unchanged.

Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/syscall.c     |  8 +++-
 kernel/bpf/verifier.c    | 98 ++++++++++++++++++++++++++++++----------
 kernel/trace/bpf_trace.c |  3 +-
 4 files changed, 83 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 580f89c450b5..1fd6ef2ef5c6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3257,6 +3257,7 @@ static inline s32 bpf_call_args_imm(s16 idx)
 #endif
 
 struct btf *bpf_get_btf_vmlinux(void);
+struct btf *bpf_peek_btf_vmlinux(void);
 
 /* Map specifics */
 struct xdp_frame;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ca72b35cdcc9..9273b7dee0aa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3052,8 +3052,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 				goto put_token;
 			}
 		}
-	} else if (attr->attach_btf_id || multi_func) {
-		/* fall back to vmlinux BTF, if BTF type ID is specified */
+	} else if ((attr->attach_btf_id || multi_func) && bpf_cap) {
+		/*
+		 * fall back to vmlinux BTF, if BTF type ID is specified; only
+		 * program types that need CAP_BPF take one, and
+		 * bpf_prog_load_check_attach() refuses it for the others
+		 */
 		attach_btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(attach_btf)) {
 			err = PTR_ERR(attach_btf);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d2056218..1b901e3cb3c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3060,6 +3060,18 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			       const struct btf_func_model *fm, struct bpf_func_proto *proto);
 
+/*
+ * The vmlinux BTF failed to parse where a program first needs it: pass the
+ * error on, as bpf_check() did when it fetched the BTF up front.  It need
+ * not be for good: a parse on first use that runs out of memory is retried
+ * by the next caller.
+ */
+static int vmlinux_btf_err(struct bpf_verifier_env *env, const struct btf *btf)
+{
+	verbose(env, "in-kernel BTF could not be parsed: %ld\n", PTR_ERR(btf));
+	return PTR_ERR(btf);
+}
+
 int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 {
 	struct bpf_call_arg_meta meta;
@@ -3076,7 +3088,11 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	tab = prog_aux->kfunc_tab;
 	btf_tab = prog_aux->kfunc_btf_tab;
 	if (!tab) {
-		if (!btf_vmlinux) {
+		struct btf *btf = bpf_get_btf_vmlinux();
+
+		if (IS_ERR(btf))
+			return vmlinux_btf_err(env, btf);
+		if (!btf) {
 			verbose(env, "calling kernel function is not supported without CONFIG_DEBUG_INFO_BTF\n");
 			return -ENOTSUPP;
 		}
@@ -6867,30 +6883,33 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 	enum bpf_type_flag flag = 0;
 	const struct btf_type *t;
 	const char *tname;
+	struct btf *btf;
 	u32 btf_id;
 	int ret;
 
-	if (!btf_vmlinux) {
-		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_BTF\n");
-		return -ENOTSUPP;
-	}
-
 	if (!map->ops->map_btf_id || !*map->ops->map_btf_id) {
 		verbose(env, "map_ptr access not supported for map type %d\n",
 			map->map_type);
 		return -ENOTSUPP;
 	}
 
-	t = btf_type_by_id(btf_vmlinux, *map->ops->map_btf_id);
-	tname = btf_name_by_offset(btf_vmlinux, t->name_off);
-
+	/* before the BTF fetch: unprivileged loads must not parse it */
 	if (!env->allow_ptr_leaks) {
-		verbose(env,
-			"'struct %s' access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
-			tname);
+		verbose(env, "map_ptr access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n");
 		return -EPERM;
 	}
 
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(btf))
+		return vmlinux_btf_err(env, btf);
+	if (!btf) {
+		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_BTF\n");
+		return -ENOTSUPP;
+	}
+
+	t = btf_type_by_id(btf, *map->ops->map_btf_id);
+	tname = btf_name_by_offset(btf, t->name_off);
+
 	if (off < 0) {
 		verbose(env, "%s is %s invalid negative access: off=%d\n",
 			reg_arg_name(env, argno), tname, off);
@@ -12606,6 +12625,22 @@ static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return err;
 }
 
+/* Does helper @fn bring kernel BTF types into the program? */
+static bool helper_uses_vmlinux_btf(enum bpf_func_id func_id, const struct bpf_func_proto *fn)
+{
+	int i;
+
+	/* these take a kernel type id in struct btf_ptr */
+	if (func_id == BPF_FUNC_snprintf_btf || func_id == BPF_FUNC_seq_printf_btf)
+		return true;
+	if (base_type(fn->ret_type) == RET_PTR_TO_BTF_ID)
+		return true;
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++)
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
+			return true;
+	return false;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -12675,6 +12710,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
+	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF) && helper_uses_vmlinux_btf(func_id, fn)) {
+		/* never NULL with CONFIG_DEBUG_INFO_BTF */
+		struct btf *btf = bpf_get_btf_vmlinux();
+
+		if (IS_ERR(btf))
+			return vmlinux_btf_err(env, btf);
+	}
+
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		const char *suggestion;
 
@@ -13900,7 +13943,7 @@ BTF_SET_END(dynptr_write_kfuncs)
 
 static bool is_kfunc_dynptr_write(struct bpf_call_arg_meta *meta)
 {
-	return meta->btf == btf_vmlinux &&
+	return is_kfunc(meta) && meta->btf == btf_vmlinux &&
 	       btf_id_set_contains(&dynptr_write_kfuncs, meta->func_id);
 }
 
@@ -20898,12 +20941,14 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 	} else {
-		if (!btf_vmlinux) {
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR(btf))
+			return vmlinux_btf_err(env, btf);
+		if (!btf) {
 			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
 			return -EINVAL;
 		}
-		btf_get(btf_vmlinux);
-		btf = btf_vmlinux;
+		btf_get(btf);
 	}
 
 	err = __check_pseudo_btf_id(env, insn, aux, btf);
@@ -23122,6 +23167,13 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf;
 }
 
+/* The vmlinux BTF if it is parsed already: for callers that cannot sleep */
+struct btf *bpf_peek_btf_vmlinux(void)
+{
+	/* Pairs with the smp_store_release() in bpf_get_btf_vmlinux() */
+	return smp_load_acquire(&btf_vmlinux);
+}
+
 /*
  * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
  * this case expect that every file descriptor in the array is either a map or
@@ -23845,7 +23897,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret)
 		goto err_prep;
 
-	bpf_get_btf_vmlinux();
+	/*
+	 * The vmlinux BTF is not fetched here but where kernel types enter
+	 * the program (attach_btf, kfuncs, ksyms, map_ptr, BTF-typed helpers,
+	 * CO-RE, kernel ctx types), so that programs which use none of them
+	 * do not need it (CONFIG_DEBUG_INFO_BTF_LAZY).
+	 */
 
 	/* Serialize verification of unprivileged programs. */
 	if (!is_priv)
@@ -23866,13 +23923,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 
 	mark_verifier_state_clean(env);
 
-	if (IS_ERR(btf_vmlinux)) {
-		/* Either gcc or pahole or kernel are broken. */
-		verbose(env, "in-kernel BTF is malformed\n");
-		ret = PTR_ERR(btf_vmlinux);
-		goto skip_full_check;
-	}
-
 	env->strict_alignment = !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		env->strict_alignment = true;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index dfac5e1b8f40..84335e594388 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1018,7 +1018,8 @@ static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
 	if (btf_ptr_size != sizeof(struct btf_ptr))
 		return -EINVAL;
 
-	*btf = bpf_get_btf_vmlinux();
+	/* fetched by the verifier, see helper_uses_vmlinux_btf() */
+	*btf = bpf_peek_btf_vmlinux();
 
 	if (IS_ERR_OR_NULL(*btf))
 		return IS_ERR(*btf) ? PTR_ERR(*btf) : -EINVAL;
-- 
2.47.3

