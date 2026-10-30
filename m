Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353166;
	b=K1WMw78tWRPahdg7MuKAiROe3MuWL9i/G2dUnn4E7uY1QpgBesAUur6+KJ+q9sKvadqO
	 EmfX9oKGEmrw7nUSHbQOoyOzdvrFcmKcEh/ETfeWhO+3QKCGq7Zi72RMZzUUYZmiQ0K5y
	 ViMTI3vDLDO9q0vzJX7bcMBVh+Ho8X77zD2Eh+dVwm+pAH1B1FZY5tVHBltLD7SHsdwLk
	 zOlmN/IBAup2Trp6V057W6xoRO8ARuvxAWD8P5v81ZeLvOepgXwyYd9YY4+KN85UsrKCW
	 lUQY48zPTmuVHiZTgBvX4DXZbhfubiCMlTyt3oRrF4qsjCq/525cYA8TPcX9IxaGFaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353166;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
	b=4gNw6pWM91ZbifqFQIFo/x45xOoLktVFDADxD6PgNdf7yXBOvb0NY8hbdggsk521HS8J
	 RYZQstGEtHx2ZBXHTHdX9tQCLFepI5l5YooFyjJ1SRcSBJcCVuW9fVatI53wC5JbJo6V/
	 0Y5ftjiisSMxM0NTNzeSVtTvzAZ+eBpGVCISiuhlChvTvsUWx/dQgNSsluMV7RG7I4pMQ
	 bMoaD0vBCj147tnJ5Mdp4pMX1v63IHvkKbzSd+9hcu9/8Se6vkCTGXPTb3ELPclFHkxu0
	 naXNruPq3hYe1RWdLHK6eDHzbZZjHVJHRQ9wWIEF8Uqr4zLCSNzsbigySl7ztxFiX4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC217606A31A
	for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 09:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC217606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so1637739e0c.1
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 02:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353165; x=1793957965;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
        b=ZdEkZWM3pXl5EHKTdDtwq0306qSbPZwEiBBzhCFLnmwM4z5fLNgrGf1rbp0x0qyKX8
         TnapYCFYSxsspyUzE/gB+ysHXmoErD8qFkmHhMGhH7EyCN+xCkI2GeC5cSKip8WmzTab
         GNrY0RqRy/b7X9E8cU70MX4UI/ZzgmYbdkOhnojT/aQgMdrwMpBsjctnzuaqClPd6ril
         prSnMGMH7W/f6kx3qpDOOek3I119mkYttGn2wVumHRMXbaUp8fnbK5FdwXI2m220Lld4
         gxF6cIkpghVFEu2CZ0B/c7GguvPtUAuidoQA3R043BMQhpmLP2OiGUo94C1meNjCkbC9
         ZRDA==
X-Forwarded-Encrypted: i=1; AKwUvByHEFBrV/fFEcIQUmk0+94E1U7HjY/dkrs+0S7syMK9YXotCVcWlsAZ/DlTeb2afqMWdpGxYt/X/w49@vger.kernel.org
X-Gm-Message-State: AFq9FYJEfiQ/2QqvLxj/PZ5yl61kQdxfm5ZwFTP1UVNRMVnSoEimlpo4
	5vg9cR5Rx/skPtHX7zT6EmZJp9jkBnNlG6OVtsR/4wjPFVSG2/zbuYr0sWYIBbwj
X-Gm-Gg: AYBFou1ixse0+z/uwG8EMWva0mlb/pvJm6WJQ3ZMqLKtpIpWyvqW5WDFYHdGdJjGOgO
	ZwXyD7sWm/JVLNONdg5XWDz+TOgy3lu+4hNOFgIfH/CuX4sDMKB7dQZNhW46p/vYQi1vdO+sTDz
	F2KrO2HBzR3sDa6mg2Up225VG3CDQk+2cjlK6XWIO73/nqHAnJQYpEXF2hC8yc7gvqwmvhxfOQd
	6UHzSan8vjGdkTwDoO3Vwd3WOzHUraK+vUV1rdLLeg3y8zqekZ6eGJkpd7rZeYcl2kNgpoLrNo0
	ib29RyGlXBQIxLfhcmw/RJqNydHDviB3TVan1cQwq1a567sWmqdA3gAoeN7qFz/ovbTjCEd2NjB
	VV7PsokD76aBKdoGO+KlebA6ePbpAT+n9YS/LmoPXnObAyr5b+zaIfOK4AChGTsSSvxl7Q0XG5H
	qfVVKzmb4L46O3RoZLzIVvOHEg7bkn2mpT8Xz1KJ9oHl9EKyKJO2gSu5hYf0A0r81JAZVI2SpZt
	XG/EFy3qLGpQViRg+6ciGCl605i3uiSpErmR4pTKf+6OF1GWUhS+OZZl7CgNSCiYkR0bXuL0tbk
	bGtYcqQASfBhgIu842a/zClvHLuG9xCOfienqU6sHi1pq1NdIgiqG40kHaaLBFDkWsA=
X-Received: by 2002:a05:6123:5c5:10b0:5e9:54b9:40a with SMTP id 71dfb90a1353d-5ec586ba74emr1411596e0c.3.1793353164822;
        Fri, 30 Oct 2026 02:39:24 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c5d183sm1771759e0c.13.2026.10.30.02.39.23
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:39:24 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9912c47367cso450439241.1
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 02:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzfSmiic5brVVbzVJ7c9SRQpA7xe7aTimuziLsBJktH2+7bWVXmx8UO6Htt/1vfuftwvoZmEgoQw6o3@vger.kernel.org
X-Received: by 2002:a05:6102:605a:b0:7ca:8f2d:5c29 with SMTP id
 ada2fe7eead31-7d0542ccab3mr1591386137.27.1793353163338; Fri, 30 Oct 2026
 02:39:23 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-2-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-2-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
X-Gm-Features: AclHuK-5feC2ixWlfC3xXKJ1XowEcUrdLUZ-UGAaez_2WzCy_48TVc-7hVrg-7U
Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: remove pagetable_dtor_free()
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Oct 2026 at 09:38, Muchun Song <songmuchun@bytedance.com> wrote:
> pagetable_free() now runs pagetable_dtor() for pages that have gone
> through a page-table constructor, so pagetable_dtor_free() no longer
> provides distinct behavior.
>
> Use pagetable_free() directly at the remaining call sites and remove
> the redundant helper. This keeps the decision to run the destructor in
> the common free path.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h |  4 ++--
>  arch/m68k/mm/motorola.c             |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
