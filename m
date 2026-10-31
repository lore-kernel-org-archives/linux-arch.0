Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452294;
	b=Xj1I4luF81C2uN4fMyArpxC431SKrcdsrKYLxl+SHjwkZn3KtQsjeFvHfREGhVsw7LsY
	 eEICXknIM3YUpqDGlrIgD1JsYw/ZF08lDdXdOpYKzl2HlgNmVprYECCxMPf5lUTecxZv5
	 5phEzNmUF2QfSuG02ovvjf8jiyhdniqGh6+0r2fwCiAGtE46iojGyQOMIK7ghBEbsV6GD
	 ruhZ8qsNsJGvuRsl2Fwf9XkvswRbh2gUKT6hOY4IySQATIwZYkiN1nJjU0NtbOp228E8D
	 yuKVNS39pNLolSut0j00jK+Rt8jQ4H01Wz3QpabXESbOZYWPeJuygn5Jvzeovo1Ygmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452294;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=kp/MpRZP2MqfV9c31w2+3xrb6W0dd0U2IwTHFDKSanc=;
	b=wSnER4P1NUBTCoUeQ+noEtYoOsNgwgS00jewD87PiXejXDttzn2lknbNoaw6ZmQ+SP2l
	 NY5bU6fqkpAUU0rkKFAsd//x6PIkVK2rIutoHdEl9NU9EWiGRMIoBi/HtWb1gulzmbxZm
	 XPdlSLv9QGJkhcN4ZjkVflQ+8JcQAnCrphUPaOtj2a4yoYQBMFT+6CKqhSzlj5aE0siis
	 V3b3lkyTNZYkXkY1ebBJUqUvEhG55ILoN8GoSLN+Clm5QKWLezVNuaRLcLh5oS+N22EMH
	 zrMcI+vIWXt1gnd8sIqvigmU1ZXrIO67/98ZUvpV35bG1f12jCW3Tr4fPZkYStGmfQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=rnGt8imk;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12919606A320;
	Sat, 31 Oct 2026 13:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12919606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=rnGt8imk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452294; x=1824988294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kp/MpRZP2MqfV9c31w2+3xrb6W0dd0U2IwTHFDKSanc=;
  b=rnGt8imk4Kc/QTaYHji0ekzGvFtJzfDiUR32SEDW4rhOMesccaU6Jnl2
   sAD94AIFBKQw3TGsQl8Sn1hxS0zKwLYLZlNK+Ip5b3ryERL8kZok0Slqa
   m2ibK2dLWa96VpGDDSpNLAB+hSkGOhgiiQici8uZ4ldhrZO1gLtqKRN/T
   TqRrigTjXMuQ8zbSSKadgonu19ZWom91k0bELYdlIoNm9qZL9Ai+24cnB
   5crYIiaDnSZcUSn7t98Ycms9WKM10NOj0opsU4E7glDCUIfkm/pnTdhLn
   wcwNEFdrtK5TFeFn3DK0+D2ho9Siidcv6wQE6Hq2wqK8WCPtwrGqTjmfz
   g==;
X-CSE-ConnectionGUID: OpampfiQS5Sl/5dga7faLw==
X-CSE-MsgGUID: yZ0DxhRkSLGQHQOyQKzTTg==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32737828"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:11:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:14843]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.208:2525] with esmtp (Farcaster)
 id 32017848-c627-429a-b728-e94de4fe8221; Sat, 31 Oct 2026 13:11:33 +0000 (UTC)
X-Farcaster-Flow-ID: 32017848-c627-429a-b728-e94de4fe8221
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:11:33 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:11:32 +0000
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
Subject: [PATCH bpf-next 06/13] bpf: look up the struct_ops common value type in the given BTF
Date: Sat, 31 Oct 2026 13:09:52 +0000
Message-ID: <20261031130959.23472-7-wanjay@amazon.com>
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

is_valid_value_type() looks up bpf_struct_ops_common_value in the
btf_vmlinux global, while every other lookup in it uses the btf it is
passed.  The id is a vmlinux id, and a module BTF resolves vmlinux ids
through its base BTF, so using the passed btf gives the same result.

Once the vmlinux BTF can be parsed on first use (later in this series),
struct_ops registrations made before that are applied by the parsing
task before it publishes the BTF, while btf_vmlinux is still NULL; the
registration then has to use the BTF it is given.

No functional change.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/bpf_struct_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1178acd72296..a3d801a7e99f 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -103,8 +103,8 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	}
 	member = btf_type_member(vt);
 	mt = btf_type_by_id(btf, member->type);
-	common_value_type = btf_type_by_id(btf_vmlinux,
-					   st_ops_ids[IDX_ST_OPS_COMMON_VALUE_ID]);
+	/* a vmlinux id: btf may be the vmlinux BTF being published, or a module's */
+	common_value_type = btf_type_by_id(btf, st_ops_ids[IDX_ST_OPS_COMMON_VALUE_ID]);
 	if (mt != common_value_type) {
 		pr_warn("The first member of %s should be bpf_struct_ops_common_value\n",
 			value_name);
-- 
2.47.3

