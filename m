Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126475;
	b=35RWdgIVNXgwYCOxQ6rOIIbD+d8h7VfIexYDZwRFpsblDW78SJwE30h5EzSv5J0SB35r
	 Kie45ceZ10cnM/PKeYTgMRva8v8H8FiFMsmPi/k+szcI3MDkjr1GTXFBL5ktSoQiePGUr
	 Fs4/E6Tm/tagfA/YiPIoZmmCPc45hMWrsfRqAcBTNnbR1lMHgfZViXBmmUaarfygMIpMI
	 Zo770m4oD840fR9AmdTSWY3Sg/HAzOHd61sJxBbdpiYDOU3jjB9OFy0uEPPwk04waVAFD
	 osPxWy/k3P4aIFk2KyBBWgEZMda+Kdkf4x1kQbV0kV5+EFTOoX3rHWDmah8KEfrxFkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LHJ/s2pok+cQGyJRZxhcYGZiYXJmh71TKyHNP9sAFZs=;
	b=r0nA2/1uXH4m3YEkxfK0EW0U3zNbR27HR7yNOBwZnAa9z2RTVU7/ulWEpd75f46qOXRK
	 v+GrnfzZwoVvh1DE647BPS6SnRDhpzDUMN31hjyDxd58f6ApjkejRQLqnY+B4UiBGHn2O
	 GfgkseLUSRXa9qItq+NpV24jKGjnCW94uDxhNwyEr/XwKxLVUnuj4AMnc1jRxcyWUBwYu
	 hHNp3U1nZ/uSKRgkx+k/MzcDkIgVDT2Wpspx5jdqYHle5g1w07vygBiEvPQ2MHAZ81RrI
	 tBNhfCJW3cje79XxqnEHxLuhhBfHwu9KzDuY+V0eEIuB/7GSagYol28/BP7AghWLKqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=St7c8hWs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5F606A320
	for <linux-arch@vger.kernel.org>; Sun,  8 Nov 2026 08:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC5F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=St7c8hWs
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-847ac7ccd85so138438a34.3
        for <linux-arch@vger.kernel.org>; Sun, 08 Nov 2026 00:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794126473; cv=none;
        d=google.com; s=arc-20260327;
        b=RmjQKX73odvuJ3/Q9MSuSZtdjVcOA8RmCAT4fr/vYZmGjGSY21v7vtKY+yOfYrKpPS
         cO+JJjZ/822HgtadYOkEvmahdFHpUWdDp+MGcCxFbF976VOphWfnFeDj7hf8AyaWeM4k
         Z0acCpXXxJwCVlnvZF8ClSbZw8j72Kg3lE2BeKA9MGTW7bejKM5wd87NLh5H563+B5Nv
         zN8osXQePu99EZ7sujGKk6Bbbz5tDScdKdGbrhE34IkPvUivv5cAQEd+o72KEbcFypv+
         GsSJeJeY77EFVQhsrDrmB9y9FiP8FQrEReWJZqUdHuDdahgNYaAJgMyjD7An053XBrTW
         z5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHJ/s2pok+cQGyJRZxhcYGZiYXJmh71TKyHNP9sAFZs=;
        fh=DKwJQCeok1GJ6ik5yBqzXbEUWSLsHPzjiKda9anPBkM=;
        b=JxTNPGTPMwUhdje0wY6qqYRah/GISYK2xhoWIkxdFM+C8qP9IcKRg6UqFTfdySakuf
         vHTidXiFS8SsDZmwotoX3VJi54mgCVbzFFFmWUrK4PL43mktE7BlARGBIbgJpwFqvM9u
         yacV+n59A67O3DAZyq1g56h+b1TlsQ5b5cMw2PBnQljsywHLxWKbAgga48FTimQ+n8/a
         o6sInr2Yr+P8exOdm3/2hac+jtsl+ts4qJJtT7iI+J7/03J5DVS0hdBCGHfbLMr0PLuE
         nRm+SK7/SAzuAt4wUCIDRTxkhaXDb0R51WOecfogcwZCiTHkgqtd85iGzjXUyT3Da5/u
         WW2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794126473; x=1794731273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LHJ/s2pok+cQGyJRZxhcYGZiYXJmh71TKyHNP9sAFZs=;
        b=St7c8hWshA690BLsea/7BSBugBcIPmsC0glB0voRD2wLUW70KfdQBUU82HHi5IRjr7
         z56tvSXxO1k85jcc++z8ES41Q6kydj4961RV0ExG1dSATkUI96WMEFdbtuZ/uJiU0E4f
         sJbamRQSOtSkMP7mMaa3SqKo2pWxEgS06n6KbdpHnvPOXyltZ7DeNe91P+i7920+mkXd
         +k6pD3Jt7DdAL5DVvc3UKESlsjdRBdEY3TJcTvTuQoTWpSu7nBH1mG4ItkP+bOjggYO1
         0T5qtkI90Ftgd/l3g55HZcwUAvMh/oeB228IuwKF23qu6bqDxE2v2q9r3iFR6M1R5/Mq
         lzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794126473; x=1794731273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHJ/s2pok+cQGyJRZxhcYGZiYXJmh71TKyHNP9sAFZs=;
        b=X0aMyBkkSDzJs7FnRBJkX2SnlxPF57lStEFnnU5du1nGlCaPI8d6/m0cdcYJJHHoI9
         tcu2j4RjtDPQaqu4jM5ETC611p6ds+znN6Wb7Kyxmr0G3z+bpuicQGczleuMnRwtEGl1
         K86C+Q1U5gNg0uaJ2XrTMeYOBTtaMVCIxfJbi03meEbsAdZmdbXYMw/a7Br/K9SD7ImQ
         K7KjWnI5L/msh077vrav5mlqEv2+08vgoziqzTwlgRNJ33bMBiaGqq5NA49iw+l1FjF9
         MqdWqv7nMg1o6OmBzPO87V7cNL725Z7gv+Db8JMyDl71d43x5FaGfnpR+8EzzdEfaOd5
         o2Og==
