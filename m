Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452310;
	b=K2stH9peQHlwiB/go0HJQ86lVIOTQ7o4nO3vpg7tHIQ3V0e1TfTKHHdGKq61re+Vn2mr
	 R/v35DLzSLkg6aeYIVCkbmHno7O8YSkCyy09+PLkGd7WDKYv1xgkoE6SJ0hGuXD1zis/7
	 EV5V9MfL+uvu3PVMqIKKmjAYDG4gxBBaVkQ7cBJcGw0OzTptj4GI+PI4UVAXczX0iyiHl
	 KMaL1DsZeyh+irBQPX+cY7I26m0f0y0KeuiRAeroWyVYk1XvbX4OMwHnl8dJagUFFfvr4
	 4TgFn5R7akAWHHVgrsWBV3oIemOJDrqCWfyPh6ULeA2RMoVaeKrPfJLIEzjt8x12CfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452310;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=T5d9R+6HlvftBR3h1agbmZK+L0KpwKiqcm+ppY7RY+8=;
	b=uqdUT4z5UfOgmbBwTKkr1AzJUIj05XY2hl/nQz/IBdTHJVkhbo5FX470In5V06nNwdq+
	 zQ4ayfVV2HsNw/iRDNDj9pIndwAWrdmYoJ7NWHDm18muexqSU/z/aDBm/VGS9WhbCCqJ/
	 f1nMWy5HKKQWZfr0762lKNmy7z7UERVCQZjver0hCOuJnRSTZ7Xvf1kFrcx4Fsdz+tOej
	 yeS57Qtu+uSiLopBnlXM640Arsk8nQHFkGV3FkHXpj/Jq7ftD5zrxIVzdpJeXV027Hqxg
	 H1YP5QVQBMwAkjTyGNILqgVKcwZ/tbJ2kibiM+poBh1vfGePplVZD4I2xw8LMes//LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=f3tgGMNE;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89345606A31F;
	Sat, 31 Oct 2026 13:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89345606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=f3tgGMNE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452309; x=1824988309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T5d9R+6HlvftBR3h1agbmZK+L0KpwKiqcm+ppY7RY+8=;
  b=f3tgGMNE3Y5OZPl75D1IDFWpDGnZJLiU08MeWcW17eRx8U0yNwR8lr0e
   ke18uwkwYVBsUsCnwkUQkEXRrhLjxT9ZsWDB++T4DbpPFyJaw6tsoCmg3
   AUCu948G0k5JeXwnnbW0XK0zgp4miZkd67L14hX/ya8tdUM6xle106rp9
   yqboyFIJ7IvdBXPz/DHv82jTKmaZ/05Mw/mpEaIOfZ54q7m178TSz1leS
   kGu3OW2M4FCICqbtKdHXlhg6Bl/e89ChpLycxhoI5E3TIY8N7MsRCrGMt
   ttQKawQq+x9is7C0fnkKqQ+tsvUY06uB8rzTiBhPtn8PKeoKJ6qYGZj+L
   w==;
X-CSE-ConnectionGUID: p7wBQQ2bS+GEELxXt/9FXA==
X-CSE-MsgGUID: xce1HW/IQ/i8y2sepeYcOQ==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32741687"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:11:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:11682]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id 98ee0317-f31f-4b8e-a0e0-db089435a4a6; Sat, 31 Oct 2026 13:11:48 +0000 (UTC)
X-Farcaster-Flow-ID: 98ee0317-f31f-4b8e-a0e0-db089435a4a6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:11:48 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:11:48 +0000
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
Subject: [PATCH bpf-next 07/13] bpf: parse the vmlinux BTF before taking cand_cache_mutex
Date: Sat, 31 Oct 2026 13:09:53 +0000
Message-ID: <20261031130959.23472-8-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf_core_find_cands() calls bpf_get_btf_vmlinux() with cand_cache_mutex
held, from btf_get_ptr_to_btf_id() and bpf_core_apply().  Once the
vmlinux BTF is parsed on first use (later in this series), parsing also
parses the module BTFs kept until then, under btf_module_mutex, while a
module going away takes btf_module_mutex and then cand_cache_mutex
(purge_cand_cache()).  That would be an ABBA deadlock:

  cand_cache_mutex -> btf_vmlinux_lock -> btf_module_mutex
  btf_module_mutex -> cand_cache_mutex

Have both callers fetch the BTF before they take cand_cache_mutex, and
make bpf_core_find_cands() only peek with bpf_peek_btf_vmlinux().  The
ordering was found by design review.  With the whole series applied
and the fetch moved back under the mutex, PROVE_LOCKING reports this
cycle at the first rmmod of a BTF module after a kernel CO-RE load
parsed the BTF; with this patch the same sequence is clean.

No functional change: the BTF is parsed at the same points, just
before the mutex is taken; a broken BTF fails the load with the error
of its parse, and bpf_core_find_cands() handles a missing BTF as before.

TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
[pass the error of the fetch on instead of -EINVAL from the peek]
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 59d6f44cbe17..70adc52f5d7c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8596,6 +8596,7 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
 		.btf = btf,
 		.log = log,
 	};
+	struct btf *vmlinux_btf;
 	u32 kern_type_id, type_id;
 	int err = 0;
 
@@ -8607,6 +8608,10 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
 		t = btf_type_by_id(btf, t->type);
 	}
 
+	/* parse it, if this is its first use, before taking cand_cache_mutex */
+	vmlinux_btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(vmlinux_btf))
+		return PTR_ERR(vmlinux_btf);
 	mutex_lock(&cand_cache_mutex);
 	cc = bpf_core_find_cands(&ctx, type_id);
 	if (IS_ERR(cc)) {
@@ -10610,7 +10615,8 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 	const char *name;
 	int id;
 
-	main_btf = bpf_get_btf_vmlinux();
+	/* callers parse it before taking cand_cache_mutex, see bpf_core_apply() */
+	main_btf = bpf_peek_btf_vmlinux();
 	if (IS_ERR(main_btf))
 		return ERR_CAST(main_btf);
 	if (!main_btf)
@@ -10713,8 +10719,18 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
+		struct btf *main_btf;
 		int i;
 
+		/*
+		 * Parsing the vmlinux BTF takes btf_module_mutex, which is
+		 * taken before cand_cache_mutex when a module goes away.
+		 */
+		main_btf = bpf_get_btf_vmlinux();
+		if (IS_ERR(main_btf)) {
+			kfree(specs);
+			return PTR_ERR(main_btf);
+		}
 		mutex_lock(&cand_cache_mutex);
 		cc = bpf_core_find_cands(ctx, relo->type_id);
 		if (IS_ERR(cc)) {
-- 
2.47.3

