Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484974;
	b=XMW/ZD0gZDP7UWOl4L2U1jNUN1gVjDsDLJQ5n1AWe0VOQjrZCFsPc8Yqbvc+PC7Xdd+O
	 Q08aaDgIMKqfuxJifEF9+Q4FX0H+8ADnJUMhItWcPpgPeJNy/2skTrUUoO6yBT0b6iciz
	 oD/tM/2NaqxRBCOjSmiELZoXYz09Yt+YMR9p6T5Oo3YValW5Uru5/a5JO26EGwQ+VTs4z
	 24Hi5VOWpJWYtn14HganXDrk7Yo+PJIAV4x7WcwHGbAdg48yKS1LL4cS6Eid0IDuETE+d
	 n69mrfFsIhpcbAebM6QnI1k60bZ5wUoJFjQ2mmq2GYu4FNUd34GDoKpg+rjYfkWiyeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f4QOZ/ziloNp1YzjgE4+Apo8LJ81vNJIp5Lxxwu3DGk=;
	b=geQmX0PXIugoYJ+2nc5VGditcapCap7y2qhBjnTMOxGCSH20eRw7IXz6GMOShOS8nYFH
	 6kGfUzAostWr3SWAVOIwhbjYXiCkGLY70DT67kAcz4nNFfq5TiJ81DHOXSTwc/x6iIBxB
	 m3hQ8qaiaTiSAw7Lfk04UAniYmpaPwUoi8LDfLktJfasbVHXsZnE8wHQtyQ6UtF6Nv1FM
	 ycyCyIYzvjByzAOMAmz6bHE6yrnX0GdWjp82mxuz5RcqwGliNvBtcMhrXygYoiUZzjGAV
	 BwWLAXBvZzZIDDKap4kkeqdsZLY4PbJhtFJXPOTQvQFvEuOoM+NQ1tH15tpyuxeX7xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OCaT3bl/";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC9606A31C
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 12:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DBC9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OCaT3bl/
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so2810824f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484972; x=1795089772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4QOZ/ziloNp1YzjgE4+Apo8LJ81vNJIp5Lxxwu3DGk=;
        b=OCaT3bl/FsF4u2GHgdA2lN1oedkz2/UEv8Oos3RDlLlU8ET813dd9aI1TVGoqLuZI0
         Cf3c6fY+8VCQcTHGfpyQJzRvmg4AjXLNyDipH4B+F8cQh0G092DJHFljEb4yd7nb1Mjn
         droxBfrL7V7QF8R72rr74a36DJ1cJRvw1EveftmQL3or0Zyu2flnwWc760kjJdADR9CO
         KSyBh2h8pY7CqQZCjmg25rtuUuMdf5lIbwhSjgV5kIMkoC9JUSmgEOV4A9Doap3qfC4z
         FmVB1+f+id7Ei1/YlTCj3XFJrUzCsnYTJB7tF7JVilKonM5SQA9p7pJbSHaP/duFOBWm
         zeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484972; x=1795089772;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4QOZ/ziloNp1YzjgE4+Apo8LJ81vNJIp5Lxxwu3DGk=;
        b=CfKRBGtBekmrvgAHU71wFCO1w1ui7a4PRwDxJ35gFyoqgcWc5wYSkgF9xZLJTLqdoI
         HF0x+TBsLEHZfi5j1ol+bJUze3Xzw2gnxqVEgNFNPB8FfIp1C8XK8j1vK6s6Titu69lE
         DWlsGC+NObCekHoWFUXmDo4SpVJgjb3t/ggWawzeSvip8n/EsbxQ9kKIwTT9ar1Nd+Ak
         1+0qebkk9ZQWcTvOijhNOIfMqUkoH8XpBoHRQapKA6yvEyCJfyzW8s54N3qlCBFlKcoz
         T1HAhG/nq9j8H/JgKQSCozWpt7+ftQ3ZS/7L9+DZpjrWTaBnI983Q693V/1kdLS7hZSt
         56sw==
