Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452278;
	b=yDPVOTcyzRPUJJFOmkFwkfHFWPVpcc8K2lemvLMiQSU3PSBoIua3opT7BXzqddM1zj+P
	 Vh8Y61g7GyaUikhvDpKUmV8duSzf7RNKkchGbmrgxjPMLioGu33Y76MQQQDv+2Fxx4T5m
	 NNhESjMr+tvysSfUo4bRbKV+AteiyUs0SiAxPxT8VQzyBshmpZkqAQF0mPf4VZjipGK98
	 Tpjow4tRbCGpro/OEKcC6GecL/YijFjYoTKLoh62wFE5uTBsJOjKnl25CA5g9lx9E88Dy
	 0nKbrsyPOzTf/YZa257P1iJpNTsrqtNeLia847wPoX/NYMDQvK7sYM0pFX0RQsU7aeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452278;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=isPmbyXwoawb4v6VwfGam596nKy3bfRm/KBHkrnGamg=;
	b=bl4QRkHwHJ2Ehhr/m0/vmVks+WgKCqAlOiGMNO4oQvhCBPmIye70EyhLDaRb6BXlvl6+
	 p1oS6hDhkNi6aeJT5qXx/Yu3WV1BY33pH1BM8LCAhoBHwQ0HGhBzgdE0Iui3ZYWp0a9Pz
	 YKYnQRXLD+c4a6dJUiCqUtIU8zmQudbMpOZ8AJJBSv7+lXkww5MFv5LBv53S3e/p3Yjon
	 jvxF04UCyTcQx64FoowvqrndUTtGWDvTjVxUd+YbmtZiJ26uGnDCx8bnsFJ9tYeUlz2v8
	 1mfnqe6FKMTQ6aDRqhQ55qGXS1W8m2wDB3WU8dei/L8ylxELeTOO6urCAK5Ua87vp8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Kn+jwqdJ;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D62606A33F;
	Sat, 31 Oct 2026 13:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D62606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Kn+jwqdJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452278; x=1824988278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=isPmbyXwoawb4v6VwfGam596nKy3bfRm/KBHkrnGamg=;
  b=Kn+jwqdJJuUdsWM4LYikOLcK67qNax8yb4U83vj9VOrdNXoTKj/Eg5HW
   aecXBX2yU4zevfSdSXyXwXRoowAmT+0e0VsHjrA9c4pyOcddCU5XEP56v
   ms4wMa2PuydQt4DmsX4kZrBESbMOwn5XxhVbXkqsj46p1wWalMWJlvQYU
   aXgyiDUCjN1SooTVRVByaTGEl9cV8nYzmsVWB5Y6AVTSzEpkXkySoQy+r
   s/4H1FXFZZE/1FfqSm4vu6sXNOtc9tvb5ByAEI6u9uy7l4bQGmQKWk6LA
   0Brp8pey+Zq+khx6YbsGe9VM+Hz0XKPVcnqnUqkEslnrLlx+Ym/zTlaCq
   A==;
X-CSE-ConnectionGUID: JoO1aI4/QE2S3bCQOA6CxQ==
X-CSE-MsgGUID: iZI+jainQguDw7MTkcoiKg==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32778309"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:11:18 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:11982]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id 9a9685ef-35e1-47f0-bc60-0eefd24eaeec; Sat, 31 Oct 2026 13:11:17 +0000 (UTC)
X-Farcaster-Flow-ID: 9a9685ef-35e1-47f0-bc60-0eefd24eaeec
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:11:17 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:11:17 +0000
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
Subject: [PATCH bpf-next 05/13] bpf: let btf_parse_module() adopt the caller's copy of the module BTF
Date: Sat, 31 Oct 2026 13:09:51 +0000
Message-ID: <20261031130959.23472-6-wanjay@amazon.com>
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

btf_parse_module() makes its own kvmemdup() of the module's .BTF
section, and of its .BTF.inline section through btf_parse_split().
Move both copies to the caller, btf_module_notify(), and let the result
take ownership of them: the new struct btf the module BTF copy, and the
returned inline BTF the inline copy, relocated in place.  On failure,
and for an inline BTF that fails validation, the caller frees what was
not taken.

No functional change: /sys/kernel/btf/<module> and <module>.inline keep
serving btf->data and the relocated inline BTF, which are the same
buffers as before.