X-Forwarded-Encrypted: i=1; AKwUvBzjVbB2fxvXeO/5CayhAwQiXirrqTDI8Crr0eOeuCmEYdTcoAd5YUXvTjXdqE8w3o9H5/PuWzRIw9Fd@vger.kernel.org
X-Gm-Message-State: APuU4Z/UAJfkJWvASWg2QrmncA3WS8GFSWR3eEEFBydylJiWRY+e6HYP
	SNXxGMp2JnCJW9epQIeWyiZiXwRk+Zhds0Gxndg2SntkbbAUWFm3nCUoxOMccEsmyrwvMcXmR8Z
	DU5AQEyiEQOy0pEXDZjXnkMGUj7QAv/80H/bvBtoC/g==
X-Gm-Gg: AYBFou17JWc3NF6Q1HNwtYdq5EePToovJDkI5GVROFasWLb1mJIHEMuXEQSkeXxh1n3
	2Az0IidcCbTevT7UyIDNILJuTS/aG/oemD00MF4c7GaI/dpd2Sg2qzBkcKlzgpPF57Nt8eQBWKc
	7EK+HysD9vCRyBVFH80mLksP079eA6+vWUKOQ32qySJlSMBkV6DdU0MvvWwKjiBs56xMTYVbzfi
	jYAc9xg3egZQlLtg9P3Et+G937I3QougexJTaUtyPLwPtgYhJbGblbBzoViD1C2ac8pIqh9K9au
	eER1Ubsr9LqXzhs69EyWXftCwIOidO4e9cPgiXToz+KZ/UE8pSCGZA5pEjIBRrzbjzH/+By54o+
	POKKhaWX3k/TD42nQDvAzorXPuoNT8SEr3SoyiQ5klEtz
X-Received: by 2002:a05:6830:71a3:b0:80c:d34f:5f5a with SMTP id
 46e09a7af769-85f5075a36fmr645255a34.19.1794126472981; Sun, 08 Nov 2026
 00:27:52 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-4-cuiyunhui@bytedance.com> <87bjcnlrbv.ffs@fw13>
In-Reply-To: <87bjcnlrbv.ffs@fw13>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 8 Nov 2026 16:27:42 +0800
X-Gm-Features: AclHuK-No24RzFz5kz6KGOgepjfUU9hWv2-yH0FoZIN8FZ2Py9-_ynkukYR0a6s
Message-ID: <CAEEQ3w=B4p-_4pg3ffrkSA_AXuz86FCd-w4FSB50HoijcSL74w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 3/3] riscv: store percpu offset into thread_info
To: Thomas Gleixner <tglx@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, debug@rivosinc.com, seanwascoding@gmail.com, 
	andybnac@gmail.com, menglong8.dong@gmail.com, cyrilbur@tenstorrent.com, 
	wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	qingfang.deng@siflower.com.cn, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sat, Jul 4, 2026 at 5:02=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> On Fri, Jul 03 2026 at 20:28, Yunhui Cui wrote:
> > +
> >  extern struct task_struct *__switch_to(struct task_struct *,
> >                                      struct task_struct *);
> >
> > @@ -122,6 +129,7 @@ do {                                               =
       \
> >       if (switch_to_should_flush_icache(__next))      \
> >               local_flush_icache_all();               \
> >       __switch_to_envcfg(__next);                     \
> > +     __switch_to_pcpu_offset(__next);                \
>
> Why do you want to go through the indirection of current:
>
> > +static inline void __switch_to_pcpu_offset(struct task_struct *next)
> > +{
> > +#ifdef CONFIG_SMP
> > +     next->thread_info.pcpu_offset =3D __my_cpu_offset;
> > +#endif
> > +}
>
> instead of using __prev->.....offset, which is right there available?
>

Agreed. current is __prev at this point, and both forms compile to the
same load/store sequence. Passing __prev explicitly is clearer, so I will
copy its pcpu_offset directly to __next.

Thanks,
Yunhui
