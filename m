Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793082210;
	b=W3pGuH+Xj5ucTxnAq/rMG447w1MGsdLeLmd9WwA8146Jd+/y2J0Aa8Hz8vNaYKz+1rUl
	 fQgdqJOuFI4DRejNnloEeX6kkTkb1X/zHrnZTXZ2jI5QRH7UOZkbQNfDoTpzYbopMhibU
	 qwScC+4nkD1dAlXBfcJ6OnLFqVMXG6IcjHKuFQ1FhlbD4w0QnxNyQC1cz9473Qv1gpfiO
	 dSDEFDd4gDDPZ60ePZMwBFiTQZP6zERA+nAt+jTfmBuNAg/jzj1PXOwr37wSsV2B8NP36
	 c0CLFBo5/EHkApXqMuHKOTXCzSY/zhLXEGJAP/gdDUlHYjKV89zQib1lsxvP95sBB0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=guyukti375rN/eihk6UHSsluUVJELWfWYCk6u2XF+eA=;
	b=1hGRaRb3sZKSl+VMXZPEeCZLR4b1ERPCMswFDFvGLSMPkgfj94d4qm2p2NuR24e+cX+s
	 7HP8P9wccTJ8smE8ossCSHlG69SXHIzWSPeBO47Rfo8RhxUCU0Z+dLhbARiDSHm+/iSle
	 uuCDr2+hCejvNmNBymd1cK23kvBVWjZRyesQJDKigQadS4JCLPseUw7+6CimwIK5GApiz
	 Ec0iBMFsJ1H7LwPRYoYBVGDiiMfjmZtWKCXSfQD3waSWpZ4qLntTf5lPI/U7XPoagXZmQ
	 MzbJWbGXr1WyBGcZWIPm+uwzWigazPCkPlT6+Xj6aVMNw+Y3vbBxi+gEorvhAlrkOPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TkO+X1UL;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C7606A31A
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 06:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 482C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TkO+X1UL
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea7190aea1so17237685ad.1
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793082210; x=1793687010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guyukti375rN/eihk6UHSsluUVJELWfWYCk6u2XF+eA=;
        b=TkO+X1ULDp0O7whIbwZsbdg7I5KrAYsg+syGcfRkP0AqvTyaawKMXTBWAPX9XyCg1X
         UceIuc1WmhjQgxO8573QS+H1Rmi4Aw8++o7/eTfeW4TeSWSKd95vS/Y5+1IEpDafBAcm
         ghM16oe+e9LGfbty4VbwHmNSr2n1bPN3qY90y54OO3ApUS++NH1+5qb4d1pZnK9LwmG4
         ogEpPx3uifjYUT/7GjBY8OOCXWOFH/wgfMxICAgKweWinCJOIRNU813YpyIsxvzW0Wkv
         OlGopdQ94ZDS5TpELP2gxTk0R2DuDJPulivXAVM6yn940klNLoHX4K49u25JqVRddh/Z
         Tycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793082210; x=1793687010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=guyukti375rN/eihk6UHSsluUVJELWfWYCk6u2XF+eA=;
        b=0TdDC2vjoM0g74Jw4axN9bi1T4KmXJYh/3ELey5qUdhTvCaqGWxXWSUYj1Poufuz0z
         F/G5cKMj0SegY3Ul3ereWCTGN22sff+0KV817dsDF3N96JDII0rrRGeqn/n99LxEFbMG
         /DYfkTE2U2ix8mVsZAs2mZBwyG61jCv+8p5H5WV/Huy7cdPfjHpeWqhyMbvXkyjwEqFC
         IOrcL6w84AhqWI41Vx9VHkhxceWrqr7WlS69BIDrkT0TdobGNC3FsgL3mX7aRKR+Ztkk
         L4QriMfk+cD0GtNtg+8MbaQdx6vCKkkslU0ZMESqjbGdaAPvTeuT4TtTR1yySUg+LLxv
         oexA==
X-Forwarded-Encrypted: i=1; AKwUvByuAii2IXb04vl7tH3Qp1JieWJkGXV1TGBSUPzMat+b+v4KyeHhJHQffGotbF/OhRqL22gBi0M17Elf@vger.kernel.org
X-Gm-Message-State: AFq9FYITa6S8dM9TZ8jkMo8MNXVTpRzh0rrAQ5e4bsgJ107ASPU72GZr
	4IKEK21fCVmxihIQcsdf6KVR815n6q8u7yDOpVvje9uTlz1qk9qszkgJ
X-Gm-Gg: AYBFou2xDrgONMW/cvfRiMh8Hn42gAVA6xoub/cfC/lGXquNIS4LjhYW0nhlop2Gsr+
	ANdTOyvkVURjIGUcc23NP2WTJb1agAsOkQQHAPVREftPIe5tVbaz9IMEJZOGAIuqqGCSBFYvnM3
	fh/FfzvJADqIr515uCmlUPBVywBWEFRdEYGYOKMI+m4aR8FAMeT/Obw+VhWkqM/3Id+w+oMzlx0
	1qUXezw01/wEF711Hl3vxyqTSdUfM/E0MrTKd0swF943dGa413Xp7eALt0H6QE2lZ8eacm5+XpA
	X3yd7uoydaSuHeqhRrKzc7rZCzB6U0JguY6p5zlpxVIXjTidSifJPomYnaRCcoXXDFB6QrvoLiB
	CNWU1Y7QAHCJMdX0oMk5++rruz9op65dsxutIo/4lcJTf8ooP8g7CpdH+rRlJnzNBcb+lejRG9t
	fW426setFpvy8GE/kLQUhO8zn7QyenwRwdwwlP5z7YU3s+pj45IwYW6DuxCYQRSZD6YDlF1ym8/
	eS6sGKzBufV8xJt72hBXqDq3cgtJNzJZv2DyqOIXBCgidvmU0R75zS23v0DwD8iEsx8Wr+LKMpi
	RQRoRg==
