Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA63D27FD49;
	Tue,  4 Aug 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875746; cv=none; b=ODf3bd3MXzX2FKx6p8ctKgk5ZWrbZ7KNAa/kwiij6igmlRpS7QPEbbIKw9kX1KQg5HAqsN/MvdAzFDRZAeH0345y9zsdTe2O2TtyrvJZVj4bTBF2HeLMY7vxtXKhMNXVbLZyu7x5Cb/OZGQRoEkRxOUov93xYjwhF+ti/Z9ew+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875746; c=relaxed/simple;
	bh=wE6FBMr1PvpHwAUznElZyy9ISxtbbQPHswFljgCwFbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpwDMmRbMIPtD2dk4CcIUDjE8fKZFFKfAopgBCX9ufRPge32iVfmr/Ap/DXQDoPiXEKPOGLYxui1DOucAjB4NKL6BcnvI0NHZr+P9umTI6d4/lZY0fD4ke85Tc9yAHOTYMDi5em0tJnsvoruITv7SUSW0NFS0ygU6mNi0WJcGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HmEN5pZQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HmEN5pZQ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2942640E016E;
	Tue,  4 Aug 2026 20:35:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G9xu28hJndJV; Tue,  4 Aug 2026 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785875729; bh=DfPSIGNtSNCrYmnAjCAJSktSQDthCNJqrL3J4J7+FmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmEN5pZQO1cKYlPgMAo65EnTIgwNhdAim8xqmSG4ttbRFwy8V4QH31OiveIXudeHz
	 lLQ2DBk62mVo4s5DRFi0K4KwxKTtllyenYtsO2ePAG59cJ0XTmWRt/fxJYqlCyzDRn
	 Bqq93WIV6BLQlmZUoH+OwNIAjGrIkDtRtdKoEjgNbDr/6wpVRpvTxiN4RaN2Gd7s34
	 ACmBPodoaYPhLKgx86l1TEty8mDHTSe496UMG02V3It8ayzdoJ1mur2Q6Jxw2g5bXF
	 wqel4Euvgie89cJw5ANYmuCqBJLyVUkKKabFB0jMeFyhJhGcvxVw+JG7gO9g5zYy3e
	 DlLU6aLhbbZ/VjQT7p2H/TuatxG4W6XMxFB3Jc0T8Xi+vODVNzn5hM8ejf8mWi/9ZL
	 3/mnZxTldZZxcJKdUfgHeRRefjevS+7plphaeJCViSoUrHUj4uaJTAJvhdKNHuRRl3
	 X3KnAHNz39CiACbbFAkhdPnNqIWnalVxKRrkYrHJwNNrcTciE9IHNXIaRmZSpDtH5w
	 /yHtiw4nnoKLk1SZY9WCjAoXZ4UtHCk2g3Ujm+EjpNMXtnkLa2bhWWGVl47QUga4Pe
	 03vn0uLw7tjwQNm/AHyG7AWe105MjvuAqYWIVTrut9R5oq/MT6+ytYyTnybnjAuFbj
	 VCdtX2dFjL1b+Q2otoXv4sFc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B33640E014A;
	Tue,  4 Aug 2026 20:35:12 +0000 (UTC)
Date: Tue, 4 Aug 2026 13:35:08 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	balbirs@nvidia.com, dave.hansen@linux.intel.com, david@kernel.org,
	kees@kernel.org, mingo@redhat.com, muchun.song@linux.dev,
	rppt@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v9 8/8] x86/string: extend memcpy_flushcache() fixed-size
 fastpaths
Message-ID: <20260804203508.GEanJM_LGXmItYhFKZ@fat_crate.local>
References: <20260803070929.86075-1-lizhe.67@bytedance.com>
 <20260803070929.86075-9-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803070929.86075-9-lizhe.67@bytedance.com>