X-Forwarded-Encrypted: i=1; AL+hErGsAxg6yIthvKgRuU0m3oBboH/8/X/d63gUuVFiE8/FF5jTMSwP/O411ZIpIzX9CVIoAK35ZROi5ILV@vger.kernel.org
X-Gm-Message-State: APuU4Z+NxD8EjrWI5h1tYCcVtYhNisEB+WD7SQRxXCnBs6YDDyzeq0eW
	LsBP2V2YbD39njFL+uJcp/Czn8jAre4pBtYhyiHeHgcJsWyHwFIWPKeJ
X-Gm-Gg: AYBFou1b+10UVv6+gIskIuzZVvyPJtxBB6cjkctZ7NKkRd/AGq3YRistchIOPebkZa7
	06ME2+X4yzeVriw0IbgTMZLs3vedRZ9I3fSuSr7WiesrnUWvLuhZoa0MDD0XMznJtnjQa0UmR1a
	axpPhOCL0CtKD0mXnZOQHuOn3IVtIy2/OxXM5qmJryxgIy9MlHWPFgGVNoAxm5AInmuwpVJMmCF
	1gp5mFUJhwOoVhwYCrv2YfVlKX16+cWCgynDPssYza7EIoQ70uOhyICYg2En14DkeIG24Z1uEaz
	CIaOuq5dpoYtJ83yfBJ8qRqYzfUJu1LV79qIpAxv+Qscs09xFWtgUThj6EDNbZFsyT2gNULVP5H
	4EyfelvYpa1XpkTMC8/XWhg9UBeeDKCTAVcKtuWXxkc62xJAw3c4eIBMIY+O6Myw97Kmi78Kbe2
	Fpq9HUqSHCyvPVcq6SXF7B2Gi6m1AOOHtInH1GvcN65YmpCYBaXJfG11hs8u98ybgMkq+0S2jt+
	vgkm7s75CYVallQ5uX9JkZY7wVB4va7oss0+OpBXfYnGYxGj4mlsdYqDmmDurajAELiMD1hETZi
	kDzuHREoi0j4UrqvMT8iV+9dU17DwPfNTwDFupnKBgNA8mp8qIUBUwZ2g7+HCBidag==
X-Received: by 2002:a05:6000:460b:b0:491:1e3f:a427 with SMTP id ffacd0b85a97d-499c898168fmr8711941f8f.42.1794484971757;
        Thu, 12 Nov 2026 04:02:51 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498367ba82csm16541261f8f.50.2026.11.12.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:02:51 -0800 (PST)
Date: Thu, 12 Nov 2026 12:02:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org,
 oleg@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bjorn@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, broonie@kernel.org, dave@stgolabs.net,
 jszhang@kernel.org, tglx@kernel.org, conor.dooley@microchip.com,
 thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk,
 rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com,
 debug@rivosinc.com, seanwascoding@gmail.com, andybnac@gmail.com,
 menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
 wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com,
 arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v10 2/9] riscv: add infrastructure for preemptible
 this_cpu operations
Message-ID: <20261112120248.5c8265e2@pumpkin>
In-Reply-To: <20261112104149.38589-3-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
	<20261112104149.38589-3-cuiyunhui@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 18:41:42 +0800
Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> +/*
> + * Mark a region where the per-CPU offset and address registers may need to
> + * be rewritten by exception return after migration.  The three registers
> + * must remain distinct for the whole region.
> + */
> +#define __PCPU_GPRS_BEGIN						\
> +	__DEFINE_ASM_GPR_NUMS						\
> +	__PCPU_GPRS_ASSERT_DISTINCT					\
> +	"li %[off], " __PCPU_GPRS_VALUE "\n"				\
> +	"sh %[off], %[gprs]\n"						\
> +	REG_L " %[off], %[pcpu_offset]\n"				\
> +	"add %[addr], %[pcp], %[off]\n"
> +
> +#define __PCPU_GPRS_END							\
> +	"sh zero, %[gprs]\n"

Those are quite nasty with all the hidden variable names.
It wouldn't do any harm to pass the names though.

David