X-Received: by 2002:a17:903:1acc:b0:2e9:7dda:bfce with SMTP id d9443c01a7336-2ea9c968527mr61960135ad.74.1793082209412;
        Mon, 26 Oct 2026 23:23:29 -0700 (PDT)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce5912sm4083925ad.71.2026.10.26.23.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 23:23:28 -0700 (PDT)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Yury Norov <ynorov@nvidia.com>,
	Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: bitops: Use the compiler builtin for __fls()
Date: Tue, 27 Oct 2026 14:23:19 +0800
Message-Id: <20261027062319.1700461-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <atuBH6-LHueXYbFy@yury>
References: <20261022115922.1210342-1-shingekinocore@gmail.com> <atpm00m6KYhXo6Wi@yury> <20261023140806.1367050-1-shingekinocore@gmail.com> <atuBH6-LHueXYbFy@yury>
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

On Fri, Oct 23, 2026 at 11:45:35AM -0400, Yury Norov wrote:
> While waiting happy, can you print the bloat-o-meter results, and a
> couple listings of the code generation, including compile- and runtime
> cases.

scripts/bloat-o-meter -t on csky defconfig (CK807) vmlinux, GCC 16.2:

add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-196 (-196)
Function                                     old     new   delta
fib6_add                                    1634    1630      -4
build_sched_domains                         3948    3916     -32
skb_try_coalesce                            1766    1606    -160
Total: Before=4621444, After=4621248, chg -0.00%

The same with GCC 12.5:

add/remove: 0/0 grow/shrink: 7/6 up/down: 94/-330 (-236)
Function                                     old     new   delta
__netdev_alloc_skb                           304     338     +34
skb_ts_finish                                 34      54     +20
skb_copy_bits                                608     628     +20
skb_release_data                             354     362      +8
kfree_skb_list_reason                        280     286      +6
fib6_add                                    1632    1636      +4
ipv6_get_saddr_eval                          424     426      +2
_find_last_bit                                86      84      -2
build_sched_domains                         4292    4280     -12
skb_store_bits                               622     606     -16
skb_abort_seq_read                            54      34     -20
__build_skb                                  116      72     -44
skb_try_coalesce                            1560    1324    -236
Total: Before=4333762, After=4333526, chg -0.01%

In both builds only skb_try_coalesce and build_sched_domains change
in instruction count (GCC 16: 524 -> 466 and 1240 -> 1228; GCC 12:
476 -> 413 and 1333 -> 1327). The other lines are not new code. Most
are literal-pool words (the constants that lrw loads) and their
2-byte alignment that moved into or out of a function's range:
__build_skb has 24 instructions and 11 pool words before, 24 and 0
after. fib6_add, ipv6_get_saddr_eval and _find_last_bit each call
__fls() once at run time; they keep their instruction count, and one
instruction changes between its 16- and 32-bit encoding (fib6_add
also gains 2 bytes of pool alignment).

Over the 35 defconfig-based builds (CK807, CK810, CK860, some with
KUnit or SMP, GCC 9 to 16) the bloat-o-meter total is between -118
and -318 bytes in every one. The 128 to 320 bytes in the changelog
are the .text change, which also counts the padding between
functions.

Listings: a standalone file with the old and the new helpers from
arch/csky/include/asm/bitops.h, built by GCC 16.2 with the kernel's
flags, -O2 and -mcpu=ck807, plus -fno-ipa-icf so that GCC keeps the
old and the new copies apart; objdump -d with the addresses dropped.
The constant listing is the same with GCC 9 to 16.

Run-time argument: 4 instructions before and after with GCC 9 to 16;
with GCC 11 to 16 both are this sequence:

	unsigned long f(unsigned long x) { return __fls(x); }

	ff1     r0, r0
	movi    r3, 31
	subu    r0, r3, r0
	rts

(GCC 9 and 10 put the movi first for the builtin; GCC 9 also writes
the asm version as ff1/nor/addi.)

Constant argument. PP_DMA_INDEX_SHIFT in include/linux/mm.h is
1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA), which is
1 + __fls(0x40):

	unsigned int f(void) { return 1 + __fls(0x40); }

	before:
	movi    r3, 64
	ff1     r3, r3
	movi    r0, 32
	subu    r0, r3
	rts

	after:
	movi    r0, 7
	rts

This is where skb_try_coalesce shrinks: netmem_is_pp(), inlined into
it through skb_pp_frag_ref(), uses that shift, and the function goes
from 12 ff1 to 2 with GCC 12 and 16. The 2 that stay are
__ffs(PAGE_OFFSET) from the same macros; __ffs() keeps its asm
(brev; ff1). build_sched_domains also has one ff1 fewer.

Thanks,
Tzu-Ching
