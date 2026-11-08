Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135960;
	b=aUqGcErI6LhxOW0nXP90uyTlWXUrGVsrkOiBCRpJDlxqdHoTCireK8ZzrATexz1ayXlA
	 d8wX+gOcHUDRJaON+rGcmcPErMdHIsEIhyPVUEjZi/FufPScWFzFT4FNt15DPO+dy5QsU
	 lRT/ccdWOYQvbj8pi5UmYJjU117ZZM9Wz3BZvWbvpCpoGMoF+H5tiJFAHadgmbsY1w9oZ
	 xyeXhPnD8hAtae3qiCCdNbinIMpj9p+oEnJuubtdFQf18dIWd6Pe+e2CyIAk7/yTD9CcE
	 sXVkXCgrIhN+giaPGFqjpNr9NmB/2/WgAjNIwmREnwZVEaYcotyUR8Pk5LmgBsKD4zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
	b=Q0Ax8boHIntOHoOIU1Ra32s9kqWgfT/BkOSQ/jmEPZer4Sin3QPUVV0II9XNL/Hg4/gp
	 Q6gssaPbclsSWyAKs1f+ckBiowDQP7QKlOeHVFhdIvLZ/7hDsHBOFYGYzAQl2y1grVarP
	 K4YLEquQSVb1+uHuZ/rBMsEoDe44Rj/EAR+7ygToa3wp59QWzhTQv3OBjd1ypF496pYHL
	 M0QBHo80hpUXyLO0oOG9hRnUXZNB67M3r3ji1evkcTFP2FpYpiKZ/DPMV4sAEajC2Y0j5
	 2wrMz1MWdxGhy69WLu7r+iouLsQQgCbywPm8n9RPxjMsxCYnD8KrNlUNY0+aUXXpG1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=D+POMC6D;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A3606A323
	for <linux-arch@vger.kernel.org>; Sun,  8 Nov 2026 11:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 230A3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=D+POMC6D
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb684859cbso5225a12.1
        for <linux-arch@vger.kernel.org>; Sun, 08 Nov 2026 03:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794135959; x=1794740759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
        b=D+POMC6DjnAMXuun5QRRLTq47rbKzSW6rpLIO6+pAax71RS7F4vSqzHL+czVDCiR1a
         LKec1rgU4fX8MAKqX7xxjoyLlpNYxct8bjOiifxLPor04GN8DXvtYvlkWLzhlR7IgYaa
         m70rONQ83iI8iYaSFaRxXH1VeFI3f8l6QemXDsa69/5YQTuUjJpM/aN5A7Y0y6cO91Mz
         fuWUiPn8EEuTSNeeNOPXtzC0HqXzXonppIia329VxHVByAzAnfoSYLsPIDtpvQYxJC6f
         53aWPPUjP1Yhi6OygYQDevmecBxiQHcw/Ac3eJLaBM3mGAkO0cuDPEqNxPpOpprTqdDn
         HLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794135959; x=1794740759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
        b=rXw0uKGBPac7uLNrwsxtiP67avL2Pl73WN6kKoZAoPYSbnP/3kQKm1QZ/C3nF1nhsO
         wKwsvPD307qDJ5EF+T203DuhPA6y9yMSuzQybF1Idr0f5tVCVAMuLVzPYwzCj0gIN7Km
         vbN0ry5JdUPmDD0Tnl/7WRP62qLsfdkRNk/zX0v1wYqAoDvbExJJ8B736uFVp3svYkI5
         256wgGE5y94REPp0ryJ4aw6WhbPbwkgNm7H3T7yl33rDRZQUMmtOnBQUMIcJME6HT1Dk
         KqXrYJQB4+i8fIfgX0bxjl/R/q9jrFZYTmFeZ9TPfK1hXj8FzQs5zaaWvDtdMqHoV0zG
         IqDQ==
X-Forwarded-Encrypted: i=1; AL+hErEN/9JWpL3+PvKvi09lRyUvz4OYzKM+63T93sZ6Eq76gvKXN+35Qe4f4Q2mcdaZAPuPYqZQTiX4GTVT@vger.kernel.org
X-Gm-Message-State: APuU4Z+UdU/XU1XcA3Wgy8WjJedjZTnYktUyxv3wJqnxbwuxzYrhATrr
	VvjOWctqZKjlh9mNpmxzzyOvTqhmNO1NIfQINYiYZGVkIRWr2fLKCMRMZNKKK+XHm4I=
X-Gm-Gg: AYBFou31mccYglJzP6G1LnPht/1kaBG6xaWN2U7mPCFZ5UmQTDdVT07BSqJrXtzAVbD
	IvVpWoRrkb3jARJcu5jq/M5gt96sz4B498D+s96vkRyycY1GGuoHy/y4iS83KMzhB9nVF66vym1
	ScX5wV1CuwFlZED5QyfR843yB8UpwuExdYwHj2nlAhIY1mMRElmlwhHAPM/EhORxypLOfGY13eU
	Qj/gBzfYrZLY8j3AvZQLwTF1qYI+Gp3+ffpSv6+ItrKCd0JhM6MdXg86AGMrZvgJbQj+3P3fJ/X
	Z46EtFOXejFeFXsQo3QBc9zoPFcNGmPow0WpJTWxynyVNRqfyeJbG7sivrcEgg3sl/TWl0AHqE7
	twurV3J83Ne0BNS5yFpRl8yh+dkyUlUYU5bWb5LIZ2wgzSppmKREbNWuj67Wh/4sLhLvE8QsbdV
	8OPKX5Xfso+TUSU1QsDwqmDOApjB3R7BEmv3Ds9vd5TYecqZu21I0yMQ/sKqdX/UmGHuzCBJcw5
	xDUIJBjZQcXQObUmSXdQCWcljY9Y8MnQ1sEPMHhM3tViXfpznCKAmeo2pUXdD9YCbKAYMfwn+q9
	dKtaNWU87L8k3NKK3tcWNmQqY99etSUw1GWlgQQDJLE8P8IlQpHPS7JiAZyBzyg=
X-Received: by 2002:a17:90b:3b8b:b0:3b0:9317:5842 with SMTP id 98e67ed59e1d1-3b12d43f8c0mr1076560a91.48.1794135959430;
        Sun, 08 Nov 2026 03:05:59 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm2609818a91.6.2026.11.08.03.05.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 03:05:57 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	conor.dooley@microchip.com,
	tglx@kernel.org,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev,
	dave@stgolabs.net,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	broonie@kernel.org,
	cuiyunhui@bytedance.com
Subject: [PATCH v9 3/3] riscv: select HAVE_CMPXCHG_LOCAL
Date: Sun,  8 Nov 2026 19:04:06 +0800
Message-Id: <20261108110406.97495-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261108110406.97495-1-cuiyunhui@bytedance.com>
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
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

Now that RISC-V provides this_cpu_cmpxchg(), select
HAVE_CMPXCHG_LOCAL so mm/vmstat.c and lib/percpu_counter.c can use
this_cpu_try_cmpxchg() instead of serializing per-CPU counter updates
with local_irq_save() and local_irq_restore().

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20260826010748.zphu3wh2hlm4t4o2@offworld
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bde1f1885038f..458ef01e926a4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -155,6 +155,7 @@ config RISCV
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_BUILDTIME_MCOUNT_SORT
+	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
-- 
2.39.5

