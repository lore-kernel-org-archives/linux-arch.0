Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794203358;
	b=gXunGvApiMLeC+iOhicWipjCPsMSw8X6Fo/0u4ZBm6TkWSBHNbe3bR6t8JRrnYEkHIfH
	 9SU/5c9d+FhOUWcJslMOSy+egbov+6G/ESIP0Fuq0YZXlVA7ufeUj/skBOJan/v/KHk9R
	 Ic6EGftDkGsTQSGKHXnJv3+ushNZWAdrQeTCOVusqbw5gsdiXByoB25ssUCXFmFaHTyv/
	 QSpQfoWQaVMYwExkH3iVcVg6vuvBMjYAwiv5IDv4udexnMT53no1aLSOLSsPDnI0/3QJ/
	 7M66AM4fWvJsplj9WM/kmThQ431cOD2F3POuSpfE5O/uduXc9tJTwV2cxBr9Z7NU5Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KffYBetHs8Ajm29Uu5eM47VHa8AaiRvO1sJNqwagpnE=;
	b=Mfw19mp5FYtdi7aG7XLT3jvbdqS/U58IOto7ssxz7cgfEiQATiyg656MEhk5CheqcGaW
	 bvrX4FEFxNDl6F4mlsI22AqTZG6XNHKCizUw0dgOE9ace3Y/zy8J5ln/Kyg7G2kjuM3ZP
	 lE9cE32cLNCv4sUhFL+n7YgduwbmYntI2lWDTdhNzBTewk12dDu98VQid5lJmjUOVxAMH
	 GAARfz/jPtlC2guC3Hr7QgvhAzsNlAIO/1dINyCIcMSfUCa8zy8yic+YPS+7lxI3xGfOv
	 asX526dQccKDv+aVktYX9NetKlcCv2PqBL+FgvGhQvdSUCgVZW9ltawcxHuzyfy8mDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Rjb06pN7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FDF606A333
	for <linux-arch@vger.kernel.org>; Mon,  9 Nov 2026 05:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01FDF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Rjb06pN7
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6dd7070699eso288451eaf.3
        for <linux-arch@vger.kernel.org>; Sun, 08 Nov 2026 21:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794203357; cv=none;
        d=google.com; s=arc-20260327;
        b=G3Wlh3IVyrUDQ9Z64MWdK4D2nQxZlA54UctATkLGYl9CNYiMh8leg7qqnO1BZ+Rkop
         xBZ4M1O0JOIjkR7UZGU1G5/un8K9ckVK+oPyS3CIGeuI2MfQzLKCzM2m8W2j9jMjTl/f
         Zj6xyZF8oW+p1HE7xM4STeD6OqQdzpwu0BAv5mKd00XpGdmB7jhJRcRG2sM/xpRt6cj9
         47GosQ0D7hRD5EMa9WSGOtil7hX2hkVIuSlKgjo8zbCj2sRe/C4iAXP86rs4tCm/LN6a
         AGhv1p1iCRKJ4MA0KXM/LNCmwuz9d8PaoGMKrd8gpRI7SgUX1+7BvNfiqo2aXvYc2wgb
         UpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KffYBetHs8Ajm29Uu5eM47VHa8AaiRvO1sJNqwagpnE=;
        fh=17HWo3skSIvmpBihKJpKG/xt7s1NZfwIZSwndKbrvpw=;
        b=IUedo8oO7up3wSI3fuGTn7XZMfv0HJSByPqljm6FL33POgzK0cAnI4/HCH9GU47aIt
         KwSeUhQsfXWc32xti8GJbrzFZBTDV3jG1G2WfD0NGChbHiUsQUS4EGFRO0Rx11h89UEL
         f6Ahqg0uE7ZRr5YYtFe//RK9uI4c4iOBhZ2Sfc3ikOaSn6Q9a/MyTMoSH+ZvJrvH1TxY
         GLlsTZ8e8Wt6hkKCuOpfkwn/D1Qpl8LHGbwpPF5GezRjteV8cDtRKNteB4Q5nPw9cU4o
         BgWORrXYnApjAvHYv2gqClul468oyecfKHWZ0sFsFIHJ7YOXucx9fCAp8nFFAAoZNdcF
         Cc/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794203357; x=1794808157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KffYBetHs8Ajm29Uu5eM47VHa8AaiRvO1sJNqwagpnE=;
        b=Rjb06pN7tkLtuxfanMFZD9AD+eeWrYx6u0gYZZKGAt+gHGjpHDzqqY9Hk5f/gUyvhG
         iFMbGnLWPE8t51PF7zKyhy5E6SD4YPngK/qrL9lo7bYUDivK0RaqD2HFsmEDhXLNvPyu
         FC4HcZftjwlG8NyRos8CyoCZG3h27tk6DSnJC8XH/bfL4O1ceJqAYT94EL4wAU3SL68o
         bKpHDFXNdhx4CiWxKm2UbDfM8N8Zr3GT36VkzZuFHTi+kR5eiMFCC65Vr+Cb2NwmJYtC
         MOo1skP4gTONR174efquuLLRTp/cXyE94lHEh15qzFyO5JarLkNNsBBgeFSnGiy6GW87
         JJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203357; x=1794808157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KffYBetHs8Ajm29Uu5eM47VHa8AaiRvO1sJNqwagpnE=;
        b=w++YYwQgBzwTSbcw9ACzogBq1Rzum02ux8/P0ZYD8L73BN/YadGMTMJcCka10vmjXN
         38xxlzGydxZp6M47TgzHyxdOH2GxwiQKIN6jUybCO8S6Ziw69F5u0FidDCalwFzup+5q
         E0KcG0cR9cggGbZBpCNnMKeeLbM/njy5DxHVQOpzJsXSMPmq268dZrsX6VoN8l4Bhjor
         1FKZWwg4+vcg1saWFfp1Dk1BzDOvQV39fBMNr6Vr3NecY2prYxkbc5d3gVrYr1RcOpt1
         NLLJVSPM4gX1VCXuZ36uU//OXx5Zdl7bNMLk3CZyXSV2w7SIpwN3lFX+SzX1YMSlb0Bg
         hMIg==
