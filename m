Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794196082;
	b=cYgItBaPzJjeLmGI4HhjD/n8zpLQAeOHiuBldhFhEeo4eKFPmGFJPX2vEG1PF0azZymi
	 fGAG79lR0XNS7a8CpZ/Ifujfl8cdgWrVYQ012UxkykptY6s5LnHZsZX3ZjTKMNXpclSmR
	 OEtCZYtx0tOSy3Enfj81mf3m//QMj6lEK/oxp60vAQDX0QoQY5rg1zwP7XMsNPEK2xjhY
	 WHXH9TpyeHxVdkQya4YskrR2qAlsSqc7q+KzteOw8cZBG0SUS3o+hKhIO1TEinq3vJulp
	 h+Cw0Jtgn6POptm5dAaQD5HaUpDs/iLcRpooI97bGeVjzXByFtT8s2+gx2brh5EDlYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=02Xm4AXZtFCOeYUfXGvoHJuZWiU3qVVXajNv+02pe2I=;
	b=TiP47NgyHcIKzYczjAXimnNcOyu1VK4PPWAzCPkjKMRnPjCHOXL+dta7wigzqCzcH4Sn
	 ITJcQrIjOFy0VoaMtW4PQea+EGIodN1gohjGBnYW1v3ymhgTqiHqHXlGxtDOqdjBbDJ2w
	 DanVdauOtcui58/xBUfUDarPP6F88/uLzCmOzODh3+nx4rfuCBsfIm03zPeWvh26H53g7
	 pcWXfbtI0gsoCMgf9Ie/qm8XANfyyMs0gw3WfPZRPTTjwP6zOcFOVpo3HNOgvDFJWRKEW
	 QbrxSQspssoV5lh0W3Gdr4qrrJea3NCRsdDr3+0MRzGMwfjzbGuITmddPfznAtu9e9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BRK6lVn6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3B606A325
	for <linux-arch@vger.kernel.org>; Mon,  9 Nov 2026 03:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A3B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BRK6lVn6
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-85c1135c286so286034a34.1
        for <linux-arch@vger.kernel.org>; Sun, 08 Nov 2026 19:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794196076; cv=none;
        d=google.com; s=arc-20260327;
        b=PpfhyBbJjnuDORKvfmSY+h9vw8HJxnEb19TTAYnWYowsfRxIkNH4r9dvUMVvx2vWSW
         0Bno6TWrSU+1RaCSMzzzRTn9/+UvyARS1J57U9iMEXDoFmntPufDb05lPL4eeyC3I4Ea
         JKSovyhNeGGo7j8MXfIg5ZdpyfsAc6NGzXHTcKX5IQ1exxS1lwEx5Y2tRhd7tTmd7GPb
         OuGZRjpLI/U0e3T4fyILx5yYWsUZts/iHklsSs07HS4wSuvrK+j7M/tRfzZFcryQrSBI
         jUl3J8tmX7L8y72i9KQ8tpXS3ZUW7L6d4/U58GdnYUuQiLhLOK7EjSDMtFMsJsb1117S
         2bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02Xm4AXZtFCOeYUfXGvoHJuZWiU3qVVXajNv+02pe2I=;
        fh=mix/NCC8clU7MJSlhHLrgMFRGatpI12uKDnCLUB2mMk=;
        b=Ll+4XKU3FDI/f3eYiaPkyY0MxOBE9rrqqWhM7ELsXzXkZ3hkhKO0fwYa4gQLjWtNVH
         07kmpvsWOj6IKlsPfRklZdc/to8rQVfkOuFmNksBIvuQvqabw7ZunBEnzdbo1iAgMwGF
         EJVOntJG/ovKQKQxaeHuzCjO4RBL05AhCpADuO9l4WJ32ojNwCIZJLyeFGOJv3/glXG1
         9WTFVcHNWc+7PKgCxt6R6w7+Is9KcWQwpBYegFAcpvJaSgZhkGeg82pIaLz/wfEsaOVX
         q24K8AbBsBZ6Mqpn6LdwluK24SwV+fLKIkZzsnFVOh0Jk4x95DxyJQ1vPcdMzr1+UEfK
         wGnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794196076; x=1794800876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02Xm4AXZtFCOeYUfXGvoHJuZWiU3qVVXajNv+02pe2I=;
        b=BRK6lVn6DBIhL6CLmwBGU5c3a0fChD+LJ776GTef3sebth8LV/cWa6RewDLR2QfloD
         i6XPg5ZLaEUxhNKfgxDjaJCkeNk8fs4qJubLyMU2BSCLZyrEELPB790zu/svYNIEYZVi
         3o/QiRWXPC8tZXewpeQfZ/1ngVOfPM4Amr17ZpWofEtzZrZAclsRWkyrm2u8RLEVmNJO
         k/16lv17+AO3LzGt0N/wOhx8d2OJ9uuf2zpS5Qz+yvqLdwCl3ai3YQONP7GVOAV/b61v
         liIS9i+EzG4wknet/JDA/2iK5XBHkEsbXmqwpLekwmAWH5SIgvVpSvK2QIAWcUVq8PS/
         N5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196076; x=1794800876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02Xm4AXZtFCOeYUfXGvoHJuZWiU3qVVXajNv+02pe2I=;
        b=sTHK2Mvl1OYrqDDnUCsEElJRFTaBVdOmHAqKr1cDm73FFLWkUuhItOiHIlFfmhDVzw
         rFUcllBqfRbHGA1v0FrjMwwS+5d7wLtMmuDVVIaI9E+CJfgWz3nKWrCcEoOgonezoL4Z
         i8C96Rx8JrcacmqktVhhXG+5yE4yXBIFF4FKDqn6WBnruKX7qgXyaroUej/tjStVDvHD
         9Qj/eemV1Cy4b1chnF2o3yn9cwOLcsg5+1PkvQNDWZan5b0TtZHdcxog2GXntuGDWvNe
         b4sSnSJJoKlJKK6L9yIaiBRPoEuIikXJ/3kjvMyd4qDFeNHEQz/JBgq4dnJCjYyOzQb/
         AUvQ==