On Mon, Aug 03, 2026 at 03:09:29PM +0800, Li Zhe wrote:
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
> server.
> 
> Test procedure:
> Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
> initialization time from the pr_debug() output of
> memmap_init_zone_device().
> 
> With memcpy_nontemporal() used by the ZONE_DEVICE template-copy path:
>   Average of rebinds for nd_pmem driver: 150.83 ms
>   Average of rebinds for dax_pmem driver: 153.55 ms
> 
> With this x86 fixed-size fastpath patch applied:
>   Average of rebinds for nd_pmem driver: 96.79 ms
>   Average of rebinds for dax_pmem driver: 119.04 ms
> 
> This further reduces the average memmap initialization time measured
> during rebind by about 35.8% for nd_pmem and 22.5% for dax_pmem.

Testing methodology doesn't usually belong in the commit message but under the
"---" lines below but this is important enough to keep it here.

> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  arch/x86/include/asm/string_64.h | 56 +++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)

A quick and untested cleanup ontop with the potential for a bunch more
unification. But later.

Note that you're inconsistent about the "memory" clobber. The current code
doesn't have it, you're adding it to movnti_8(). I've added it now everywhere
to be on the safe side - it would be interesting to know whether you see any
perf difference with and without it in your use case.

Thx.

---
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index bc6a9f34b346..3a1e1f17431b 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -83,6 +83,14 @@ int strcmp(const char *cs, const char *ct);
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
 
+static __always_inline void movnti_4(void *dst, const void *src)
+{
+	asm volatile("movntil %1, %0"
+		     : "=m"(*(u32 *)dst)
+		     : "r"(*(u32 *)src)
+		     : "memory");
+}
+
 static __always_inline void movnti_8(void *dst, const void *src)
 {
 	asm volatile("movntiq %1, %0"
@@ -112,47 +120,26 @@ static __always_inline void movnti_64(void *dst, const void *src)
 static __always_inline void memcpy_flushcache(void *dst, const void *src,
 					      size_t cnt)
 {
-	if (__builtin_constant_p(cnt)) {
-		switch (cnt) {
-			case 4:
-				asm ("movntil %1, %0" : "=m"(*(u32 *)dst) : "r"(*(u32 *)src));
-				return;
-			case 8:
-				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
-				return;
-			case 16:
-				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
-				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
-				return;
-			/*
-			 * The relevant fixed-size copies here are the
-			 * x86_64 struct page sizes: 64, 80, and 96 bytes.
-			 * Keep 32-byte and 48-byte copies inline as well
-			 * instead of sending those nearby fixed-size
-			 * cases back to __memcpy_flushcache().
-			 */
-			case 32:
-				movnti_32(dst, src);
-				return;
-			case 48:
-				movnti_32(dst, src);
-				movnti_16(dst + 32, src + 32);
-				return;
-			case 64:
-				movnti_64(dst, src);
-				return;
-			case 80:
-				movnti_64(dst, src);
-				movnti_16(dst + 64, src + 64);
-				return;
-			case 96:
-				movnti_64(dst, src);
-				movnti_32(dst + 64, src + 64);
-				return;
-		}
+	if (!__builtin_constant_p(cnt))
+		return __memcpy_flushcache(dst, src, cnt);
+
+	/*
+	 * The relevant fixed-size copies here are the x86_64 struct page sizes:
+	 * 64, 80, and 96 bytes. Keep 32-byte and 48-byte copies inline as well
+	 * instead of sending those nearby fixed-size cases back to
+	 * __memcpy_flushcache().
+	 */
+	switch (cnt) {
+	case 4:  movnti_4(dst, src); break;
+	case 8:	 movnti_8(dst, src); break;
+	case 16: movnti_16(dst, src); break;
+	case 32: movnti_32(dst, src); break;
+	case 48: movnti_32(dst, src); movnti_16(dst + 32, src + 32); break;
+	case 64: movnti_64(dst, src); break;
+	case 80: movnti_64(dst, src); movnti_16(dst + 64, src + 64); break;
+	case 96: movnti_64(dst, src); movnti_32(dst + 64, src + 64); break;
+	default: __memcpy_flushcache(dst, src, cnt); break;
 	}
-
-	__memcpy_flushcache(dst, src, cnt);
 }
 
 #define memcpy_nontemporal memcpy_nontemporal

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
