Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173578;
	b=aHWb6flxufMA4BNgPmBYeJ6h1Wxhb0Lud4XX3dcZEYXVdPszKQn2CljpjWyrl3EiG7Mz
	 IM0k9qreiIm47w1G8CBXh6+UIVvy1BVMknSiBsv5c83GXIVye9Vx0UJNzYId3oM42LUFo
	 9crAPVl1T0MyDfSYTjofrNElwHLxtq/WMEkTkiycpwHxrBMZkRaWc4lBMg7EItdudii+b
	 PmKYmv8X/5cgnceaE0rOto5eMGFrFAClm2YLDauoqiqMmavGKsH2J+UsIhfHwaseVfDaE
	 0sJdOt0mUz+e/996jq/VrPqKiNhcmKAmswRSSEx2aKwghUvp7IZIxMEQEH3j4I0pd3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2zV+j1o90j03z3/bSKQRAMr2OAwRnzRNXDWN23pKxKc=;
	b=DppY5tw8WEvzq48YojwZ16Rolh6qT+14WFPnxkUOGEdIHiPsLHiRsdPhZcoYGTQpV54t
	 DU6Ib2LOSGLBz+CGkMnD+UVc7PwUna263+VQqvo2EhJc1uo6M4k3RxpvQOCjUtShIft3N
	 ety50Ftz4R7GgU/AwNbIHG8tWAMTXa+Phk3YgN4a5bhvxCZJg7wzUVmRPcd33WtxXLObX
	 DVREK8XS5GxAYz/Bx/CALGSh4fzXkiyPCvVSIj3n15TjAo7vJr5EpyndEH+/JoyEle6EL
	 FSI/rbZrDpmrC5t5UWUEehQH9GwDZismu2MFbw892Ol2jEJ1rBgoh70F8rWlXFH+lnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1thKR+m;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F4F606A323
	for <linux-arch@vger.kernel.org>; Sun,  8 Nov 2026 21:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F4F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1thKR+m
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490d59c3edaso182162f8f.1
        for <linux-arch@vger.kernel.org>; Sun, 08 Nov 2026 13:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173576; x=1794778376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2zV+j1o90j03z3/bSKQRAMr2OAwRnzRNXDWN23pKxKc=;
        b=g1thKR+m3D3E2+c4hjI7QL3t50zazlEow2f3cU3NWSOcbViKGU+bFhuwrFyNJLKhd2
         zHYXQnPFcPXe+OTWCNJAX5Doukw0IgV0+hx6/2omnjkeERyku7Qd1BPmTfG2Ec2vQYCj
         jBrOKkbpvQg6C2Qm/j7T6X8EjF/sd57iirCc6AnfscRPrdsjvNwASYBi0OE8oqXwYdCi
         zJl7umWLxRBDsqPH+gl3WB/UhcHVkpQHMEdZEB7hHpJ+Hv7UTPn8Nlv6LyoVls54rMcg
         mIo87yVqR5TSb6XzD5jEPo2n6Qli47aCR0sHQax0ubMztuUql/507jGMoGih3Wy2gIqR
         MqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173576; x=1794778376;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zV+j1o90j03z3/bSKQRAMr2OAwRnzRNXDWN23pKxKc=;
        b=VXKFHoYwZ/8quPad7HXE2RSvf4sPTZY0c9h89/xgtorQeDLF4QHiqV0a90wPMIsohs
         ZVVG39Q2NwviqiZmzcRb7E80bbzlbiPN6z5RgVNdu10QMd0YmGFajBcXQf7eY+RzVjfj
         9c/caaKDwx4HLp1XzCmcE9hJVMSwy+jA/ARZGvuL25+JGAtAPlO3WrUsk++s/AiX+CsJ
         MsvtnA9pRgc/7GQAdDw2EqKq1G6Pvg7S0hNzCPoFUaHXgx4nP9qT9j2mKCTj6T35ZenR
         2fDjsbAnls7OI7ZgnSpKMWxEuwzlmOvqNEPPglv7Fzh8/b8eZHwvttiE+eQdAohQfHv5
         USuw==
X-Forwarded-Encrypted: i=1; AL+hErFxaCzKpio8MDYL6C3ARsaKNmbTvXbIXjaqa5fX3YM3YYlV/v8eMhaB7cJZxVuPfdQu21zQiKithOH0@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZjgBx8z+Jhkv/RqSYByPSxyqUCdtCleHzMVQlavnomUdbdWYj
	Yz/iIoEAFybmTmJc/PfFfi3q88iCwc83qX9Cs/JltsoKQgA6DN2XvO3L
X-Gm-Gg: AYBFou02LNENwfGo9xu/DN+4sbcQIbAFf5hj8ml6PxQA+6hG+/6SjGro3RNku7oYkNR
	ZVihZ0KP2hlSCfj2oM7tR+X1kV2E9Es+fdCzF10Xm8oKGXA/rBOnf/BitLCLjngVEwgS3F+AbSy
	j0HQsH0TCOIqG2FgmkX5el8A4MKBC4AqzwiT9qMsDOVySBsaeKkJLkhNHdtGyfGqcl56vdnBgyJ
	lL4cRziOP2SeXUP+6JfaeS4QN2UT0EXjqr5erkaXRVttlJg6qf4lwBNQ+pedzNWH9fhpv41C6O3
	9kavQ04HLh5VbwJDQmkrMkHNfbdrfhQotCjIlAEVX6mlCXmcx6ShYnTst3PAyCMaFJ7r/Fw8Ygy
	ssR/fcX5haoqRooJOCwRfWK/jnHhpEshS1djGJllHZVsahIDpRSZn2qiyaIP1EWEAfsxALPd8Ar
	0vrJjvgtW3wb/VMaKDbxoAKzCKZe58XnU2ze6o1dUN+KZfVYHl+ySk61nJH96Kg88GxsJhFi0Qy
	G8S9MnIUSgwltg0oRI483HVVyzg2mw3s1sok29G3UUDCQfVmjFGXACXbRWKHEnaQN+Zs8yQ5/Bw
	wK2tkTgUxQdlWD4LsjB7NBVUHtfOiKX2zOmQg4aWRlacbyc9jJFrUfqtfaoWPiMg
X-Received: by 2002:a05:6000:26c8:b0:48f:bbb5:61c2 with SMTP id ffacd0b85a97d-4958852d3b8mr5479500f8f.4.1794173576292;
        Sun, 08 Nov 2026 13:32:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597371cc4sm5861840f8f.36.2026.11.08.13.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:32:56 -0800 (PST)
Date: Sun, 8 Nov 2026 21:32:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bjorn@kernel.org,
 pulehui@huawei.com, puranjay@kernel.org, thuth@redhat.com,
 ajones@ventanamicro.com, ben.dooks@codethink.co.uk,
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
Subject: Re: [PATCH v9 1/3] riscv: implement this_cpu operations
Message-ID: <20261108213254.67805ef0@pumpkin>
In-Reply-To: <20261108110406.97495-2-cuiyunhui@bytedance.com>
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
	<20261108110406.97495-2-cuiyunhui@bytedance.com>
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

On Sun,  8 Nov 2026 19:04:04 +0800
Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
> operations use generic implementations that disable local interrupts.
> 
> Implement RISC-V-specific this_cpu operations with preemption disabled
> to keep accesses on the current CPU. 

Have you looked at some of the schemes (I think arm64 has the latest,
but also s390) that do most per-cpu ops without disabling preemption.
In particular they save the pre-emption check when pre-emption
is enabled.

Basically the code tells the scheduler which register contains the
per-cpu data so that it can be 'magically' flipped during a context
switch.

David
