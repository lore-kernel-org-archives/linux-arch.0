Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066378;
	b=BtUsS5eMjq+4YKW3kr8Qql+Rno2gxqSKwEXgR4SmYi2a0Qk1NOYvmsXb7mwols09ITL5
	 BWK2bu5CLQiYleSHjDambo9vCTXjbvLoEkL0hARxU37skjLPgxsY8tED9yHoqdb2ITZU7
	 riq9MfmwLzyOWbwDy9zXEh/FPkOkvzkq5elmcWiU7ooOeKCGtgRxugSPY0STJE8UbedmP
	 Zaf6sNJaligSp+ck5fskqhYG1klwdJ7GDQIn3RHIK1bvoMdRLkxIHsrupCovIEWp2c+2Y
	 F8ugHCTHaN2vUakHlU1K83MZR05FHGx983LwHN0kP8K9p1CWlICmKdOuS9Jul4g8sUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2t+AFT2MA2m09XqavALNlhqgsVOoCT8EUnVMwE2LdCc=;
	b=mDTIUfa4qrsRfyyCqgT9Mn9Y/6ZHtmFD9bykaE5xl3R1xCptUfdmYfl8wX/SDL4bGlv2
	 HiIzDExU00ru6D4wqp32hqyiDS3NczNVzA95dcEZCrOjBV6Nwr7PFtTkJT6vDuCvhfO2r
	 5Fddw9bzHHVfRZvADbjCaYZXfzzU8oywmNITQVqYQ3/xSr6aNpVusazxPyrrjvfQMZVvv
	 kAm/E1AB/I7CBVHZ+mkatdplRdUr1lA3VMmW8beyeTIt+W4LkfE+RVmhhJQ3BOquIlZzM
	 RQuV3/8ozhMRlAiNmvWiyE1Jc8T6myFOMLQh2tX9hNOYqxcf4LkmJ1utTmNnQKLeuvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4bHvQfM;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B56606A326
	for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2026 05:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42B56606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4bHvQfM
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1184448a91.2
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2026 21:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795066378; x=1795671178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2t+AFT2MA2m09XqavALNlhqgsVOoCT8EUnVMwE2LdCc=;
        b=m4bHvQfMo1pkxMoHcCCQNr9n7SfiTmpc1LKr7p9qJ4PxkkegxRvXssI19ZGfs/LFAV
         6kk7mSHQfCoAfQRNqOwJcXLuSondiZK9weZ+hi/CK2xPoJB3MtYTAo+2ZKze7eJfvoxa
         gpP1jqivfqclIsEO9pG/s9O/AqSNReHJHtacW/79zulct+/9VOGREHxJ8da2foaOaR4j
         tr3XAXJIVGEj5cDtPosGO8jyNuDsq/Hm5y9mLYH68UfwD/l9mVquywByiXrcbvSJ20c5
         UTVr99bCNOSVUQww0oc3T9o9uZWSge1hpp3DyldseonyBO1PyMHkT0mXXIukGbwt2d7C
         cnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795066378; x=1795671178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2t+AFT2MA2m09XqavALNlhqgsVOoCT8EUnVMwE2LdCc=;
        b=K72oEciwueK9n10OKcuzX6Kv7v04cFg1aIVOfuyclm65PAHHBDxzpULCuUAH0R5YIo
         JoSlymb8eGEsBud1mppHpteituSYNQmEZMUqlBQgSEWMPScQ3VXnSfwQopJen7DRWqx+
         ewVXzr6L7jdPYtNcklZvhHSIf1iC4SUhYjPB5ATo2TspWkQoYLvFvCcbseR2nvghvWtA
         80GaMtv+rkedvIT+BIDDLonJOhnD3AqrLANnVqZyeWLOdSGwYDUOQpwjNY6fY0CQgbQ/
         FzBAbAJLPAJRj6vsW/Yx4IcriHIPhJNVCGkruAri6apDU/dD9S9XYYyQol1nWPt9PlUw
         9ZyQ==
X-Forwarded-Encrypted: i=1; AL+hErEwS9d4gDW6uQ68ToIxrQRRs53wbYjDowErptUxoyrAg1VdYqbYYuESlG2F64S3BAnvCxiUsfSmVaVW@vger.kernel.org
X-Gm-Message-State: APuU4Z9jpK0Otp2bhsyWKQhm87seS1t0Na0s+Y2NbtI+l4g2LY3yMvJy
	dy1+3zxpUE8c73ZAV69QtSM8ulFqcPfyTGZJ2aN1pePIe4Bid74YEGIM
X-Gm-Gg: AZFdTZdkR9Hrr2PECLAipv4WGb9XXYOiLBoTFUJYipuazUHKusChLveKrpOPe9PDjCF
	ipAdCgFke5iRXlm/igXrW8wRnFzf7HuR6g4iV0NMsB6FtASO2GW3nTMOhs6DpXSXTnXc6MrdmYQ
	PtOrS3wPEpfGOEkDqLg3EYn/Mgg1Qxos1EwY9rEJ6WhPddM9L/mpIoNSN3wXnXVKL0DO+dDwzR/
	6vcoQ+rF/t5XEbCaVKqkuK56mi6Ow9bQ5j4t07L8iWI2Tx8OAPcHCwjh4JeJc0j/CoU/a/himRO
	G/ApvUsKAj6kO5ja1EQAomUTKaHCDcuds4OJA0STfsVUDb043Ur/6TITc1T7taAKhTgbDy2Kzr/
	24U0x1iyriUb+5+7yzSpErtAPP3jSSYhhPQ4A+3lN9S/AjC3Sp02pvU+01OBD666xFHHAVnsQZY
	+MYyQ1URyLMNJ4DcqZyyTjc8eb5PjZYwTLshlpNDCc6QHYA9KVELJYfnu/QH/BIjFWdvs0Oa4kf
	VC3Ld90dYnyfLW2/Iyjc1BvuoCnJlWrqmt523az7jclQ8GVZpN8ewmkomhkn5zsTcxXiUT50AcO
	c14yd/VoaBpnXEtRWgCdhAOlLCjhhC9XjA==
X-Received: by 2002:a17:90b:28c8:b0:3b3:ca9e:9e22 with SMTP id 98e67ed59e1d1-3b3d075979emr5015646a91.17.1795066377601;
        Wed, 18 Nov 2026 21:32:57 -0800 (PST)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534aec9bsm1047080a12.22.2026.11.18.21.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 21:32:57 -0800 (PST)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Yury Norov <ynorov@nvidia.com>,
	Brian Cain <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: bitops: use the compiler builtins for ffs(), fls() and ffz()
Date: Thu, 19 Nov 2026 13:32:49 +0800
Message-Id: <20261119053249.2098578-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <av3-Nf01tdGw62lh@yury>
References: <20261117054939.2126980-1-shingekinocore@gmail.com> <av3-Nf01tdGw62lh@yury>
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

On Wed, Nov 18, 2026 at 02:36:21PM -0500, Yury Norov wrote:
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
>
> Would you like me to move it with the other bitops material, or leave
> it to Brian?

Thanks for the review.

Either way is fine with me. If Brian has no objection, please take it
with the other bitops patches.

Brian, would that be OK with you?

Thanks,
Tzu-Ching
