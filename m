Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485377;
	b=kt5elOUeLMKzYykDGiwUR9JgsWKSj3r7arNIfAgLLW9rT4Zld4LR6xrMxPMTcDkMuBp6
	 F1tgJ/QvK3CUnqMXaJ3WIkwUmnxLMFfedsSVls/tr6Mg5IgsqRjaidqWZe/xA2A1gEi9h
	 DaYxWLCHFT0OZ3TWcdrG2M8CVaACGTaqXuTvXcKA+pk9qt1RdOQfdVDoQxvfw6OJvT6Ql
	 O3ML/dLOdKT0FftQK4MV6yhk48kbMtSkEZDjcrv59uDOi3Y+ICIaHN6GD1tq3t/OmoZVz
	 QH1spPGDho2mS4cdh1YKlWw4TLjBXfXo3EBaZRBuWsJZc947AlPDb4SEM3EQ2IovLFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yVXFtg5uv6jmT0ohsABv7mNA4IYkbP/bTmshktkMt3c=;
	b=QB/d6sVV9j5EAhkT0mCJ3I1MC+EZKGsQpwWkSnfBI5JD1qrzag5Fbx5TDCQcs2jKyNCZ
	 eRtVNLNT8OhSBnR95ha2wA2jRixaBVgUZHYqTaq1El4mMKaQdl+az47N1kFz85Wcevs/C
	 oD6gViZBUJOVzjRRul8G9TM0XJ/Ko7OBGukrP8GYmtTnoDElFVqSe3oU1gOcWe/WZ26W+
	 e7JUmv2aB/dSPvhPV/mBK5ACUzreWfy1YAyaJIKMZcZQB3Vh2DIYgy2pzp6342RVKpEl4
	 iibpAs+oQqP9SLRi7MlDzS5y35+rWtFQOdmyx02TP+EyRMCiRrtb33LGwHBkRFf7MHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KnnbIB3F;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477A606A32D
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 12:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0477A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KnnbIB3F
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49412eb1474so2532329f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 04:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794485375; x=1795090175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yVXFtg5uv6jmT0ohsABv7mNA4IYkbP/bTmshktkMt3c=;
        b=KnnbIB3F7KMniAR3dO7X6IyBVbtVQ6tOUdE6/JoML7aE/4n6QZgGrSdiBwUSrQqMFf
         ImyIjubKr2EwQDMCrRkIPXg8JcPztoTDeMIE3QgtEeiOmzRIzrIccGTa2b+I6zMIp0n4
         fvtn6drlA/T/F5B/c7/+9SgcGZGyH9FytYNNC9gE3wSUqSrmT82pfUIE+tkxgKh4Nk1V
         xnlX22vuw2JT4GMm8rea8JCPhMS18lnX4VJg4oyIMZb5hmf32AdsKorEs7gr82QgPDdy
         NfphP+0IvId6gFdVVRgr6S0u3eFgeZV9CFpIiFvn/gjOkpEDIdf/a/ACxQ5nlvlibDE7
         sJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485375; x=1795090175;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVXFtg5uv6jmT0ohsABv7mNA4IYkbP/bTmshktkMt3c=;
        b=f9RYVAH0O+oWfAWLfVD2JIIbAgZEGSsFEj5Vo4Omi5RC21q+Iuz4nS2tC1mvWlhK4r
         AA/qLGNYk09Rh9HvtlouZEpWT36/LfrtOAoQ4XAPjW0nCU8hydqlnQIrDPBhAB4Manpa
         hDfehKStBNsgNoq8u5sLK9PtFcJA0guuLN8+HHckwYx7rclCFK7+KYZZxq4HWsiI/cqw
         WV90eTCDCbzsan/1bTG7kWPRIuRndBybYLiGjLEOn8FEuxRRYZNytMhdoNeTsTq7A6tX
         rggAI0Y+O2+IE8PmbIEMaI8COUXSpb1I8nDjBQiZn4fQ164NGhRvSWnSMjlFu6eEmLbc
         JKqQ==
X-Forwarded-Encrypted: i=1; AL+hErEfdDlCU1nzmX/+FJxIjxScKgMGV/sYSDVa9yTmm5XoToSJusCPpceJ9Fwqj0Vuf4xTT6NYe+s3lu+L@vger.kernel.org
X-Gm-Message-State: APuU4Z8038w99KEALomBwkfoLXCocG4fB5YU02qvSgFYM5aTFPVJme0Y
	KHXQDrF0ls0vDZeE0MaK7MMDPYlPf2uxJ4+JKC0PZaoQCiZYG9y1WATZ
X-Gm-Gg: AYBFou1Y7LG+32en1+pOfpUtoCkBQgbYyLwVsOhXeWO0ha9WXjzUi1yJy1+0B1TS5WW
	6PhlC6y2nCU/1xputtGJfi8Yl8OFAZK27AA73k8WHR9LsjjIqrI+FHBS53wdAwL4uLicmMzf/ox
	VJSakslkQwWN/yR40A+hMH7lL6Gy3sgyWG2FSfNS1EpAq7ALU0rDEqr0EpaHh8bo4hzTUC4ZfU1
	y3Lp9O4p7KRNrZ2hm2GNX3CibjgQEkT0KoTLomNHANiZfeQUsVBPsJ2v4azmgEecQLdMVrNMVJh
	4T82B+BFEpuhsmCb2bfuX1IzewQ8PfzNx/2L9tj0PvA4JE/b38zHFItKF1xS3X6S71TY2J66KMw
	ZhMt+RG5kppF2otEKv5C62pAHV8XAAetZ1zrGW4NjjIoj5WrXsnE4xlol6r4TJpS0Jx4FXc/0kJ
	oMjhSp6MAFSA9s5mnk6PEIORbks2ZDBNuxQahGV6gwXbmF6jfwBc1vIJBlhCyAFsv6NX+rnpHoW
	Inqbv4B4hIHjITReJTQzPcwiguip5k265GHZ6jV3sU9lKqqTs/06LquE/j1MJBGISMgOHeBfKAa
	Zvf1sFAs1GpYfuF4AHDzULUmQJyB3rAofXbTtWGPwbVUspycQtckpSPTiaHUTZQmGw==
X-Received: by 2002:a05:6000:288b:b0:48e:2a04:4ea3 with SMTP id ffacd0b85a97d-499c3aaa3ecmr10258629f8f.8.1794485375130;
        Thu, 12 Nov 2026 04:09:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49895f4e6ffsm15149402f8f.16.2026.11.12.04.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:09:34 -0800 (PST)
Date: Thu, 12 Nov 2026 12:09:28 +0000
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
Subject: Re: [PATCH v10 5/9] riscv: implement preemptible this_cpu
 add_return operations
Message-ID: <20261112120928.24145d44@pumpkin>
In-Reply-To: <20261112104149.38589-6-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
	<20261112104149.38589-6-cuiyunhui@bytedance.com>
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

On Thu, 12 Nov 2026 18:41:45 +0800
Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> Apply the recoverable per-CPU address handling to add-return operations.
> 
> Native-width AMOs return the old value, so derive the new value required
> by the percpu API from the operand. Use Zabha for subword operations when
> available, or a masked LR/SC sequence that returns the updated field.

I can't help feeling that some of this code is the same as that for
normal atomic accesses.
Can they me merged?

David
