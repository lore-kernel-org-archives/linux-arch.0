Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452247;
	b=3l153MKyKf500hscNDxEdezO915ubb/Qj2jzCvzUvMPZrdj9rv/q5IJoBbJ++HDzvPw9
	 fekogxlqvRY395xiEAbstWc5jYx1Alh136+ER2Ec+WgCHLe9C1mDl900ygCeble4sG5/H
	 H04KibX63YVFWja6X4+q6F3F+qDtVWr71Q3UU5BUAD+4w+dhhZ8WzzJ/oARY/AyR4ZLau
	 KuOoN/xDUZpzS6jJ6NYuBI0aQNoAsWVp9YMmiVzrLhYIZXapRwAoMdl/zH7FVj2i2czZy
	 A+DZ2YdhhdNteQD/zGlZh7Nmmh3gwOG0wNcweRKo0B62IOTDBm0SlAV3qntvdNgA7Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452247;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=fhAM8cYGJE2V14POrJMUn3AukLq/v77imXH2i2++hwI=;
	b=LTemEfaPRTTfYqDLk83egOy9cp881sOQSZNJIgzUueuuXfBGuWREBCG+kDMhGrpkC6vR
	 aXsFEOO5OdOsHQoe5w2TxbL2B7oKb2LL+Lct2O4O1WEJZkd+3luM4z94cH7jD3WenvWL/
	 jCBdxoY2DlZmhQ5qHr7+711u5ZlRBiztts4a0ChTdBF5o/YOxkxBKkh+qW1TnQLWhCl8P
	 j0MKQo2zNSkv+9mY42JaDSbM1z5tECoElylSngv+32E7tRv29unvPOF1tsn1LnCBr6fzP
	 7g3TfKHAB96P1Y/k2QHbmjr1l9YZ/BQ+sVEthVtXSiXtfu3W1UB8eb9fGYe8XmWtzkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=AWlnt3XN;
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695EC606A31A;
	Sat, 31 Oct 2026 13:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 695EC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=AWlnt3XN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452247; x=1824988247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fhAM8cYGJE2V14POrJMUn3AukLq/v77imXH2i2++hwI=;
  b=AWlnt3XNCa4PCupQL0dYgVE67uQ5e/C1t7eu2giJ/RBu7+hc2OiGqc4Z
   JchbAmc/w9sX+t/csFeWHokQEYxqqvTRyUJyS7CAFLeFAQ04AaNiKtFG4
   d7YdcWBOyGQrxYjdm+cmZbivsqoaa3F8M/W9laMMi6dAvcQmVDP1mgP2G
   p2LcVMIswh8Z6IB/f8MlKJ1For80VaL9RBwAi7uimcf1Ud9154KPgs4QO
   HP0TsvUoR5O0X6yG72tduiommX0+X0/a/ayAeCQE39FYLgNnlf6EvxrX9
   uOG1RLjeTZOyVlq8qy7H+1fDOs7HQ42FYe2wTuo5p3ACXMLUYKFaB399F
   A==;
X-CSE-ConnectionGUID: +milFdOqQ5WQgKa6OwUx8g==
X-CSE-MsgGUID: AzwlQXkYRA+yTRivcPOhHA==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32753300"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:10:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:11624]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.23:2525] with esmtp (Farcaster)
 id 6d2511d7-07af-40ea-af38-8dbe9c3e3c6b; Sat, 31 Oct 2026 13:10:46 +0000 (UTC)
X-Farcaster-Flow-ID: 6d2511d7-07af-40ea-af38-8dbe9c3e3c6b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:10:46 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:10:46 +0000
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
Subject: [PATCH bpf-next 03/13] bpf: check CAP_SYS_ADMIN before looking up bpffs delegation names
Date: Sat, 31 Oct 2026 13:09:49 +0000
Message-ID: <20261031130959.23472-4-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf_parse_param() resolves the symbolic values of the delegate_cmds,
delegate_maps, delegate_progs and delegate_attachs mount options with
find_bpffs_btf_enums(), which fetches the vmlinux BTF, and only then
refuses a non-zero mask from a caller without CAP_SYS_ADMIN.  bpffs can
be mounted in a user namespace, so any local user can run
"unshare -Urm mount -t bpf -o delegate_cmds=any bpf /mnt" and get
EPERM, after the lookup.

That is free today because the vmlinux BTF is parsed at boot.  Once it
is parsed on first use (CONFIG_DEBUG_INFO_BTF_LAZY, later in this
series), it would let any user make the kernel parse it and keep it
parsed until reboot, which is what the option is meant to avoid on
systems that do not use BTF.

Check the capability first.  An unprivileged caller could only ever set
an empty mask; such a no-op delegate option, and a malformed value,
now fail with EPERM as well instead of being accepted or failing with
EINVAL.  Privileged callers are not affected.

TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index c6f328e4752e..39750d4ad401 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -1059,6 +1059,13 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		char *p, *str;
 		int val;
 
+		/*
+		 * Setting delegation mount options requires privileges.  Check
+		 * before the lookup, which may have to parse the vmlinux BTF.
+		 */
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
 		/* ignore errors, fallback to hex */
 		(void)find_bpffs_btf_enums(&info);
 
@@ -1100,10 +1107,6 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			}
 		}
 
-		/* Setting delegation mount options requires privileges */
-		if (msk && !capable(CAP_SYS_ADMIN))
-			return -EPERM;
-
 		*delegate_msk |= msk;
 		break;
 	}
-- 
2.47.3

