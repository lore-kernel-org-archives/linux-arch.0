Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480324;
	b=ZvxwTXR/LxeFwE4B1WH7IodjTDG2r6qmeFpxdaGAP6LIzMoASkXLWGrXZJkDhPGQO1aK
	 d7299MloJsh+N/VPxienGc5h9mVCDPpAZimuBMIGp5piH+66LX+K8dbDvElNh75Gkf1Ud
	 wsnSxsvLvoyX4X6P1RYHNLMYmgE+IPqWlhFPJOFEiJxaME7lf91aktv3XOX1Esr440NzE
	 F7AoeaGKCTsVtUGOOh8h38lYRNNbYJABD8WZUONQuMewroUfqOFMrBO4qAOfC/YwEQhzT
	 nVj0MvGJKl0w2a4ZEY/IwC2nl2EmIo54rolwO7MUVfHgTLUALShl82hk7oJ9zhIRvOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
	b=z7SGNpghnmHx8My3YuAWmcVGODZy5LwJEoJOUneCdJlysWrJvR7i7O+zoQxjSq2tCsnT
	 Lk9cg4RkvWKpmq4TYaErCp/dlLV06Fm1Rp6gxeUm7jZaU+hu1opLMRL5iLL6LvKGIdm5n
	 2nq/taNC368xlYRzD1bvdrGaUS+IzLYL1geT/2iu/b5Wd+pFbbIVldi1cuoVBM/KsIiMo
	 BrwteBr3Shu1KN2SO/wb2icwSwZVMF3uxCVzZI6UnUhf8JlV9DyLEGgCCtyP6xYCx9Goe
	 tto5FSJVR1HuzXAacfMepRArnwi4hDo9CVihz2IdBnbCBfF3mn9j9iopw8CCnZh/3xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Zp09kXBl;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76B606A32E
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 10:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A76B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Zp09kXBl
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3720addb068so7337903eec.1
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 02:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794480323; x=1795085123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
        b=Zp09kXBl3tmzhNDXnluIDoVu4hJxPbk8hdtimF2khZPOnmQNb/S51ybbT4EWDLGxFw
         Be7xVzGkqwAHxCgQynyRwNUgCxhCFxrW3KOQASvFTF9D8v9z5Ty/Z1wOAnlUMbVzE4Go
         RWxAo8OlK4tyKB8j6Qr7/bQpjb+eWhQrynqXYzLMO/fX+PBfZdj1SoaL4IBkHxGx3rjg
         mVHJPVd0NHLJYHqnhTFUjKsz2XzQFt1cG2JrXhnnmVTqrUwPrdc8l7KrkRFHqmzbjUAQ
         D8vzOQKHC5fSAMhWu8rcUEyk7QBhECesNnISmx9JsCfbfMYsY2GZ9zBZS2JUP9fCcIAv
         Om5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480323; x=1795085123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
        b=UTboNL/icNNZtmBaSjs2rt/fNvjOBzrmChc+YXoaer7heifFtTSzlKuFzRsmKepKN9
         amF6+9f4LT5dECj9vVWwL28+QyDZLB7YQFYprGAA/23756Vj7ZZcnF8ckiBGyLFtFx72
         RRvj5JzMe3ZXYBxduYDym14eDF+YlM2+FiwjPt81bE3heB0SqNAl1sKhq+bIL8ahfXK+
         0wxyeYwi+z2ZjUTgcYXJP3QNpjR59KOEmUNCG48FqAdCLyswOzqVf1lffs8rUN25ninz
         qdyiIwu5Gvpdm+Y8KbfW7U4vPxFm8w26b9RFA70byVIe7DHO/9ycf4kSpoCryXQ3qyw7
         k56Q==
X-Forwarded-Encrypted: i=1; AL+hErEldCQRKP62s2Zxw0iXAsMx7wIeZ8Eq/mHjRTLxOgeRD/4Vqo0MHSnfCaCzjoYE8qlZpMyMEFUEClKp@vger.kernel.org
X-Gm-Message-State: APuU4Z8zvH56uXzkb8TVx8fX3OOMUWCmiuFuAWMZYHxZO47996IzxQFB
	MhxYtOQtNiDSymQmDPFHQV48vU5G8gJ0YPOJSmcbjV6iBarFpg1kDCCJcacSZ3OWyTk=
X-Gm-Gg: AYBFou1VmUbCd9HzFrp5IKtqtdOON0Nrr/ar/rKH3t5p3DeVTDW43ksSAzr/4t7wu9K
	COIb8MaoK9VmBGTngZqzd4bNcwRLFDcOXz2gF5EX7rcbp/dF+mVaDr0ykYIgNxmGV3U56tk9Qc8
	lvpZ/cDGW706EPt3cJQGwLTgq34dbsCjso4PntqL3K1Y+mEtjtK4YuQpWCLY3z5og3y8BFeiR1N
	7Xr5v2p1BQGxvzrRS3XxQczPZBJO0gx8JoxoYP2zZeiSF6mkqO1sYY0nOt/yAniq4hkFnO+AZft
	Bc+Wbff+BLZpwEka0SPhPCmvWWClC7gMz9lTNaYhr9ebM957mdOY/yDWGPdQGDvVgT6Yb69YmOx
	YRf1B0twcFz+gEjdTJ50iVD8s3gBewaSdoLzM9rZrDBnzZK1NioW7LahsUyjKGtGEgxQv9KreRV
	rvpm5cZEfM7/cnykzb6iDBHgeIOYu1ekDwE7ER7ECXjio3biM24ogRZBWp/0TiQzs0HxdSj4aeK
	YnrUlr8cFKpGyne8A8d0aPjHclYVO0C1gsc8pqFx/raRPL1ZRfvN1MqxYLZDyEPlZ1H5Ovgt6FO
	SsRBtbwpQ0VCfx5AUpGw7LZ6WnDqNeZATtAnzvVwS7WdObqqvM+ba0DbPJYQNkfQ9Ek=
X-Received: by 2002:a05:693c:69c8:b0:369:fe81:a575 with SMTP id 5a478bee46e88-37686756684mr5116143eec.35.1794480322588;
        Thu, 12 Nov 2026 02:45:22 -0800 (PST)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm13228694eec.2.2026.11.12.02.45.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 02:45:22 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	oleg@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	broonie@kernel.org,
	cuiyunhui@bytedance.com,
	dave@stgolabs.net,
	david.laight.linux@gmail.com,
	jszhang@kernel.org,
	tglx@kernel.org,
	conor.dooley@microchip.com,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v10 9/9] riscv: select HAVE_CMPXCHG_LOCAL
Date: Thu, 12 Nov 2026 18:41:49 +0800
Message-Id: <20261112104149.38589-10-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261112104149.38589-1-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
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

