Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF013D75D1
	for <linux-arch@vger.kernel.org>; Tue, 28 Apr 2026 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368765; cv=none; b=LAmNCJ3LVu7bJy5oxvFzWlA6Jf0O7ulC2W+QujN7c5u423bqV13L2ZGkbrlL+ddAMl6Fumc3umgLLP9pJdAxVMvIiPAgFtWBMYLBFWu0r99KGUYia/3AgwCC54dGCBncemcW6jcs2Siq671pq3AZSlVAF4tUw8SbrSFgxO6PdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368765; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2oMLWdnM7uPtM7vULheJU+2cB6M7mSbyFF/gShNQClV1fRpSuBx8kYDLSE6NE8P9ZRU7795kSWQPeABMYR9FEs3iy10svJF6bQ6SeBU+8URwxrWsiuv4wwbD+WEYdlaAKa7DR8b7RMxa/6H2QaTfzc4u6P+KegSLw1GA2IUbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so7380478a12.0
        for <linux-arch@vger.kernel.org>; Tue, 28 Apr 2026 02:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368763; x=1777973563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=LUyNdRkFDD8OdiR/TikEs2XTN7moFBPkoFic/ENqGk2u+prrLdSF6nNt1Ye95SlqnD
         KA7kIhf6IhVcgWNfAtbDaeFKVDrQ8XzavGRqe6PScUTw+NlzpKpEeCCAGki6hjrQVglJ
         zsntNQKT7O28BoDVu9iN//HZ2BTRseyOKRuqigHKvoPYB53CqwhdsRO7mIJdoUoAwmul
         ZNdj4TNBl5HCy7IxeMR8VncEpV/AcUXycWa2nsapmLPbjSURWMXsx2J59ysbc+Roepg5
         Htq4KoCyMg2jVPJjqrf0/Le8PRadNfJ0ieUioxFcA1OEHtJzgtdljCfQx8JeK5NEUlKr
         mRjw==
X-Forwarded-Encrypted: i=1; AFNElJ8jzg7mjfrxkrDflc1UowDvDsj+8EaHUuGN3jDfq32cRMxHWRrq+x8ot+WE/mYVvqInbsiYxIXJFRgU@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnML8RZZyN0SeLhphtjVkSzp17ngLgW4cytJl8Hjj/llz+uFU
	w87WiaLSLMxJkvimXQebIqbu4+C+PcD4m+U/Udgjwvmnmxf3wVvzjFNeFRJIkY3rQiQ=
X-Gm-Gg: AeBDiesqNc0sgeobw7+JhGjydIm7Kbz/0T1t2WQcMdfC4s4eMafBnepYyvLH2KemdBn
	C6SQ39HoMb8gYeEW4VF8welu7xPYZVrGT2X1t9lFFbJ24T1CN22//foNUMOR2T2xa6OEjMEqKDg
	CwuZfYIIAZoOBAfMxD0AtCaM/RJVc9l5EJ+AMBjawUBGJz8XnjA/rPXuaXpa2FK2QD3bCyXRJdB
	qM0IK8QMs8g6YTM4C4Y30xhUcFIXdHjUTnSYoMkU0GGr+bIkDr//ioIcmpkbwr/CCbkM/G1MaJy
	m6KdZaFsbqYgCqSyvDE26BrujmDeb8W6jMqIsl2LL+4wrWkfHihR2hxZk6yMv9nfvejhYYGcQ8w
	pqDS+FxEp+aPhx7i/hGdYxbUD8Cipt7WwtMWsc1vXhncv0HHXpnNNHFPeMeEWkv5DbE+SDFHluN
	paint/ltooOFZxPjolG/i7a9TVq0LOj4Qm4gHOBQcPIn8p36avNe1GXEfboyO/kLAdb1YzDPk=
X-Received: by 2002:a17:906:5190:10b0:b9d:1673:9994 with SMTP id a640c23a62f3a-bb804c32e5emr104915966b.39.1777368762568;
        Tue, 28 Apr 2026 02:32:42 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80853c8a1sm72925066b.5.2026.04.28.02.32.42
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:32:42 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so312255066b.1
        for <linux-arch@vger.kernel.org>; Tue, 28 Apr 2026 02:32:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+/mooELXymNGJ7b0y3T3M/IJm+3mvaPqs36jyoCS2RlfzlLT/p1dBpE5F14x8zNE/MllQx5i+YxfG4@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