X-Forwarded-Encrypted: i=1; AL+hErG/qWZWgOpLdv0ZCtoAD+GY+baGU0BUxJqlDE5U++EBXD3yKT5+0lnrRgwysg9jsRSp9CzWiW80YpbE@vger.kernel.org
X-Gm-Message-State: APuU4Z9sMri1B1KHDCmnFUxti8Gyz4gnV5/CCGS6pGebYZQQCBbP56oc
	v35DYXPhT3yuF2IYOue3JrtqW41BSq5XeNM7ZXR51/GO3wehFMBU0cYduY4VT5ybk0UQDH1gajm
	XNDWADC4FxRnmKfub28LN/yMdGaoPn3CrzQb7Sh90Mg==
X-Gm-Gg: AYBFou0EHdvQ9I0NIA578LMJtkdMEWm6pwMgN/MTjMYwrBnrjMqhVd61E2K70akp5z0
	3nZ6Tnt8d+bYhT32DVMpRYhQBbdVUh1dB+fuCtiukp9FnPPX4osdXxjsdZNUQhdShV0uqqYMTnN
	/oup4K0LvDRfAcZIWDs20OMeDXR8oJWNILnaueiud+GMho90bJ6uuywtyD5HTzyMiaFIUe0QsKO
	dCIdw/1PJy8JcuKnXnQKPrdr3AREdGhYVYiDjYyepSzZjqI4tWalUg7wSgap9Oj2pfPi9L9P8ci
	v5oWdhQQTlQvaSr+iYDuDyHUQWn36bDyNWkhKP7jNK/71LZqXRkhJeg21rTs39fGTktyxibcNae
	yuV5NvTC3OP35UaZkVwRkVXKdtpR4CMz5JARIRjm919U=
