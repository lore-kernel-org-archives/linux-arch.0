Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E973CBE7A
	for <linux-arch@vger.kernel.org>; Fri,  3 Apr 2026 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236176; cv=none; b=f02AhQ5VxQk6n7XXy4dgUUL6pgoeWOiGNjIC63Yj8k8z4P9DHRPz+fr9ET9xU/2IIa+SNSNYGw2FSRQKzhFjSFCzn+j5AWdQEsEJeySn72NRzDMGeZlJRJC7pUSwbfa5k1FUqwL9QTR0YgLNhFYZWfUR2cG3BEPeGaWS5WQD6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236176; c=relaxed/simple;
	bh=Lga53tOyWFUFw4YhT3N80GQCFhiyz4oS/A2d/gapydY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tgqj0B1wv6VeZnHrRCtxwYe0rs4inTeE0PaETs7MfwdSs09nSbRMK9LOhx2iBN4xJXBoqQZPLW7LzqlVtoHH7Mf6gz98c64MClv1GLDdHaYhQP+LAVn0D7hERkryit0ENZgjykUum5p+Cs2dJRKljzc1VKyluabFu1xWIRXRwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk1iodx4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk1iodx4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82cf96ca071so894864b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 03 Apr 2026 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775236174; x=1775840974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn6ir+iu8Ky2X/Dj3l/FSV5ByUGa4ggdFPo+/I8j8J4=;
        b=kk1iodx4+aBGpnWvHOVx1mPOxbU3UfRgx3u2R49of34EY6C11CjU2vbhHTUbUKGFqm
         THWR1RVln9zuFF34CTJiKEbx5uivrnuiLqh2gBhbkFB+cAwg8heoLZOQuqcYtcqZkjCf
         u81Q1Z1tkO2zAGSvuoFCD+UJ8TOYyB34ayFCmoqfcApbT0amsGxhZ1KZpER233ALb20Y
         w290P3tDXC4BQjnsPCgXlRA+wukaIg/CfX5izfUdYAffifxKS7s0ao4lWDHiBa3iT+9G
         BGu8LJTLaq/7fGGcn1JmYQS2uuqpgeYbO2cZHLcDCNRyGQAFZoxpRwZNJHE0CvAjYeYI
         TU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236174; x=1775840974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sn6ir+iu8Ky2X/Dj3l/FSV5ByUGa4ggdFPo+/I8j8J4=;
        b=ZYblOGk3KlmbWdREUZySpdC2714iPcNtod93BVXyFRzP2Tt0IWd57705fwCkGucUyr
         lGY+4/KT5HKZhOxytg0ba5mUK3/b3RQNtUyyHdymRtw5yQ0jT5GAwFQWZZPLCdmn7paS
         7LejuvynlHsdIJxScbHQztxKnCyyJH6YolTdjjXP15Uk1lRaFGlFWr828bvY1eT/laJs
         D4Kw2kDGUVyRWoAt2wM6EVsh+YNqE5wO1AaT1DGURi7xqs3TKOlrTzfBdJENC2fhDJDW
         iliNQgkcdjhsOP4sCZJtRbRxYUc3vebOfRsXp7SY/Fl6r5eRoQi0tUluoT8bN7U8ha9p
         MtNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBzlB2ZShNwrtZLXZskUXkDR8BIc5yXN0gYrcDHtLP+evpw29jwm+9letW9i2rUkg+oq/uNH8VhYP6@vger.kernel.org
X-Gm-Message-State: AOJu0YzcV2KrOB4soy+/QufVsRF9CXK0voah3G3s7ciqDpX1wOg902JG
	J85sQ1pVQiBUppWnOtxcA6qZCKPfmOdF2toMw8xTxiKJETpINvFF9n9uTwxWs7ss
X-Gm-Gg: AeBDiesss0yd57yYygp0iaJKaaasM5kV/4IQSFy3KG+VnoPKfBPHxCfshmFmm6cFip6
	mQ11vgcgrsjASL3bXo9N/0KM5o8pKTV6mQNjLoOQyRtw8YagEqw9GzWIDV8nE4T9MqqNmutwvss
	sOn5PwmLlJuJ+TA+rsfmZPWPxOtfAFYdm4WLeX7Q6hWhDLZwibjG/f1GkDe34mq++oib+hqrtGU
	faLqcrtFwrzqBQnvvJqipculXwyhxQ8x9MBWGa+9GCjRLD2L85jsNQIBLQxmuCavqyaSFuRQ9yR
	Kg3GQScqEylZpdTLbazIhTYG//2vEOWUJJ2hfs7O1Ii9RHxivn87fJU81PU/oYdB3/3t7WDrNX9
	iSUhUjsFeqmDxA+HyWgf+kwgSE10+06RpM/u+BFSqvHAnq6q/RwOTm2uAqJbfz1PftEhz4k7hIW
	mO4sRdYIBYAgR68bkQCloUHWUkcaeYBdCsaWg7JFYBFEshYk5tWMxVireDKgr75hmp
