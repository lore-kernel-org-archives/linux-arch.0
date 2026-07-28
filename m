Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449638F949;
	Tue, 28 Jul 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257335; cv=none; b=fTzHFKwxj1+WIei/SW5/a3l9twkUg1787Skqgh3iR5lCxuA9dpeg9wTKrCGbU4dbFzbcLuAlruLru7sHUtTydRTTXI4GQTkRKts/dHXO4AhYnowa4FxOuTP+rud0bog6xG7rbTotQmR00La6dzkn+/i2GOlwcphTOPDfxk1BTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257335; c=relaxed/simple;
	bh=IvY4kfy1p4o0GbHClrQiTmcKiCzYrwcqMhnje8wcIXE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=gbgCZBrxgaczaJi6AUmRENJQdqmXCmfVkEXRZq1vc4f3zrYCbHRzaMIwYIpVqxq8RJ2Tq47ba9cCSCfZEEdEUEou/kUG7Jp4XQGOGE7h3ITKf9L+C4nVQ0+evqdMgS+EsgD+lqMGR0Sfy1kLyLL210+hy9oX8JtPbcEo/2d8MLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRXc1Fsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRXc1Fsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B42F1F00A3A;
	Tue, 28 Jul 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257333;
	bh=Mpr53o5xn048mORlTpkeftfNBVvFhPpp4N4joDXnfPw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QRXc1Fsv1U9VteDFxkII/v/v0DebIa0cUbezprpMeQqfxtvnDeOdUFlh3JyBE1BxJ
	 wSjsa5zp2EyGBYVsNdL7yqXNRqKzc2pVnPZymvgmVEB8IJ17PGaY02rD9KsLAuMN6p
	 TifWgkJ/6dzAemeOS8wXamIYZ38Y6JiO44hWFqx9kjec4m+GmnuWlqq/TKIsjXTnkk
	 NJGNBRMeUMPzLof9Z+rrw7pddoJ6gxckrJm2pvEXo6wad7iP8n73PrjzpCgHL1alMi
	 yVHcY2oeyGQUnNEz5/QMfcHTtQ08PG63y7klrk6zrM44b6x1QwCnhp5YXuG4l+szv6
	 XjxWjIUFgwv/A==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 9/9] mm: always use the zone-device template init
 path
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de, 
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com, 
 david@kernel.org, kees@kernel.org, mingo@redhat.com, rppt@kernel.org, 
 tglx@kernel.org, muchun.song@linux.dev, linux-arch@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org
In-Reply-To: <20260720120259.1545-11-lizhe.67@bytedance.com>
References: <20260720120259.1545-1-lizhe.67@bytedance.com>
 <20260720120259.1545-11-lizhe.67@bytedance.com>
Date: Tue, 28 Jul 2026 19:48:40 +0300
Message-Id: <178525732063.1556190.16834028754418994747.b4-review@b4>
X-Mailer: b4 0.16-dev

> The template path still has a local opt-out predicate for the
> page_ref_set tracepoint and keeps a non-template fallback path. This
> makes the code more complex without a strong reason to keep the
> separate path.
> 
> Use the template path unconditionally after the corresponding seed page
> has been initialized: the first head page seeds the head template, and
> the first tail page in each compound range seeds the tail template.
> 
> This keeps the first-page seeding logic unchanged, but removes the extra
> non-template fallback from the main loops.
> 
> This also means sanitized builds no longer force this path back to the
> per-page initialization stores, and an enabled page_ref_set tracepoint
> will no longer observe every ZONE_DEVICE initialization-time refcount
> assignment. That tradeoff is intentional: this code is still initializing
> struct pages before they are handed out, and keeping those local debug
> special cases would preserve a separate initialization-only path while
> making the common code more complex.

Just fold this change into the relevant patches and don't introduce the
opt-out at the first place.

-- 
Sincerely yours,
Mike.

