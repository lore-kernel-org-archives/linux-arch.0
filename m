Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF2329C7B
	for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774185632; cv=none; b=SQDohvgxpM3H2VYpxpJbBBBW37ANjJRG98pVXDYxjU8WIoyg9OdgB2JEI1yXNwMTs43QMbBb4ReQ5Nt4EuVX28hOpd7Lm+yHCmsbfUpP8bf9k2zvkrFzFKiROFNrh1eCyPtaZ9+gKtMNvkzU4g6EOGxp7qu2Q5BEdnGUDKUh2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774185632; c=relaxed/simple;
	bh=JO8s6CvPJ60AKkie9O7leqHw9KEgz3znAI24wdcudkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq+Ge6n/Co2LPFV45t6+9qjCqqI3PIzar3kELlyKj6w9EQUqcLbMIh542rf4y9ja1TmkrLYBMr4Exk97cJJu8waRFeZ3aJlg+ZnKvOLXFyRatZTiQHOEHonKpCB2kx7kbbt70ZZpv2RmF0Li5kpU0A1X+gOsmnh8IwxYuNf+Fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdD4ZHIj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdD4ZHIj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso1187052a91.1
        for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2026 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774185631; x=1774790431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO8s6CvPJ60AKkie9O7leqHw9KEgz3znAI24wdcudkI=;
        b=GdD4ZHIjlZ0OL7FvRsqGxmZ9zUy9S9Nx5by5zXjHvPE1Ny+19BElskKmdpvPUBJY81
         IfP5r/f2EGDrBNSproGx6v1UTXQn1RrlPezw7bpYm9QjwUfJuwvDSg/h9LWrApHzrpzI
         Z6GZBiDNv0qpJ3uUOf2i0MQfPHRW2E1elwWyJomMpOx4boEq6OlZkNUmhCJRkISzSXc9
         +EPvUNk9bD0EJdb2ggLjS38AF+eBFJggEOv48A+hYTB3oljQ0jZM/Gja8Vs+Tp1MtZ9R
         2zkbX9W4XRUNmsgj0WDNURkSbaiaVXsAyIZJ4CRk/C1EUxpyiAVBV/KuCmwRCpcbvWuK
         8LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774185631; x=1774790431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JO8s6CvPJ60AKkie9O7leqHw9KEgz3znAI24wdcudkI=;
        b=AEdDh2v/7nWjMHd/bYWu1+qb2/RgdeZgjTUwU1ybSR83l1Yw4Hg32jGagvYzKcaljq
         1vbLXt2BaemlKJ4OiFel52KPvAyAf99qEXLnQrhQ79jfu4CNUplj6xHkFZcxx7z+UtM7
         1Dk2RlrT0n8fsarrXpjqfusMt7nM+u2lwuwHleaJFLFr13KFTheF9eQXV8HT0I/bRTqi
         ui+pzsxcMisDATq3dTXSO6uH3/ZcbwtLHxcl2Hl4VbP26aF0n6kf0lDXouf465yUG1Ty
         Br0eafLDZBGPCNGE3cOHltD48JI+NrAKruF3Y9HyWpk/3RXWdjnHuHIK4krG2F6BVZtd
         kKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmzFGFtzXvHDX3SiOrBd1fQROqPcJ46/9ExeYq+YYsDmhRvM4IJ9N7FfeylPp7UrqEw0pYTqYLSwdg@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWzm+0+lIrw6WV7IGHK0zjuHCBYPfyqALbmIpna2br216Ixn9
	TtLFczlTXoEpLstTdy8t+qXdF/aqeKT8Zk0mOa26X817iewBAP/8exgL
X-Gm-Gg: ATEYQzzBaTtDtG3W8rjGAwtaMadKagIe7yTsL5FmlU1XM9U7LeHjC+mpuUCeZ6JQnjl
	H0bx+Uc4LmJ09BEU+JIQL0E3gLgU4F9LUi1BPJl/k+9Rfy60KD2wqTDWU8//25mYfYce+KV8CK4
	oi0HXXVS1FLTK2ScxlETsfmXyH+nWfHgUstFp+vz0YEFmejYuK0rLG8zZMdXaP42DUTNuVl26PH
	GCIWN/a4vrWp6WVjUKF2bYbvT0mh8oxZ5Sf0f5gezS+Z72Y68/V6HzEEblwTjeuW5fTEsiOzupA
	5EgIQXaQgjkx1tUZ68w6Bghxusg369fFDf1lH4AxGqt2cC/N7xIW0Z2bdVl5M5e6D+DAU/LCMs0
	gQlVhOW7qf9gnRfXDMKgrga0sP0y6dnGq0ArSL3rYkDeTjtvANTrmOi47vkh6q5UYRkP6rRiYSt
	FzHQXXhYcAfFdn89EOpy3NADbdYoC6Dyqi4gdtKyH9rX42jI2dbfrZRdjGxG7PjSco7Mdwho6EK
	vdBW65eZnUI2w==
X-Received: by 2002:a17:902:ef45:b0:2b0:9aa7:9494 with SMTP id d9443c01a7336-2b09aa795c0mr4010775ad.28.1774185631131;
        Sun, 22 Mar 2026 06:20:31 -0700 (PDT)
Received: from localhost.localdomain (123-194-188-82.dynamic.kbronet.com.tw. [123.194.188.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083527f84sm76607375ad.18.2026.03.22.06.20.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 06:20:30 -0700 (PDT)
From: Min-Hsun Chang <chmh0624@gmail.com>
To: arnd@arndb.de
Cc: msalter@redhat.com,
	akpm@linux-foundation.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chmh0624@gmail.com
Subject: Re: [PATCH] asm-generic: replace ________addr with __UNIQUE_ID(addr)
Date: Sun, 22 Mar 2026 21:20:26 +0800
Message-ID: <20260322132026.13485-1-chmh0624@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307092119.20733-1-chmh0624@gmail.com>
References: <20260307092119.20733-1-chmh0624@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arnd,

I'm sending a gentle ping regarding this patch to replace the hardcoded
identifier in __set_fixmap_offset with __UNIQUE_ID(addr).

Please let me know if any changes are needed.

Thanks.

Min-Hsun Chang
