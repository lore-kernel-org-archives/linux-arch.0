Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452263;
	b=nRaCVHsvrn1VPvecilZBARafecqaq6mql53ZCGujiIJeDoxK6bruEo4SvAb6vUaJiMQd
	 ls3KYK9A6OqyQNdi58jlDlPX/8Mnj1QrMcBBTIRAXRVb+mLIc9mYJ3gb6xZ3jn5TzGpym
	 lvl84MfmzMr6aOgdU5RUNAkXXHSA74F7ADL3THN5dIQirN0rPfki7fp96oezTjkovCYGs
	 LK+NsFWC//G9x7UrH97TqdyBUo26Gi5x6tJLgzEDB5V9IrxijiM2HXqIN0PlYuTxA1dQI
	 hwpH08VpDkJo5uu+rX5IlHvVJ3xIrN4WAFGl4+wSlWGlMpPfdMyxcsQsRZHb3aRETaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=TSG3UEWStZsl3t6w/1Pd7SeIDIuZBVm4mXUvmX9zB68=;
	b=j3SBNgnuRRoOKK3zVeNkPmLtSuu9LHb0qsEpX1GzVTfItPkiDXt6O/1ekhhCHTsMz79I
	 vZ0hfQrZ3MfGOuNYggnBq/TMXwVvs+2W/Xyh8+75X5S0YIwJegjRkqoB7Th/TU0F84pHm
	 nKOXr+58tSsuh+n+9ZubIzmWZOd0Dcb4bOcJuws51ERzChzCXcgtIgRzRiap33SJ/TT/M
	 s4+jNUbYnud3jf7C+svOp+jM1FwNK/8KvAj6XBETRh4rhd8as95aOooJ/Mx4H0n43Uskd
	 oy1rL0eLxyFNOXiiX+zd7+k7UAKOMjU+E9Lt+1WTWYZObAu9X7wQe5IcKkDWPRTOJbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=YHRAzNPA;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D92606A332;
	Sat, 31 Oct 2026 13:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67D92606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=YHRAzNPA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452263; x=1824988263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSG3UEWStZsl3t6w/1Pd7SeIDIuZBVm4mXUvmX9zB68=;
  b=YHRAzNPAtoLzvjwtYzsqJUhBk+9b6sc3PCo683X/bldTUDPr3YiQNdSH
   caAKTZ+4nzNgFnEhtnm1mpt8NMCLZ/ppx6/QjWHUd4YN25hSzCe0vYumI
   7e6Ddv7e6zIAcmVIoaMWy9S+MBbuSInVS1YPQmeCbWLee04NplumExFSD
   NVnnUviQmhdfDdSfl+YwbDw7lq9RfSwfvQqz0VwXtFYCQCfBjPj0vK0Do
   c3DEWyC5zIdu1kzDZBxoAiOQ2viOd1I4S0BnCwIy8h+Xpe6LjoFFlYfj1
   GP5RGOLNzvyNRsB4OKp3kB741v39cYJAPfCBycraLiwFVV908Bs+La99b
   Q==;
X-CSE-ConnectionGUID: bOaNntcWTuC8GrKWCDQxYg==
X-CSE-MsgGUID: H5bpHZyfR+C2Jir+s8HO9w==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32663925"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:11:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:23693]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.149:2525] with esmtp (Farcaster)
 id f3a9d45e-c1cb-4263-9ffd-c13798688f74; Sat, 31 Oct 2026 13:11:02 +0000 (UTC)
X-Farcaster-Flow-ID: f3a9d45e-c1cb-4263-9ffd-c13798688f74
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:11:01 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:11:01 +0000
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
Subject: [PATCH bpf-next 04/13] bpf: move bpf_get_btf_vmlinux() to btf.c
Date: Sat, 31 Oct 2026 13:09:50 +0000
Message-ID: <20261031130959.23472-5-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Ihor Solodrai <ihor.solodrai@linux.dev>

Move bpf_get_btf_vmlinux(), bpf_peek_btf_vmlinux() and btf_vmlinux_lock
from verifier.c to btf.c, next to btf_parse_vmlinux().

Parsing the vmlinux BTF on first use (later in this series) makes the
accessor apply deferred kfunc, dtor kfunc and struct_ops registrations
and kept module BTF under btf_vmlinux_lock.  That state lives in btf.c;
with the accessor and its lock there, it can stay static.

No functional change.

TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c      | 32 ++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 31 -------------------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1c7536a22a63..58d8b21d9895 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6924,6 +6924,38 @@ struct btf *btf_parse_vmlinux(void)
 	return btf;
 }
 
+static DEFINE_MUTEX(btf_vmlinux_lock);
+
+struct btf *bpf_get_btf_vmlinux(void)
+{
+	/* Pairs with the smp_store_release() on the parse path below. */
+	struct btf *btf = smp_load_acquire(&btf_vmlinux);
+
+	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+		mutex_lock(&btf_vmlinux_lock);
+		btf = btf_vmlinux;
+		if (!btf) {
+			btf = btf_parse_vmlinux();
+			/*
+			 * Order the parsed BTF contents and the globals the
+			 * parse populated (e.g. bpf_ctx_convert.t) before
+			 * the pointer publication. Pairs with the acquire
+			 * on the lockless fast path above.
+			 */
+			smp_store_release(&btf_vmlinux, btf);
+		}
+		mutex_unlock(&btf_vmlinux_lock);
+	}
+	return btf;
+}
+
+/* The vmlinux BTF if it is parsed already: for callers that cannot sleep */
+struct btf *bpf_peek_btf_vmlinux(void)
+{
+	/* Pairs with the smp_store_release() in bpf_get_btf_vmlinux() */
+	return smp_load_acquire(&btf_vmlinux);
+}
+
 /* If .BTF_ids section was created with distilled base BTF, both base and
  * split BTF ids will need to be mapped to actual base/split ids for
  * BTF now that it has been relocated.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b901e3cb3c2..e1514a0c2289 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -317,7 +317,6 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
 }
 
 static DEFINE_MUTEX(bpf_verifier_lock);
-static DEFINE_MUTEX(btf_vmlinux_lock);
 static DEFINE_MUTEX(bpf_percpu_ma_lock);
 
 __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
@@ -23144,36 +23143,6 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 	return 0;
 }
 
-struct btf *bpf_get_btf_vmlinux(void)
-{
-	/* Pairs with the smp_store_release() on the parse path below. */
-	struct btf *btf = smp_load_acquire(&btf_vmlinux);
-
-	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-		mutex_lock(&btf_vmlinux_lock);
-		btf = btf_vmlinux;
-		if (!btf) {
-			btf = btf_parse_vmlinux();
-			/*
-			 * Order the parsed BTF contents and the globals the
-			 * parse populated (e.g. bpf_ctx_convert.t) before
-			 * the pointer publication. Pairs with the acquire
-			 * on the lockless fast path above.
-			 */
-			smp_store_release(&btf_vmlinux, btf);
-		}
-		mutex_unlock(&btf_vmlinux_lock);
-	}
-	return btf;
-}
-
-/* The vmlinux BTF if it is parsed already: for callers that cannot sleep */
-struct btf *bpf_peek_btf_vmlinux(void)
-{
-	/* Pairs with the smp_store_release() in bpf_get_btf_vmlinux() */
-	return smp_load_acquire(&btf_vmlinux);
-}
-
 /*
  * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
  * this case expect that every file descriptor in the array is either a map or
-- 
2.47.3

