Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587372;
	b=CkBnwkN8nsda6B7FaiWJiCjngywJ+n0zeymWP288UcTljcVQ9VBISgMgqT/HuTuMzWxa
	 T2sQQuDilfUyGUF1o0vEHDlUTVz8ffe7lgDE33hZHpz39Fw1LdOjUPs2YGN9zbmwmaXVC
	 Jx0+y7UYbfF2FiTLH4036P2VXwHbWoxEw+t75imS1kx9LIapOgXlgUzo5wlQZInH+hGoo
	 OkSKsUGM0ZaovYlZUaf2Tx1uHrBuE9zVXbTmEsJxSe4p0TaIjn4RN2mCKNtSurbgo4MvU
	 DIlplDLHk9vb/UT4bjhKbNm7c76Fmpw6WJOsfeCHy4EqgIbuuw6i/EJjJbnXLdhOQdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bS1O6gZBZC8eMhEAflyw/nPs5CPcAQAclZg8OIJWUGg=;
	b=c7Zi3G/YxNCR7ELC6W0yYD5ANexBV94kIeN+Yb5YdvKJfZxasmVvW5S34vMJ7ODTMRYV
	 o/byhwZbt6wPhUXZJo66nud7NmAKagLCMf0VN/qXxnpxQsWbTfxBP+drEB8yU720zUGWX
	 AIZY2WlKuJ3+J5RLamKoPUtaiwhupXnYpeiri4sbOQoGEJl2e+kgze3d4o62h1rB14WBG
	 Rq01rOLcnA0O6AEV6GOqfXrSQ7Lr93YIPKB0VSzKwKe5kIKXW03bxjtYrMBv5pVpEcpss
	 4iHfwGKQFv1LOYrXUm3FwUXxVyiLtUqhpoEJ8isT7uPhApRQlBq0Mh92Jg/P9MMGpQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Db/cRPFL";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59260A261C
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 06:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF59260A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Db/cRPFL
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386b8624cf7so555030eec.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 22:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587371; x=1796192171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bS1O6gZBZC8eMhEAflyw/nPs5CPcAQAclZg8OIJWUGg=;
        b=Db/cRPFLfYVCp+2GdQfozLgX7xQ22/ZFmmU+8ONn0ztqKNHD5GQP6wLynJKPPmdp9v
         CjY4/zp3pIGiflimiES3q8iGcr0M9XMEu9XRaXQY1lXYRJ14v0lU/NxPyl3FNsagDWsm
         meKiuP4xhYuX5egFh4+zDmRCql+CDY3MNDoZ2Vjuom3u46bjoTR/E4w4/qkQ6ljAvVBC
         hvgS0Ll/7G0ispHlE9t1ZSd3RQtHvUMXRWroFpGoP5AjRsRc6A+psnQojtxX+CIgFxNl
         d7rElfx3LYYsCEoXoomSKrJg9l0SUi1X9vw9lifNDMMI6qq86Rpbqhqk3PDRLQoncrjp
         BmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587371; x=1796192171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bS1O6gZBZC8eMhEAflyw/nPs5CPcAQAclZg8OIJWUGg=;
        b=oClmIl8yD4M0Osj00K1DLS4hMw76l1LpPhXp6rRVZLkzoeiJ3MtO79FskI7Ko1xWDd
         xlAwo0ObOsjwQ01wYATNIcjxjschc3hiBwgGL/UO/WullAd1kRBlqAjluNcI/umC2qC8
         YIQugUunc+ySES+3K6i4NGRC8DUUaHrKL+39onr9IkSr8MWW5hdKiTMC2KJe5bG0IPEe
         +CckRXY2tVQxwURXnvxCcHWtV9vdqdv1E5E3WhaBl0qCRKVmIsjaRoWlECm+5sZByzqI
         /qrg7k+sKTmCwwMQ7ZPfxe9UThsIKcb8ZmzB3PMxh3/BjKTrouO5GfYEKz5WhcOccYm1
         2+Jg==
X-Forwarded-Encrypted: i=1; AL+hErEEi2MatvSfkN8zfC+6qYj/PoH3JehxibU91AOqqG879AHCWhPXhBY5MWzohLIWhMwMUBlWepV3u52t@vger.kernel.org
X-Gm-Message-State: APuU4Z+C8y76LHGxxl9f2NQo/15TlozPzJKsHEqk+0dzbSWbI0O2jg7U
	2IbrT/pYHkHT+HSrekYoqkq18ywGoJpbZJQaBR3shHIbIwlY6RrX1Fxm18b6NiHTn13cRLVeSy5
	C1RL1QEvtpA==
X-Received: from dybou2.prod.google.com ([2002:a05:7300:e5c2:b0:384:c70c:3c65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:269e:b0:376:5b99:a816
 with SMTP id 5a478bee46e88-3856c2c3fb4mr17120337eec.3.1795587370674; Tue, 24
 Nov 2026 22:16:10 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:00 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-8-irogers@google.com>
Subject: [RFC PATCH v2 07/30] objtool/ibt: Ignore .eh_frame relocations during
 ENDBR validation
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When vmlinux.o is built with -fasynchronous-unwind-tables and
CONFIG_X86_KERNEL_IBT=y, .eh_frame FDE headers contain PC-relative
relocations referencing function start addresses across .text. Because
.eh_frame is read-only unwind metadata rather than executable code or
indirect branch targets, skip .eh_frame* sections during objtool's IBT
relocation validation alongside .orc_unwind_ip and DWARF .debug_*
sections.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 931c5c412f15..e631b0da9bad 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4644,6 +4644,7 @@ static int validate_ibt(struct objtool_file *file)
 		if ((!strncmp(sec->name, ".discard", 8) &&
 		     strcmp(sec->name, ".discard.ibt_endbr_noseal"))	||
 		    !strncmp(sec->name, ".debug", 6)			||
+		    !strncmp(sec->name, ".eh_frame", 9)			||
 		    !strcmp(sec->name, ".altinstructions")		||
 		    !strcmp(sec->name, ".ibt_endbr_seal")		||
 		    !strcmp(sec->name, ".kcfi_traps")			||
-- 
2.56.1.831.g720f3f5937-goog