X-Forwarded-Encrypted: i=1; AL+hErGzsZdECephE9Ix4YK4U6nlaw+EWNigUGIqY3+vCNZuTmhbcuZKxouKUj+2ktBYQS2S5ajuojPdyVhk@vger.kernel.org
X-Gm-Message-State: APuU4Z9e7oEQr20uEZxl+G1wB0WmOTprDBwaTgc/F6n7bcsYjs3EXphe
	Mvrc8yvz2+0VFVrpMdy/kmT2yZ1HOU3jowbpL38TIwvIDUDdB11tldM5qtCShbqnSqPdT3aV5p2
	smjG9G/8iN7BQQ6cnywVjtE14ypRaU3Trp2qIWPr7sA==
X-Gm-Gg: AYBFou06DCMBOY4lz3SJncsRov1uM47LxVLdyiYXc0x9kmRvb27z8hFGV2h+V6/EouV
	erHp0QmMMa6tcv58ZHfe8tADq7LqD2xhtsXjE8VOESG+JKnQCrajlsbYclLfR3YKmf96DmnRIRJ
	LUqNgoh0qtSZi0xHkVnLUJkp7vKjNJ91vackQI2DvMoNyQ8P493CrNidESqTqU/QV79rNSA+P/0
	g7BgmJJlZwTz7t1fzBKezq+YnoSflY0+F6/oDxZf42yHy5YN9zm4dZTwTJAxm/Z4tCeZFPtmXIi
	6UyjKJfKsMqdNK+zXEHZSdxLI+yxiYDf33a4LPt8OszKuDBJyl8fMGIzdvUqMnKNRks3CKJBfb5
	yrdRsmh0S91xT9tkBVelgZDKVfXW1DsQJW8m4FTbQCn4=
X-Received: by 2002:a05:6830:3115:b0:81e:abb6:7498 with SMTP id
 46e09a7af769-85f5082de7dmr2762199a34.23.1794196075840; Sun, 08 Nov 2026
 19:47:55 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
 <20261108110406.97495-2-cuiyunhui@bytedance.com> <20261108213254.67805ef0@pumpkin>
In-Reply-To: <20261108213254.67805ef0@pumpkin>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 9 Nov 2026 11:47:43 +0800
X-Gm-Features: AclHuK9B61ylAVcWnUjeFJuyJwDuHE_2RuMPKX9QRnbJ_mu0Y53s1C9cYNJl2lY
Message-ID: <CAEEQ3w=5QwwvMJFJkpS51APoBjhed6oriCkvcieRdUFWrKtmSg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/3] riscv: implement this_cpu operations
To: David Laight <david.laight.linux@gmail.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, 
	seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, 
	cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, dave@stgolabs.net, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Nov 9, 2026 at 5:33=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun,  8 Nov 2026 19:04:04 +0800
> Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>
> > RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
> > operations use generic implementations that disable local interrupts.
> >
> > Implement RISC-V-specific this_cpu operations with preemption disabled
> > to keep accesses on the current CPU.
>
> Have you looked at some of the schemes (I think arm64 has the latest,
> but also s390) that do most per-cpu ops without disabling preemption.
> In particular they save the pre-emption check when pre-emption
> is enabled.
>
> Basically the code tells the scheduler which register contains the
> per-cpu data so that it can be 'magically' flipped during a context
> switch.

Many thanks for pointing this out and suggesting this optimization. This
is a very useful suggestion. In the common case no preemption or migration
occurs, so the preemption bookkeeping and reschedule check are unnecessary
overhead.

Implementing this scheme for RISC-V will require additional changes beyond
the current series. If this series is otherwise acceptable, I would like
to land the current this_cpu_* support first and then prepare a follow-up
series using this approach.

Thanks,
Yunhui

>
> David