This prepares for parsing the vmlinux BTF on first use (later in this
series): a module that loads before that keeps its copies unparsed and
exposes them in sysfs right away.  Parsing them later must adopt those
buffers rather than make second copies, so that the sysfs files stay
valid and the data exists only once.

Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 58d8b21d9895..59d6f44cbe17 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6969,8 +6969,9 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
+/* @data is a copy owned by the returned BTF; the caller frees it on error */
 static struct btf *btf_parse_split(struct btf_verifier_env *env,
-				   const char *name, const void *data,
+				   const char *name, void *data,
 				   unsigned int data_size, struct btf *base_btf)
 {
 	struct btf *btf;
@@ -6986,11 +6987,7 @@ static struct btf *btf_parse_split(struct btf_verifier_env *env,
 	btf->named_start_id = 0;
 	strscpy(btf->name, name);
 
-	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-	if (!btf->data) {
-		err = -ENOMEM;
-		goto errout;
-	}
+	btf->data = data;
 	btf->data_size = data_size;
 
 	err = btf_parse_hdr(env);
@@ -7014,6 +7011,7 @@ static struct btf *btf_parse_split(struct btf_verifier_env *env,
 	return btf;
 
 errout:
+	btf->data = NULL;
 	btf_free(btf);
 	return ERR_PTR(err);
 }
@@ -7085,10 +7083,16 @@ static int btf_rebase_inline(struct btf *inline_btf,
 	return 0;
 }
 
-static struct btf *btf_parse_module(const char *module_name, const void *data,
+/*
+ * @data and @inline_data are copies made by the caller.  On success the
+ * returned BTF owns @data, and *@relocated_inline_data is @inline_data,
+ * relocated in place, unless the inline BTF is invalid.  The caller frees
+ * the copies this does not take.
+ */
+static struct btf *btf_parse_module(const char *module_name, void *data,
 				    unsigned int data_size, void *base_data,
 				    unsigned int base_data_size,
-				    const void *inline_data,
+				    void *inline_data,
 				    unsigned int inline_data_size,
 				    void **relocated_inline_data)
 {
@@ -7156,6 +7160,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		if (err) {
 			pr_warn("failed to relocate module [%s] inline BTF: %d\n",
 				module_name, err);
+			inline_btf->data = NULL;
 			btf_free(inline_btf);
 		} else {
 			*relocated_inline_data = inline_btf->data;
@@ -7179,12 +7184,16 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 errout:
 	kvfree(module_str_map);
 	btf_verifier_env_free(env);
-	if (inline_btf)
+	if (inline_btf) {
+		inline_btf->data = NULL;
 		btf_free(inline_btf);
+	}
 	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
 		btf_free(base_btf);
-	if (btf)
+	if (btf) {
+		btf->data = NULL;
 		btf_free(btf);
+	}
 	return ERR_PTR(err);
 }
 
@@ -9445,7 +9454,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	struct module *mod = module;
 	struct bin_attribute *attr;
 	struct btf *btf;
-	void *inline_data = NULL, *relocated_inline_data = NULL;
+	void *data, *inline_data = NULL, *relocated_inline_data = NULL;
 	unsigned int inline_data_size = 0;
 	int err = 0;
 
@@ -9473,11 +9482,23 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			err = -ENOMEM;
 			goto out;
 		}
-		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
+		data = kvmemdup(mod->btf_data, mod->btf_data_size, GFP_KERNEL | __GFP_NOWARN);
+		if (inline_data) {
+			inline_data = kvmemdup(inline_data, inline_data_size,
+					       GFP_KERNEL | __GFP_NOWARN);
+			if (!inline_data)
+				pr_warn("failed to validate module [%s] inline BTF: %d\n",
+					mod->name, -ENOMEM);
+		}
+		btf = !data ? ERR_PTR(-ENOMEM) :
+		      btf_parse_module(mod->name, data, mod->btf_data_size,
 				       mod->btf_base_data, mod->btf_base_data_size,
-				       inline_data, inline_data_size,
+				       inline_data, inline_data ? inline_data_size : 0,
 				       &relocated_inline_data);
+		if (inline_data != relocated_inline_data)
+			kvfree(inline_data);
 		if (IS_ERR(btf)) {
+			kvfree(data);
 			kfree(btf_mod);
 			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
 				pr_warn("failed to validate module [%s] BTF: %ld\n",
-- 
2.47.3

