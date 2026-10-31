Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452217;
	b=LnIiHM9JKQhgx1c5vogITEZDjD8iAllwEumtg862v6QloIhjejqAiI3n4ccUod4pRYNp
	 4JtN5tmz8ql9DLGfzI+zq43gLa6qsFr6LZ0n4M//cZzdOWfRBMPMJAcus4PsXFTIDz9I+
	 7/ya0c6CDGXHTBo2+ulW3Lf7qKs2vOGa/zalkzWoQ7y/wq3aafrzolCN4VDeqFMsWnLoC
	 hfFBeIu8XazTDR+v9HLdk6ahhKseQAXZ9+IilFjRvCAzvO1O/AIW70aNmPekISO9zOLIy
	 IfP8oMzC0MFNd+14ihFLNsvJuJxJRlb35qW8/zshqaX32hpwPZVQ6nASSfzQMnJ5gEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452217;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=WLwSPKJZysmtmpa3FI6ONURJasLxd8GwEWG5mergj7I=;
	b=zIo/YQ1brM5y6n/dM+mPfuv25Bvz8NljwAKLGIii9cDqPWqK/W7fbcBURuef2tQyyj/D
	 R8APh4OUPm9EVQJ6z7ArsM8wrT9SdDgfe3smmqu7yvy0YlleS7C1mKAIy4lb8DtethQaY
	 40MHTUkxcHlVyPyfoboxXhmpR8jZ9dZo1tAUlsLEmTZSCc5I8+WF7K+sy0M9cJBZNZvAQ
	 /U8xk9kL/+wF/caVIUZejhlFdb/uK1dXUSKuGL7+wtxTmpUd6D+sGuGjuY+5OXb38rtQh
	 Pd+ykomguB/BpGbs82Jsv9fH/OzZ4SsF3QJdXaTvkWpVsR+xry11jp0sleMSwKjUWKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qfMjLRls;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D6606A31A;
	Sat, 31 Oct 2026 13:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qfMjLRls
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452216; x=1824988216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WLwSPKJZysmtmpa3FI6ONURJasLxd8GwEWG5mergj7I=;
  b=qfMjLRlsL/K6iNtbax0YspXpjr++drya+goOKhbzZ0TW8QP8PFvzPnbi
   62XLLkW93tROcNqM72gMOw7v9olp2Unu8qa7CiHQZiJURfud/3pfzBirZ
   mbB4a0p4TOdRPQ4YCT2PtQWojZxLFusb96YkQKoTU3PpiIOterF5sXouu
   Brx7CY4QwN1vGvFp57iLcVGRGrKZ09ixO/U1B0DAjVa5wQg9aFs5L28Ng
   7uruFQcCgVYRb3S/hklSlxph04XmqWlD6/XeS/vpnsBUbXoC2gNAxmOxc
   pAuY7EY9Xb9jzRpSOGKCGydzcDqm5wy3m2WmSz6Hh4ZUEG6pALUAq2r2f
   A==;
X-CSE-ConnectionGUID: 3MCF7pz5TNW5oobuJGNqoA==
X-CSE-MsgGUID: dOK403tWQIae1ri+dpcJDQ==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32523547"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:10:16 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:12597]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.80:2525] with esmtp (Farcaster)
 id 28ed7a52-4df6-4b39-b04f-61f66360095c; Sat, 31 Oct 2026 13:10:15 +0000 (UTC)
X-Farcaster-Flow-ID: 28ed7a52-4df6-4b39-b04f-61f66360095c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:10:15 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:10:15 +0000
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
Subject: [PATCH bpf-next 01/13] bpf: match program context types by name without vmlinux BTF
Date: Sat, 31 Oct 2026 13:09:47 +0000
Message-ID: <20261031130959.23472-2-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Ihor Solodrai <ihor.solodrai@linux.dev>

btf_is_prog_ctx_type() and btf_validate_prog_ctx_type() decide whether
a BTF function argument is the program's context.  They look up the
canonical context type of the program type in bpf_ctx_convert, a type
that only exists in the vmlinux BTF, but then use nothing but its name:
the argument's type name is compared with it, with the __sk_buff ->
sk_buff and xdp_md -> xdp_buff projections, and with one typedef
resolution step for bpf_user_pt_regs_t.

btf_prepare_func_args() runs this check for the main program of every
load that carries func_info (e.g. the socket filter and cgroup programs
systemd loads at boot) and for subprograms.  Once the vmlinux BTF is
parsed on first use (CONFIG_DEBUG_INFO_BTF_LAZY, later in this series),
fetching the BTF here would make all of them pay for parsing it, and
skipping the check when the BTF is not there yet would make the
verification result (e.g. func_info "unreliable") depend on whether
something else parsed the BTF first.

