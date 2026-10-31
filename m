Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452387;
	b=kfirV7aD6ZCMQ2yB6UAYsRT2/XyeozHILZHhZ8hDkWqP+IKaZDbM1cSw0SmV4/V9rPEx
	 QDccG6N9NbnKJyHTAXIvG0YMbAm8OqLBnqp11Okv37z6Ff/ur2cZewuQ9hKSA6f42TBcu
	 J1GmVDfwp9UBmaf5BWYvPmVxsTNuVaB82EXbAjVm+pZOFvhR9oXwZn1hxHINlEXtU15Zx
	 MwuyMlelk7Cr4OXOInFgTZciqEdoaGITTNu/byCaHhPw9pAMzS30A7h9IVZTOkGStElRl
	 sNl7SOsS8gDEoqcKmbjeyaqcT7lEd7DvmIpdHhdAJjSySAkyfU1ir+rgAs0Rq8kjkog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452387;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=gR47LjHRNXjpTkcLRzKewt/2cYfuBulgIbQmbna6dbM=;
	b=emeeaydhw2f3jc2AQLXhLb/X3ePvzEAaTa2NgopG44ko1/sueP8o3aLG3CuHceR9TsMa
	 XjdmRoC+ewAr8uNYLfxgpOMVMBysNzE9AN2iRoTvNw2kRDslegwUdRQ7SuIzS5AbfMNui
	 zb5hBKhV4YImm4OLKtXffCbOTV7SYfRkYx9aVv7U9pkGgESedf1vNrWogYEU/iTbLIWHQ
	 59Q3qX2rKi95WnTw7P+KZ36DucNu2/lqhqkOI6k4eOsOkkPw/a2nPmii1qF4asqVoCrkz
	 fTtF3hmIjM1cUfly0pAUpzJL/cANraUaXuI9zmG7bPIEXNdlslc2FXoWoWY51jab9pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Vnnzn9gV;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF4606A31C;
	Sat, 31 Oct 2026 13:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AF4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Vnnzn9gV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452387; x=1824988387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gR47LjHRNXjpTkcLRzKewt/2cYfuBulgIbQmbna6dbM=;
  b=Vnnzn9gVZsFXAHUS7OKE71xtM6cJ8qMTXzFqs4QISdkXproNFTI8g+GV
   Q62BtTpdeqoKKJhA2+il36mpSHau6uXAhiZ+FiBIOOSVBZGjx14fnCz8R
   NYNz+A9drzj/YfBb934SCc6CRt/5UBvkdAH/Z9HHp7/nVaToIbjJ+qVl/
   EhpI7Jq8zoqrpULy/Zh1YD/SjnOoHXi44lvGbUhSfF+o62/zB5gDlSsJ/
   urYqqs7FN2ER+ugQkAsEi/PZRd/A8q/wQUNb66YXpgJSWpzCuCr7wFSnG
   1lFd8+DwwxngkQMbu4VJH/HktIzbo+MkTBbEFKInqdl7SZjUbPZKsoQFw
   g==;
X-CSE-ConnectionGUID: SRNIoNc9Ts2CXwiHQRUvRA==
X-CSE-MsgGUID: ssAOiEjTQXyZ0uUD/8UfvA==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32259194"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:13:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:14854]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.21:2525] with esmtp (Farcaster)
 id 7cb6ff12-173c-40d0-a749-dfbe5bd7c79f; Sat, 31 Oct 2026 13:13:06 +0000 (UTC)
X-Farcaster-Flow-ID: 7cb6ff12-173c-40d0-a749-dfbe5bd7c79f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:13:06 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:13:05 +0000
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
Subject: [PATCH bpf-next 12/13] selftests/bpf: keep ksyms and linked_vars working without __start_BTF
Date: Sat, 31 Oct 2026 13:09:58 +0000
Message-ID: <20261031130959.23472-13-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

test_ksyms.c reads __start_BTF and __stop_BTF as typeless ksyms and
compares their distance with the size of /sys/kernel/btf/vmlinux, and
linked_vars2.c uses __start_BTF as its strong typeless ksym.  With
CONFIG_DEBUG_INFO_BTF_LAZY the image carries the vmlinux BTF only
compressed and these symbols do not exist, so libbpf cannot resolve the
externs and both tests fail to load their skeletons.

Make __start_BTF and __stop_BTF weak in test_ksyms.c and expect a size
of 0 when /proc/kallsyms has no __start_BTF, so the rest of the test
still runs, and let linked_vars2.c reference bpf_map_fops instead, which
every kernel that runs BPF has.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 tools/testing/selftests/bpf/prog_tests/ksyms.c   | 8 +++++++-
 tools/testing/selftests/bpf/progs/linked_vars2.c | 4 ++--
 tools/testing/selftests/bpf/progs/test_ksyms.c   | 5 +++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
index dc7aab532fb1..fa97cc0ee3bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -10,7 +10,7 @@ void test_ksyms(void)
 	const char *btf_path = "/sys/kernel/btf/vmlinux";
 	struct test_ksyms *skel;
 	struct test_ksyms__data *data;
-	__u64 link_fops_addr, per_cpu_start_addr;
+	__u64 link_fops_addr, per_cpu_start_addr, btf_start_addr;
 	struct stat st;
 	__u64 btf_size;
 	int err;
@@ -30,6 +30,12 @@ void test_ksyms(void)
 	if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
 		return;
 	btf_size = st.st_size;
+	/*
+	 * With CONFIG_DEBUG_INFO_BTF_LAZY the image has the vmlinux BTF only
+	 * compressed and no __start_BTF/__stop_BTF: the weak ksyms are 0.
+	 */
+	if (kallsyms_find("__start_BTF", &btf_start_addr) == -ENOENT)
+		btf_size = 0;
 
 	skel = test_ksyms__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_ksyms__open_and_load"))
diff --git a/tools/testing/selftests/bpf/progs/linked_vars2.c b/tools/testing/selftests/bpf/progs/linked_vars2.c
index e4f5bd388a3c..bbdc3b25b483 100644
--- a/tools/testing/selftests/bpf/progs/linked_vars2.c
+++ b/tools/testing/selftests/bpf/progs/linked_vars2.c
@@ -8,7 +8,7 @@
 extern int LINUX_KERNEL_VERSION __kconfig;
 /* when an extern is defined as both strong and weak, resulting symbol will be strong */
 extern bool CONFIG_BPF_SYSCALL __kconfig;
-extern const void __start_BTF __ksym;
+extern const void bpf_map_fops __ksym;
 
 int input_bss2;
 int input_data2 = 2;
@@ -47,7 +47,7 @@ int BPF_PROG(handler2)
 	 */
 	output_sink2 = LINUX_KERNEL_VERSION
 		       + CONFIG_BPF_SYSCALL
-		       + (long)&__start_BTF;
+		       + (long)&bpf_map_fops;
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/testing/selftests/bpf/progs/test_ksyms.c
index 6c9cbb5a3bdf..042943088225 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
@@ -11,8 +11,9 @@ __u64 out__btf_size = -1;
 __u64 out__per_cpu_start = -1;
 
 extern const void bpf_link_fops __ksym;
-extern const void __start_BTF __ksym;
-extern const void __stop_BTF __ksym;
+/* weak: CONFIG_DEBUG_INFO_BTF_LAZY keeps no uncompressed BTF in the image */
+extern const void __start_BTF __ksym __weak;
+extern const void __stop_BTF __ksym __weak;
 extern const void __per_cpu_start __ksym;
 /* non-existing symbol, weak, default to zero */
 extern const void bpf_link_fops1 __ksym __weak;
-- 
2.47.3

