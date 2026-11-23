Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430726;
	b=zuJ6m8k6j86iVfilNYymhTXIjw/MV+6bP/U/ZydxEpdQjNzHTBFpIlqXPMfdITXGKv5v
	 r5GIxq11dvp0faPnwAIXkXlQklfV+7RlGi/avopZvxHU4LY0Yvb6FCaD4rb7hYl1zTaBc
	 LGocoTgUQDa+JSIiNRnLo3YeQf7gWwiXwtZGH8PEcQVSwKrkTuIdlGoqdlfWTnAHzJnPI
	 5/kFlGIwxz+wAuIUlQwQytfJAP+V17oNDC4FqwVJ5ASYwmEEH5ogJu8mMLwfin5poEav0
	 TUFhpSox42u52bjEDc5etK5/GUaXPUsF8E0PD/AdeOYobJSai1uaX1XcWwxI+epPo7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430726;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/qPYmDvU6/tNYx5q3aQ8plRWWnZskWOlIWsw9PX0tvk=;
	b=sr6x+6tA+2H1JzuAyP9cLXZLxyLLRbw4GABlDC6aGz6INny+HDtm5sa+qbqjOyRvb9pG
	 OiQ8patqrd8WY2twGB2ePloK9vxrdnp9AI5RE9LYh9nLr/fJr9m5jOEi4MlCKoZdnO4eE
	 oX5Hkd1RCcsF30E0J6/HErtxwgcM7FiZu91Hd6h4730ILawj4x6etnda3t7pkcWTHRDq0
	 6QF8jYRCQYIS4ZQ4ib7IWHO6dSo3SNpdmtV9pNliT1fjuoHoDfqfjBlUl02x6NnGTWZT5
	 0AFOUX0TYz467/vry09y85ipr3mX/Ali/eD55NkRAl8O1Xm5BRqcfFk155Kf8euaqqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=TDY5wph7;
	arc=none smtp.remote-ip=115.124.28.50
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16844606A31A;
	Mon, 23 Nov 2026 10:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16844606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=TDY5wph7
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795430714; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/qPYmDvU6/tNYx5q3aQ8plRWWnZskWOlIWsw9PX0tvk=;
	b=TDY5wph75b0CUpz8TLBqKHs3xYNAUiJqPNbnSkkv7rdH/wIvQvLacDGDgMlM2XcOlf17ecSZs8KUiA8VYVZzGfCCp/wl7+LnVWMqWvzgJuAzll6i7uYsATgeud88dfvNLR9PdsWtjPv56tqLNnUNYFsh2SqbmGNoWOI8dAEFavg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06318961|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0252662-0.000486688-0.974247;FP=15535778311839784065|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.k8JXEr._1795430713;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k8JXEr._1795430713 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 18:45:13 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] asm-generic: bitsperlong: Remove the disabled BITS_PER_LONG check
Date: Mon, 23 Nov 2026 18:45:12 +0800
Message-ID: <20261123104512.58227-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <423ac235-513e-4850-ba1c-5fe98eb2b294@app.fastmail.com>
References: <423ac235-513e-4850-ba1c-5fe98eb2b294@app.fastmail.com>
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

On Mon, Nov 23, 2026, at 09:08, Arnd Bergmann wrote:
> I think the correct fix would be to stop the x86 vdso from including
> this header. The general rule is that any VDSO code should only
> include headers from include/vdso/, but not include/linux or
> include/asm.

Thanks, that makes sense.

The compat vDSO ABI difference is valid, but it should not require
the VDSO to include this kernel-internal header. I'll drop this
removal.

I re-enabled the check in a test build to see what actually breaks.
On x86-64 the vdso32 build passes, because fake_32bit_build.h
undefines CONFIG_64BIT to fake a 32-bit configuration. The failures
are the realmode build (32-bit code with the real 64-bit config),
and the arm64/parisc compat vDSO builds, which include this header
via <vdso/gettime.h> -> <linux/types.h> without faking the config.

I'll investigate the include chains and look into removing the
dependencies on include/linux and include/asm before revisiting the
check.

Thanks,
Fang Xieyan
