Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40FD23505E
	for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2026 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326315; cv=none; b=LL/aN8iEn9DD0qmzo+IN0+Axp/3jZo69UzNpZKPGhITs7JhOIjg57saMmiy3/QqU0bTpuqeSjFDathRZ97bpwIm6BD1G2CRY554iRcaKxWKm+uJ7qd5LJu3iEHmN3FXOGbHjcLNVvAKxnUAk/nO8zOU4VT7OFcquJWfu2r2glao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326315; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUDRq38mC4fStAW+yyja7t0x9qO0d8iGZ9YFc1L6IjZcIIoPwWxz751zpaz8mSQNzZXGAf+8RkY8bhnK4bxnQ97j6y7s1KCtHrw5GsVtWRXm37YURgbvJIL0u+VfRsJbUcnKRD9OzYfiEvmtu2kw3aVkvxbocrAPJQR5XbJmtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ewZzbb3n; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ewZzbb3n"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5632020a12.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2026 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326312; x=1777931112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=ewZzbb3n84A8ZqbXfgaAS6QaQ1N4GgZt6kQVC2lCFDMTBh35xRij4nfN8uJNqL7XA9
         sipnyCBvIaCUpdiq5u0m9j90zmmpN0PjlnX0cKD92NvfBawB8XyNVv6ROfFoYuuwRxa+
         2Q/Gq2XYGgwwHHmD8T5iAin5u/ZAqUwcwQLFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326312; x=1777931112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=EL7n+9CfWQcheGIF/it0mI4WpW4hkyRu3uWpco1QviCe4evXfin55vuoExG7ufoxxF
         JYfrg2N3esOdz2NVtWy37Miu08iix/oaY4W0TswbwpWVWRyG8suSzPVd7svVjR07h8vy
         /MbSrDjTXZC0WlZGmtbvh3koKbqr2TOLWUc6cK6OkIedgVKMa0tk35A2U8JenkLxu3vP
         71Yw+U004pcOdgqIlJYbzPRVzDM9f/H1kExtRO9c0B4Dh+84gR9SKMx2vFFCiJu5w1f2
         2TvnqQAVw0vYwW/o84q4JQQQs/LSy4frIayz2ej8IROehn3LOBdkriCpgXqOF5RoNq02
         U8Ig==
X-Forwarded-Encrypted: i=1; AFNElJ8GC81hYgjiSQVTxq4oQ97BLsqJFlFuV3KNnGGoFGdq9JAdwH3pgDeAlV27B39pQCo15fu4C5+D2L3J@vger.kernel.org
X-Gm-Message-State: AOJu0YzO77yRtvYa6daofVs8xqZYysOaxdXormDaM+YAHU4HVAjASRHc
	1j/6j0hnYzjmCVMD2Qps/BjSA3oXINK4b0ympBchJTgOZ1kzIxP7IjvCbAmbNAeqegVdpUl3AwY
	hxrx9Xdkc1g==
X-Gm-Gg: AeBDiesMSN9jjgPeiwEaGOwNPxeXeYOjW/lhe56Xol/sBuXKsUE82bTqMPA9rahl/aY
	cCXFDJppoT3QKwOYgZFCl3JpgfOGoNKQN/m72ZrVygeytlK0aqjKX8cz4kWltH8mxPq1TOhimgZ
	imt/L7M28p1okGxhUHvQjQApK9AFVeFk0gK382ggpTH+/fQXYN4IZ9teHBe/vd57fZADyAH0+BM
	yHJLB5PmiBf53pKcxdMzXsclRm+9bWzKsInfQcdKhd5+RwnODOYSBsfDPpm9emJQwaho0GEkETr
	83cRs6Wov3zJQks7i60fFB4iILT5F+R6kY6eu7BOBdnJ2fKtg+Xk79yeTrH30T2Gx0zphyjhKUm
	l0EJ0i0yGfsRPRkXQeOF/tIgiUJM0C7bnWMg3GlgGtOhpf5WZUFsj1i1ZUeEPBHKhaDdvyAFWOG
	1TR2H+H2A442VbvrRGTsmStGavZzzvgc52/tL2Qir3VUBFCCtDmJl6OKdD3ddpNZ7JiMnM55jTu
	NOGpFSva6I=
X-Received: by 2002:a05:6402:4285:b0:674:bf55:6f40 with SMTP id 4fb4d7f45d1cf-679bb0a3b36mr164562a12.26.1777326311989;
        Mon, 27 Apr 2026 14:45:11 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b686406asm142365a12.30.2026.04.27.14.45.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:45:11 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c01854477so696581366b.0
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2026 14:45:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+GT3AHS+gt4dX5RuiMDNN05cwp+TBl7oodXzo7juC48UeCk8VDuXwuzkXWYX98zm1UUnubGKeGRR2G@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
