Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453720;
	b=EKMIoynehm7F+TohzlposUiWOhzgPWDqj298/ac0Zjg7q/OOWXIkaV3ddcgz8cpSnFSl
	 4PoTUiZaCi0EIUawVabRtEQaSyrK4cUwp9ieGAR8pki7zM/uOzaU8ad0xZAlmNXZVO4Ac
	 mFuO0k35vSe26FRuUA0oBZXIH7zDJu/CSj0vPjrogwQJo1RSB16wai7a7vlu6MSECgq9i
	 95Alhe8/LxqgxZ0YaJC0HUyS9620BK/2hO8EIQmwW4fqoWUiw1lBycpTGg2Tk/3L8jwar
	 hAyWL5SSDMsBvatiC64ol35Wu7BwrLU38ayySN8tli1vvWE2gXaTCZnNC9/jdmt21kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453720;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=cL9vBT6ZuL5TOgkTGtoE9gmW4pTirVtFcsIhcarMIcI=;
	b=ADSz37TASvM/vMNLzur+HpfqS6OOMrYLfCdV6AL1a90fGi894ljRKInKyyY2bdbrfHmn
	 GSiiNzi9BZ6ayM4Yo68AnSDy3UItyxnJsPpY6eB4VNW25GWCK+oVlrRhcGNzxqe2pCFHS
	 1uBpwm2fAi2brbYV5TRyRfM0da4R55yIfVODGDtI4hXgiILWvTpN/noCGc2eYFEfgHUa5
	 NiAuhPynZc9QyQLoPdZB7yu13tKfRi4/+rVmQcA6dMYO7AsM7S4daC8I8NTvMhiREaUa/
	 kjixjqc+QFMZmaAyJcieFMHoGW8L/HPFcGGqeXsg7z/ptrEcnml4n3mCsykKBZSAylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=vYMFvyC5;
	arc=none smtp.remote-ip=115.124.28.197
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D4606A331;
	Mon, 23 Nov 2026 17:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E69D4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=vYMFvyC5
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795453715; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=cL9vBT6ZuL5TOgkTGtoE9gmW4pTirVtFcsIhcarMIcI=;
	b=vYMFvyC5LQhBHQUZaiwLpCvmy1jHM9/4Sp7fkrllinfgm+eO5/+Qo1yuMSY0rInP5SsCf9GTEMqRfpwdMwtfaENRSeoCl/uEFyOEhE/WhTJ76cXM+MwlYsvcVpvQ34X4jwSf0qSUm6/h2nY3//YIK/sECLTq0+JACsAS+V4fV+k=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1320586|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0317077-0.000739525-0.967553;FP=6287656475449986165|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065030;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.k8X3lp5_1795453714;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k8X3lp5_1795453714 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 01:08:34 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: bitsperlong: Remove the disabled BITS_PER_LONG check
Date: Tue, 24 Nov 2026 01:08:33 +0800
Message-ID: <20261123170833.30158-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261123104512.58227-1-fangxy@xiaopeng.com>
References: <20261123104512.58227-1-fangxy@xiaopeng.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Arnd, Thomas,

A follow-up with the build evidence I promised.

I temporarily re-enabled the check and replayed the exact saved
compile commands for each x86-64 build scenario:

  - The check fails for 23 objects in arch/x86/boot and 12 objects
    in arch/x86/realmode. They are compiled with -m16 (which uses
    the 32-bit C data model) but retain the actual 64-bit kernel
    configuration, so BITS_PER_LONG is 64 while __BITS_PER_LONG is
    32. Both paths reach the header via <linux/types.h>: boot.h
    includes it directly, while the realmode path reaches it
    through <linux/linkage.h> -> <asm/ibt.h>.
  - boot/compressed (-m64) and vdso64 pass. vdso32 also passes
    because its build force-includes fake_32bit_build.h, which
    undefines CONFIG_64BIT and defines CONFIG_X86_32.

One correction to my earlier reply: boot fails as well, not just
realmode. I missed it because bzImage is only built after vmlinux,
and the realmode failure stopped the build before boot was reached.

So there seem to be two separate issues:

  1. boot/realmode: 32-bit C code compiled with -m16 while
     retaining the 64-bit kernel configuration.
  2. vDSO header isolation: the sanctioned include/vdso headers
     still include <linux/types.h>, and the <linux/types.h>
     dependency chain eventually reaches the kernel-internal
     include/asm-generic/bitsperlong.h. I verified this with
     compiler -H traces.

Would you treat these as separate issues? In particular, should
the BITS_PER_LONG check be scoped to native kernel compilation,
with boot/realmode handled separately?

For the vDSO, would you prefer VDSO-specific basic type
definitions, or a sanitized subset of UAPI types that can be used
without pulling in kernel-internal headers?

Thomas, is there any ongoing work in this area?

Thanks,
Fang Xieyan