Take the names from include/linux/bpf_types.h instead: a table indexed
by program type is built from the prog_ctx_type argument of
BPF_PROG_TYPE(), and prog_ctx_tname() returns the struct tag, or the
typedef name.  For bpf_user_pt_regs_t it also returns the name of the
underlying struct, found with __builtin_types_compatible_p() the same
way btf_validate_prog_ctx_type() already does for perf_event programs.
The other forms are equivalent to what the BTF lookup produced:

 - typedefs of integers (__u64, __u32): the old code compared the
   typedef name and then the integer type name, which never equals a
   struct tag; only the typedef name is compared now;
 - "void *" (tracing, struct_ops, ext, lsm, syscall): no named context
   type, as before;
 - s390 typedefs bpf_user_pt_regs_t to an anonymous struct: nothing
   matches, as before; only the __arg_ctx error message changes from
   "should be `struct  *`" to "should be void pointer";
 - program types that are not configured in used to index
   bpf_ctx_convert_map[] with 0 (socket filter); they now get no name.
   Such programs cannot be loaded anyway.

find_kern_ctx_type_id() and get_kern_ctx_btf_id() still need the kernel
context type (tracing/EXT access to a BPF program's context argument,
bpf_cast_to_kern_ctx()).  Kernel types enter the program there, so they
now fetch the vmlinux BTF with bpf_get_btf_vmlinux() instead of relying
on bpf_check() having done it.

No change with CONFIG_DEBUG_INFO_BTF=y.  With CONFIG_DEBUG_INFO_BTF=n,
global subprograms taking e.g. a struct __sk_buff *ctx now verify
instead of failing with "btf_vmlinux is malformed", as they do with =y.

TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
[split the BPF_PROG_TYPE() definition over two lines]
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 116 ++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 63 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 94d43612d211..1c7536a22a63 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6557,20 +6557,46 @@ static u8 bpf_ctx_convert_map[] = {
 #undef BPF_MAP_TYPE
 #undef BPF_LINK_TYPE
 
-static const struct btf_type *find_canonical_prog_ctx_type(enum bpf_prog_type prog_type)
+#define BPF_MAP_TYPE(_id, _ops)
+#define BPF_LINK_TYPE(_id, _name)
+#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
+	[_id] = #prog_ctx_type,
+static const char * const bpf_prog_ctx_tname[] = {
+#include <linux/bpf_types.h>
+};
+#undef BPF_PROG_TYPE
+#undef BPF_MAP_TYPE
+#undef BPF_LINK_TYPE
+
+struct user_regs_struct;
+struct user_pt_regs;
+
+/*
+ * Name of the context struct of @prog_type, as written in bpf_types.h, or NULL
+ * if it has none ("void *").  Only names are compared against the program's
+ * BTF, so the vmlinux BTF is not needed.  *@alt is set to the struct behind
+ * the bpf_user_pt_regs_t typedef.  Typedefs of integers (__u64, __u32) never
+ * match a struct name.
+ */
+static const char *prog_ctx_tname(enum bpf_prog_type prog_type, const char **alt)
 {
-	const struct btf_type *conv_struct;
-	const struct btf_member *ctx_type;
+	const char *name = prog_type < ARRAY_SIZE(bpf_prog_ctx_tname) ?
+			   bpf_prog_ctx_tname[prog_type] : NULL;
 
-	conv_struct = bpf_ctx_convert.t;
-	if (!conv_struct)
+	*alt = NULL;
+	if (!name || strchr(name, '*'))
 		return NULL;
-	/* prog_type is valid bpf program type. No need for bounds check. */
-	ctx_type = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2;
-	/* ctx_type is a pointer to prog_ctx_type in vmlinux.
-	 * Like 'struct __sk_buff'
-	 */
-	return btf_type_by_id(btf_vmlinux, ctx_type->type);
+	if (str_has_prefix(name, "struct "))
+		return name + strlen("struct ");
+	if (!strcmp(name, "bpf_user_pt_regs_t")) {
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct pt_regs))
+			*alt = "pt_regs";
+		else if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_pt_regs))
+			*alt = "user_pt_regs";
+		else if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_regs_struct))
+			*alt = "user_regs_struct";
+	}
+	return name;
 }
 
 static int find_kern_ctx_type_id(enum bpf_prog_type prog_type)
@@ -6578,9 +6604,10 @@ static int find_kern_ctx_type_id(enum bpf_prog_type prog_type)
 	const struct btf_type *conv_struct;
 	const struct btf_member *ctx_type;
 
-	conv_struct = bpf_ctx_convert.t;
-	if (!conv_struct)
+	/* bpf_ctx_convert.t is set when the vmlinux BTF is parsed */
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
 		return -EFAULT;