X-Received: by 2002:a05:6820:160b:b0:6d8:bba5:6589 with SMTP id
 006d021491bc7-7170f303df1mr1702563eaf.48.1794203356632; Sun, 08 Nov 2026
 21:49:16 -0800 (PST)
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
 <CAEEQ3w=5QwwvMJFJkpS51APoBjhed6oriCkvcieRdUFWrKtmSg@mail.gmail.com> <avFN7LbSK0q1gsB6@xhacker>
In-Reply-To: <avFN7LbSK0q1gsB6@xhacker>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 9 Nov 2026 13:49:05 +0800
X-Gm-Features: AclHuK-yA93Gg5bVt8kCNssew6sQnM_Z05Rmq56zAts1z3WwIhtyQX6D4YptSkY
Message-ID: <CAEEQ3wmViZNwxXr8q477yHjtABStEJecCHS8=5s_UAk1hYgyfw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/3] riscv: implement this_cpu operations
To: Jisheng Zhang <jszhang@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, 
	cl@gentwo.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bjorn@kernel.org, 
	pulehui@huawei.com, puranjay@kernel.org, thuth@redhat.com, 
	ajones@ventanamicro.com, ben.dooks@codethink.co.uk, rkrcmar@ventanamicro.com, 
	samuel.holland@sifive.com, zong.li@sifive.com, conor.dooley@microchip.com, 
	tglx@kernel.org, debug@rivosinc.com, seanwascoding@gmail.com, 
	andybnac@gmail.com, menglong8.dong@gmail.com, cyrilbur@tenstorrent.com, 
	wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	qingfang.deng@siflower.com.cn, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, dave@stgolabs.net, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Mon, Nov 9, 2026 at 12:57=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Mon, Nov 09, 2026 at 11:47:43AM +0800, yunhui cui wrote:
> > Hi David,
> >
> > On Mon, Nov 9, 2026 at 5:33=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Sun,  8 Nov 2026 19:04:04 +0800
> > > Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > >
> > > > RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
> > > > operations use generic implementations that disable local interrupt=
s.
> > > >
> > > > Implement RISC-V-specific this_cpu operations with preemption disab=
led
> > > > to keep accesses on the current CPU.
> > >
> > > Have you looked at some of the schemes (I think arm64 has the latest,
> > > but also s390) that do most per-cpu ops without disabling preemption.
> > > In particular they save the pre-emption check when pre-emption
> > > is enabled.
> > >
> > > Basically the code tells the scheduler which register contains the
> > > per-cpu data so that it can be 'magically' flipped during a context
> > > switch.
> >
> > Many thanks for pointing this out and suggesting this optimization. Thi=
s
> > is a very useful suggestion. In the common case no preemption or migrat=
ion
> > occurs, so the preemption bookkeeping and reschedule check are unnecess=
ary
> > overhead.
> >
> > Implementing this scheme for RISC-V will require additional changes bey=
ond
> > the current series. If this series is otherwise acceptable, I would lik=
e
> > to land the current this_cpu_* support first and then prepare a follow-=
up
> > series using this approach.
>
> Hi Yunhui and David,
>
> During the merge window but before rc1, I implemented a riscv POC
> following arm64's preemptible this cpu scheme. Each operation records
> its per-cpu pointer, offset and address registers. Exception entry saves
> and clears this state, and a noinstr c helper repairs the saved offset
> and address registers on exception return after any migration.
>
> However, my PoC is based on current percpu offset.
>
> I planed to sent it out last Sunday, but then I found Yunhui sent
> his percpu series(which is up to v9, I didn't know this before) on Sat.
> So I hold on the sending.
>
> Now would it make sense to rebase the PoC on Yunhui's series patch2 and
> patch3, especially the percpu offset optimization? I can post an RFC
> with this rebased implementation.
>

Given the substantial effort already invested in bringing this series
to v9, my original plan was to land the current implementation first
and add the preemptible scheme as a follow-up.

However, if the consensus is to move directly to the preemptible scheme,
I will implement this scheme in the next revision, building on the
cached percpu offset introduced in patch 2.

Thanks,
Yunhui

> Thanks
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