X-Received: by 2002:a05:6a00:2393:b0:82c:dd31:b83d with SMTP id d2e1a72fcca58-82d0dba0775mr3675206b3a.38.1775236174310;
        Fri, 03 Apr 2026 10:09:34 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3c930sm6588725b3a.17.2026.04.03.10.09.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 10:09:33 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: arnd@arndb.de,
	ast@kernel.org,
	ihor.solodrai@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	pengdonglin@xiaomi.com
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH bpf-next 3/3] bpf: classify rbtree kfuncs with BPF_VERIF_KFUNC_DEF sets
Date: Sat,  4 Apr 2026 01:08:57 +0800
Message-ID: <20260403170900.58659-4-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403170900.58659-1-pilgrimtao@gmail.com>
References: <20260403170900.58659-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Remove verifier logic that enumerated special_kfunc_list[KF_bpf_rbtree_*]
and compared against it. Use BPF_VERIF_KFUNC_DEF so each kfunc's
verifier-facing safety classification is declared in one place next
to the implementation.

When adding new kfuncs later, you no longer need to thread ad-hoc
allowlists through scattered verifier branches—tagging the kfunc once
with BPF_VERIF_KFUNC_DEF is enough.

This patch only migrates the rbtree kfuncs; other kfunc families can
be converted the same way in follow-up work.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/asm-generic/btf_ids.lds.h |  5 +++-
 kernel/bpf/helpers.c              |  7 +++++
 kernel/bpf/verifier.c             | 44 +++++++++++--------------------
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/btf_ids.lds.h b/include/asm-generic/btf_ids.lds.h
index 7579ba58f5ff..879391725d97 100644
--- a/include/asm-generic/btf_ids.lds.h
+++ b/include/asm-generic/btf_ids.lds.h
@@ -16,7 +16,10 @@
 		KEEP(*(.BTF_ids.##sfx))						\
 		__BTF_ids_seg_end_##sfx = .;
 
-#define BTF_IDS_VERIFIER_SUBSEGS
+#define BTF_IDS_VERIFIER_SUBSEGS						\
+	BTF_IDS_SUBSEG(bpf_verif_kfunc_rbtree_add)				\
+	BTF_IDS_SUBSEG(bpf_verif_kfunc_rbtree_graph_node)			\
+	BTF_IDS_SUBSEG(bpf_verif_kfunc_rbtree_api)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2d8538bf4cfa..d4a8b0b98210 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2606,6 +2606,7 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 	WRITE_ONCE(node_internal->owner, NULL);
 	return (struct bpf_rb_node *)n;
 }
+BPF_VERIF_KFUNC_DEF(bpf_rbtree_remove, rbtree_api, rbtree_graph_node)
 
 /* Need to copy rbtree_add_cached's logic here because our 'less' is a BPF
  * program
@@ -2667,6 +2668,7 @@ __bpf_kfunc int bpf_rbtree_add(struct bpf_rb_root *root,
 
 	return __bpf_rbtree_add(root, n, (void *)less, meta ? meta->record : NULL, off);
 }
+BPF_VERIF_KFUNC_DEF(bpf_rbtree_add, rbtree_api, rbtree_add, rbtree_graph_node)
 
 __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
 				    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
@@ -2674,6 +2676,7 @@ __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node
 {
 	return bpf_rbtree_add(root, node, less, meta__ign, off);
 }
+BPF_VERIF_KFUNC_DEF(bpf_rbtree_add_impl, rbtree_api, rbtree_add, rbtree_graph_node)
 
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
 {
@@ -2681,6 +2684,7 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
 
 	return (struct bpf_rb_node *)rb_first_cached(r);
 }
+BPF_VERIF_KFUNC_DEF(bpf_rbtree_first, rbtree_api)
 
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_root(struct bpf_rb_root *root)
 {
@@ -2688,6 +2692,7 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_root(struct bpf_rb_root *root)
 
 	return (struct bpf_rb_node *)r->rb_root.rb_node;
 }
+BPF_VERIF_KFUNC_DEF(bpf_rbtree_root, rbtree_api)
 
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_left(struct bpf_rb_root *root, struct bpf_rb_node *node)
 {
@@ -2698,6 +2703,7 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_left(struct bpf_rb_root *root, struct
 
 	return (struct bpf_rb_node *)node_internal->rb_node.rb_left;
 }
+BPF_VERIF_KFUNC_DEF(bpf_rbtree_left, rbtree_api, rbtree_graph_node)
 
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root, struct bpf_rb_node *node)
 {
@@ -2708,6 +2714,7 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root, struc
 
 	return (struct bpf_rb_node *)node_internal->rb_node.rb_right;
 }
+BPF_VERIF_KFUNC_DEF(bpf_rbtree_right, rbtree_api, rbtree_graph_node)
 
 /**
  * bpf_task_acquire - Acquire a reference to a task. A task acquired by this
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..db9ba47903ef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12714,6 +12714,10 @@ BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
 
+BTF_SET_SUB(bpf_verif_kfunc_rbtree_add)
+BTF_SET_SUB(bpf_verif_kfunc_rbtree_graph_node)
+BTF_SET_SUB(bpf_verif_kfunc_rbtree_api)
+
 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
 	return func_id == special_kfunc_list[KF_bpf_obj_new] ||
@@ -12752,12 +12756,6 @@ static bool is_bpf_list_push_kfunc(u32 func_id)
 	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl];
 }
 
-static bool is_bpf_rbtree_add_kfunc(u32 func_id)
-{
-	return func_id == special_kfunc_list[KF_bpf_rbtree_add] ||
-	       func_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
-}
-
 static bool is_task_work_add_kfunc(u32 func_id)
 {
 	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
@@ -13162,16 +13160,6 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_back];
 }
 
-static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
-{
-	return is_bpf_rbtree_add_kfunc(btf_id) ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_first] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_root] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_right];
-}
-
 static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_iter_num_new] ||
@@ -13182,7 +13170,7 @@ static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
 static bool is_bpf_graph_api_kfunc(u32 btf_id)
 {
 	return is_bpf_list_api_kfunc(btf_id) ||
-	       is_bpf_rbtree_api_kfunc(btf_id) ||
+	       btf_id_set_contains(&bpf_verif_kfunc_rbtree_api, btf_id) ||
 	       is_bpf_refcount_acquire_kfunc(btf_id);
 }
 
@@ -13216,7 +13204,7 @@ static bool kfunc_spin_allowed(u32 btf_id)
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
 {
-	return is_bpf_rbtree_add_kfunc(btf_id);
+	return btf_id_set_contains(&bpf_verif_kfunc_rbtree_add, btf_id);
 }
 
 static bool is_async_callback_calling_kfunc(u32 btf_id)
@@ -13244,7 +13232,7 @@ static bool is_callback_calling_kfunc(u32 btf_id)
 
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
 {
-	return is_bpf_rbtree_api_kfunc(btf_id);
+	return btf_id_set_contains(&bpf_verif_kfunc_rbtree_api, btf_id);
 }
 
 static bool check_kfunc_is_graph_root_api(struct bpf_verifier_env *env,
@@ -13258,7 +13246,7 @@ static bool check_kfunc_is_graph_root_api(struct bpf_verifier_env *env,
 		ret = is_bpf_list_api_kfunc(kfunc_btf_id);
 		break;
 	case BPF_RB_ROOT:
-		ret = is_bpf_rbtree_api_kfunc(kfunc_btf_id);
+		ret = btf_id_set_contains(&bpf_verif_kfunc_rbtree_api, kfunc_btf_id);
 		break;
 	default:
 		verbose(env, "verifier internal error: unexpected graph root argument type %s\n",
@@ -13283,10 +13271,7 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 		ret = is_bpf_list_push_kfunc(kfunc_btf_id);
 		break;
 	case BPF_RB_NODE:
-		ret = (is_bpf_rbtree_add_kfunc(kfunc_btf_id) ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_right]);
+		ret = btf_id_set_contains(&bpf_verif_kfunc_rbtree_graph_node, kfunc_btf_id);
 		break;
 	default:
 		verbose(env, "verifier internal error: unexpected graph node argument type %s\n",
@@ -13823,7 +13808,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_NODE:
-			if (is_bpf_rbtree_add_kfunc(meta->func_id)) {
+			if (btf_id_set_contains(&bpf_verif_kfunc_rbtree_add, meta->func_id)) {
 				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 					verbose(env, "arg#%d expected pointer to allocated object\n", i);
 					return -EINVAL;
@@ -14305,7 +14290,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
-	if (is_bpf_rbtree_add_kfunc(meta.func_id)) {
+	if (btf_id_set_contains(&bpf_verif_kfunc_rbtree_add, meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_rbtree_add_callback_state);
 		if (err) {
@@ -14409,7 +14394,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
-	if (is_bpf_list_push_kfunc(meta.func_id) || is_bpf_rbtree_add_kfunc(meta.func_id)) {
+	if (is_bpf_list_push_kfunc(meta.func_id) ||
+	    btf_id_set_contains(&bpf_verif_kfunc_rbtree_add, meta.func_id)) {
 		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
 		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
 		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
@@ -23438,13 +23424,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[2] = *insn;
 		*cnt = 3;
 	} else if (is_bpf_list_push_kfunc(desc->func_id) ||
-		   is_bpf_rbtree_add_kfunc(desc->func_id)) {
+		   btf_id_set_contains(&bpf_verif_kfunc_rbtree_add, desc->func_id)) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 		int struct_meta_reg = BPF_REG_3;
 		int node_offset_reg = BPF_REG_4;
 
 		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
-		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
+		if (btf_id_set_contains(&bpf_verif_kfunc_rbtree_add, desc->func_id)) {
 			struct_meta_reg = BPF_REG_4;
 			node_offset_reg = BPF_REG_5;
 		}
-- 
2.43.0