+	conv_struct = bpf_ctx_convert.t;
 	/* prog_type is valid bpf program type. No need for bounds check. */
 	ctx_type = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2 + 1;
 	/* ctx_type is a pointer to prog_ctx_type in vmlinux.
@@ -6602,8 +6629,7 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			  const struct btf_type *t, enum bpf_prog_type prog_type,
 			  int arg)
 {
-	const struct btf_type *ctx_type;
-	const char *tname, *ctx_tname;
+	const char *tname, *ctx_tname, *alt;
 
 	t = btf_type_by_id(btf, t->type);
 
@@ -6637,21 +6663,9 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		return false;
 	}
 
-	ctx_type = find_canonical_prog_ctx_type(prog_type);
-	if (!ctx_type) {
-		bpf_log(log, "btf_vmlinux is malformed\n");
-		/* should not happen */
-		return false;
-	}
-again:
-	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
-	if (!ctx_tname) {
-		/* should not happen */
-		bpf_log(log, "Please fix kernel include/linux/bpf_types.h\n");
-		return false;
-	}
 	/* program types without named context types work only with arg:ctx tag */
-	if (ctx_tname[0] == '\0')
+	ctx_tname = prog_ctx_tname(prog_type, &alt);
+	if (!ctx_tname)
 		return false;
 	/* only compare that prog's ctx type name is the same as
 	 * kernel expects. No need to compare field by field.
@@ -6660,37 +6674,18 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	 * int socket_filter_bpf_prog(struct __sk_buff *skb)
 	 * { // no fields of skb are ever used }
 	 */
-	if (btf_is_projection_of(ctx_tname, tname))
+	if (btf_is_projection_of(ctx_tname, tname) || !strcmp(ctx_tname, tname))
 		return true;
-	if (strcmp(ctx_tname, tname)) {
-		/* bpf_user_pt_regs_t is a typedef, so resolve it to
-		 * underlying struct and check name again
-		 */
-		if (!btf_type_is_modifier(ctx_type))
-			return false;
-		while (btf_type_is_modifier(ctx_type))
-			ctx_type = btf_type_by_id(btf_vmlinux, ctx_type->type);
-		goto again;
-	}
-	return true;
+	/* bpf_user_pt_regs_t is a typedef, check the underlying struct too */
+	return alt && !strcmp(alt, tname);
 }
 
-/* forward declarations for arch-specific underlying types of
- * bpf_user_pt_regs_t; this avoids the need for arch-specific #ifdef
- * compilation guards below for BPF_PROG_TYPE_PERF_EVENT checks, but still
- * works correctly with __builtin_types_compatible_p() on respective
- * architectures
- */
-struct user_regs_struct;
-struct user_pt_regs;
-
 static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 				      const struct btf_type *t, int arg,
 				      enum bpf_prog_type prog_type,
 				      enum bpf_attach_type attach_type)
 {
-	const struct btf_type *ctx_type;
-	const char *tname, *ctx_tname;
+	const char *tname, *ctx_tname, *alt;
 
 	if (!btf_is_ptr(t)) {
 		bpf_log(log, "arg#%d type isn't a pointer\n", arg);
@@ -6790,27 +6785,20 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		break;
 	}
 
-	ctx_type = find_canonical_prog_ctx_type(prog_type);
-	if (!ctx_type) {
-		/* should not happen */
-		bpf_log(log, "btf_vmlinux is malformed\n");
-		return -EINVAL;
-	}
-
 	/* resolve typedefs and check that underlying structs are matching as well */
-	while (btf_type_is_modifier(ctx_type))
-		ctx_type = btf_type_by_id(btf_vmlinux, ctx_type->type);
+	ctx_tname = prog_ctx_tname(prog_type, &alt);
+	if (ctx_tname && !str_has_prefix(bpf_prog_ctx_tname[prog_type], "struct "))
+		ctx_tname = alt;
 
 	/* if program type doesn't have distinctly named struct type for
 	 * context, then __arg_ctx argument can only be `void *`, which we
 	 * already checked above
 	 */
-	if (!__btf_type_is_struct(ctx_type)) {
+	if (!ctx_tname) {
 		bpf_log(log, "arg#%d should be void pointer\n", arg);
 		return -EINVAL;
 	}
 
-	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
 	if (!__btf_type_is_struct(t) || strcmp(ctx_tname, tname) != 0) {
 		bpf_log(log, "arg#%d should be `struct %s *`\n", arg, ctx_tname);
 		return -EINVAL;
@@ -6837,6 +6825,8 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 	const struct btf_type *kctx_type;
 	u32 kctx_type_id;
 
+	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
+		return -EINVAL;
 	conv_struct = bpf_ctx_convert.t;
 	/* get member for kernel ctx type */
 	kctx_member = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2 + 1;
-- 
2.47.3

