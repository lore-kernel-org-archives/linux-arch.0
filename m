Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452403;
	b=pXdYMNiVS5DZkUxpM/I0Cwc+i4dqvjZeY0vpO1q47yhiqTrD82OzWcoC93R5kzgoY4tA
	 tNx98nEQH9vvzd2WQxioFEMhNBglZNeXZ6plZm6dOOZQr/0OsPfwkZH4Rx+Y0AywWdkK9
	 AjG4RTD0xgyWoXOswX0WAT8c54pNFuCy373T/v2Y0b+gnNseL2/IEfKWKd+BQjybGrT4p
	 evRu/Ezm6Xt1JOwzRloUyI3F7Ke3/49WMv4EEch93xeFtt0/MdmdO7sur68KXoh+5dFLk
	 tx/3Rr3wL6JGjapAC+lK/P+ptkKXwXdgzLvhehKa8R2JJPCRrmvLTQlK5WVMIMdjOkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452403;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=7C18DKFZIWaFXskMKG5hKpW3a2jitMcBzhWiOTJcy4Q=;
	b=UphYYkj7DxnLnPUmq9tWtUdS4qID09hGZdLrVPhl2go+zKbUmoxG3uP+ctj1Talni5PX
	 X7gdTciHQZS1fkzMg3q4HPe9IsbcAvPwQ/3Ydfg627XVvAjIhn2voZO4NO2sjI/PUl6Vb
	 HDYPc6Y+FlJlnPOME8aKPOqe63b2vNvPovDWd3sCqbN6DBs3A3CVeHPWv3Jj5OH0baVf9
	 jJXHnpOJIxcOrxvYgR/EKQDuUiWeDxmTy8/On48gAUljrt9wDnIVvScsw/9m57bOPGjUj
	 qU+xeDmO8oRUHrplafjrl5kT3Bj2YXv/PetPrB5p59Y5mMWAlx20azE+6XX1DJzH5TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="U6g/Z67i";
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27B606A31C;
	Sat, 31 Oct 2026 13:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD27B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=U6g/Z67i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452402; x=1824988402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7C18DKFZIWaFXskMKG5hKpW3a2jitMcBzhWiOTJcy4Q=;
  b=U6g/Z67iK4x8Y1I6/dLnX63RTOF01pAodjoboBRMTDkAMLu36jxylpTX
   clCKZMNABggKj7HQfFinWZtpEygJB6n45WiZl7/4Baad9K2vxDgxjx6iF
   XcLIyEJ3gLdGm0Ygph3oUwqoOggE2mVsTiyRnY+sGxsrjAilKCM6wANzh
   FLmHT3PMOjv4l7ECwKzCiEaFKH2EAhaElHC4IbArS6LYKxS00PRQlzGhP
   p69XKgYaqD+CZBJ46xtWdWbaP4MyOnUAdUPUj2twY8FNagSVkobbeJpaJ
   QH6ilrMLMSgMeDUbKhDrFCVx+bGw/LXHWMn8pynPROBO5bGucEtDEIbDk
   Q==;
X-CSE-ConnectionGUID: hly44ySaR9uFED7ZApa/Hg==
X-CSE-MsgGUID: RD5UJqX+T3e1daIfth8l6w==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32516003"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:13:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:25917]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.208:2525] with esmtp (Farcaster)
 id 4b22ba2f-c8ad-4f9e-bc22-f51de3ab3b3b; Sat, 31 Oct 2026 13:13:21 +0000 (UTC)
X-Farcaster-Flow-ID: 4b22ba2f-c8ad-4f9e-bc22-f51de3ab3b3b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:13:21 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:13:21 +0000
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
Subject: [PATCH bpf-next 13/13] Documentation/bpf: describe CONFIG_DEBUG_INFO_BTF_LAZY
Date: Sat, 31 Oct 2026 13:09:59 +0000
Message-ID: <20261031130959.23472-14-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Describe what the option does, where it is available, when the
vmlinux BTF gets parsed, and what changes for users: registrations and
module BTF that wait for the first use, the BTF id, the missing
__start_BTF/__stop_BTF symbols, and what still parses it at boot.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 Documentation/bpf/btf.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 29de1222c3e7..1ebce5cf5783 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1276,6 +1276,36 @@ format.::
             .long   58
             .long   8206                    # Line 8 Col 14
 
+6.1 Compressed vmlinux BTF
+--------------------------
+
+With ``CONFIG_DEBUG_INFO_BTF_LAZY``, the kernel image carries the vmlinux BTF
+zstd-compressed, at about a quarter of its size, and the kernel decompresses
+and parses it when something first needs it: a BPF program or map that uses
+kernel types, ``BPF_BTF_GET_NEXT_ID``, tracing options that print arguments or
+return values by their BTF types.
+``/sys/kernel/btf/vmlinux`` has its full size from the start; reading or
+mapping it decompresses the BTF but does not parse it. Systems that never use
+BTF keep only the compressed copy in memory. The vmlinux file keeps the
+uncompressed ``.BTF`` section, not loaded, for tools and module builds.
+The option is available on x86 and arm64.
+
+Kernel function, destructor kfunc and struct_ops registrations made before the
+first use, and the BTF of modules loaded before it, are kept and applied by the
+task that parses the vmlinux BTF, before anyone else can see it. Errors of
+those registrations then only show in the kernel log, and a module whose BTF
+fails validation at that point stays loaded without BTF and without its files
+in ``/sys/kernel/btf``. A first use that runs out of memory fails with
+``-ENOMEM`` and leaves all of this as it was, for the next one to start over.
+The vmlinux BTF gets the next free BTF id, not necessarily 1, and the image has
+no ``__start_BTF``/``__stop_BTF`` symbols. The inline BTF
+(``CONFIG_DEBUG_INFO_BTF_INLINE``) is not compressed.
+
+Users of kernel types during boot still parse it during boot, for example BPF
+LSM programs, the iterators of ``CONFIG_BPF_PRELOAD`` (loaded at boot, or at the
+first bpffs mount if ``bpf_preload`` is a module), or a module with a
+``.BTF.base`` section.
+
 7. Testing
 ==========
 
-- 
2.47.3

