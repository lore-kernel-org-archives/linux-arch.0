Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015F3264E7;
	Sun, 16 Aug 2026 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786881880; cv=none; b=t0CAY7lnyigYYtlKFENrei/yGlM45NzN6f1nYqfAAqjJFdlMZvSp09iErayhsKHEIYMoHONYQTZYZN8XcQJ+zbfTwAQ+jQ1P5zmio9q1zp1tjRfYLH7cCjjaQfyp1ZYa4BUu04PhSfh9BUg7H8fyDEpxtZdt5cCTbT9rACvbnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786881880; c=relaxed/simple;
	bh=IVfFUId/rvjiqiqVmFHmQVRVQybAQy8lwM/gFyScVhw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=obAY2K4Ec8/J/w9e0PRgXE+C6oeR2ntDIzhykGFQxfISw/mhJY7fFoAFUVyNT0/jzjkz/SiVc4I5KvsTrLxvXajlDpyRAcwnkhBQedVJBf5s6Pf4jdUbIBhr2RlI9fw5kRjaorB/xcqMrjVYjn5rH/wZoSYlSwiHp5955ORDYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFI2AiJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFI2AiJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737541F000E9;
	Sun, 16 Aug 2026 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786881878;
	bh=dBTO9gktMqs+YZN9m7Dn6lVtYTSuJ1+92QAeVWOhE/A=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=EFI2AiJiBMVGTf8OKeIv62ILnMeLdQnOqX7XgKJOIuanIz5p72B8GmkX+Qq2y9izX
	 TXUvcNAoPP4qGtR3ierjyWaaFAkfBHeVBeMnnOEmp25skxCnD1k+o5A3KTBR9ClwGP
	 S6fibZYyGXmVG/RPuNg2NRZU8xfpsgzT+6fgH3Wsyhvl6yPol7fbBJXlRlGsUFZ4Cx
	 yHd/MsLv+kak8DVB2Qm1XV9wAhAMLolcGVQ/RNgamEUDINNETra6FefJKPnoVnMwg7
	 BEb/UMroBRkIDQyozzLBLaZcPdNB0YkVw91+u7Tm7nDnbtanz4fEKS71fR9IKCqg0W
	 ornYliEmDw1Tw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 1/8] mm: fix stale ZONE_DEVICE refcount comment
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de, 
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com, 
 david@kernel.org, kees@kernel.org, mingo@redhat.com, muchun.song@linux.dev, 
 rppt@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org
In-Reply-To: <20260810122057.30447-2-lizhe.67@bytedance.com>
References: <20260810122057.30447-1-lizhe.67@bytedance.com>
 <20260810122057.30447-2-lizhe.67@bytedance.com>
Date: Sun, 16 Aug 2026 15:04:30 +0300
Message-Id: <178688187038.2799959.10744801601222444417.b4-review@b4>
X-Mailer: b4 0.17-dev

On Mon, 10 Aug 2026 20:20:50 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> The comment in __init_zone_device_page() still uses the old
> MEMORY_TYPE_* names and implies that FS_DAX pages regain a
> refcount of 1 in the free path. That no longer matches the code.
> 
> Update the comment to describe the current policy correctly:
> MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free path,
> while the remaining ZONE_DEVICE types start from 0 here and raise the
> count again when the allocator or driver hands the page out.
> 
> [...]

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

