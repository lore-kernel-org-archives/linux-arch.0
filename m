Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370616A956
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898531; cv=none; b=pSihWT8mPIDAWLt6TvMgVdRCR2O213PVOOIHw+EfIIos9XHjnFiRcket/2dYntfOxpG+utfzJ3iS2ngqBF9cT2rPLUs4ury5H3dcfrEOBrIeayqz/gNIQkh9XUpBmFRRCxU+nsoXzPLL02/FIWKQ3Y2TYYE4Beq+ycbXL7gtZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898531; c=relaxed/simple;
	bh=HI15qPZpODUUYmT3koZ5s3kfYeK07PPTFU7DvVv4qdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7Nivx+1Z5MEf4h7NzNi4MjdicadtWCekIYafismlgDJlekgFFz/6dy3NgVa02IyTvZWSgPX7rC+2E8ZtgAjYXlacen0NbeCUi2gXQhC9IiT8QvxOgcwm+2nKhcj6bOZXJG9pdn3+D4JkikbyfdHV0yHZ6XXjIV96VUQ24hq8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjSAE+Gz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjSAE+Gz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD86C4AF09
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771898531;
	bh=HI15qPZpODUUYmT3koZ5s3kfYeK07PPTFU7DvVv4qdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GjSAE+Gzvl7MTKyXrXtFonZmUs9umZp2h+IMq3fABO4JJCL1aoEZElxco7fD7vQRn
	 fGUnZwCnZAujrJY8Czuc1Meo7Mo/EDCH9oysx1oTesTFcA4hg9hJXUqfz3UfFujXXk
	 3DZbodxSpPhUywtjZ8xtXY7ik3H5N2dcgpQGY/2diAtPqtp/W+ajXsF2CPkKnRK9lG
	 tC/1KhyBGXh9nKWRSC3AnogrQsvf/c6r0MvKOpQbgE8zGHb0+/jntXgRIsayK2iqJh
	 zjjbPgkyhAijWs0ICN+FAEGdrgwoX+DopxZ1wyxAszLPv5JcT/NZIhQP5Z69haxY0u
	 IotkJQWZUIPSg==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so3729387f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 18:02:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdB9nxAhlJoGV5b5WEg87GkiG/C24R6Uq1kqH7MJEJMd3Kd9Nt62ubPWvnE1uPYfNo1MeBDmajdCt5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2MXtGF3+/bBpLw5gdFbUsvGVkF+JoYMAm5kkDdIjbnwcRnf2
	PlW7HnUCi5RWwysR5DukNfBhQJ2FLHnzFOLBBIeQHFzcN7kDttdrBMeXMk+wdwKNzZL2Vxydb+O
	AfXSQfruhK8p0IrZUyjqghzmE9K3mb80=
X-Received: by 2002:a05:6000:4201:b0:3ec:db87:e5f4 with SMTP id
 ffacd0b85a97d-4396f15d10cmr18428515f8f.7.1771898529711; Mon, 23 Feb 2026
 18:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220090922.1506-1-jszhang@kernel.org> <20260220090922.1506-2-jszhang@kernel.org>
In-Reply-To: <20260220090922.1506-2-jszhang@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 24 Feb 2026 10:01:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRq+Pp0AC4jFDQdSsQv8x_XWV4o1UrRGcrkAJD2238MSg@mail.gmail.com>
X-Gm-Features: AaiRm51r629qqEXKS58ilHPH1EHwU6F6qXM6VgeaCXkG7tSCgEZ_ZRupW9dwMWo
Message-ID: <CAJF2gTRq+Pp0AC4jFDQdSsQv8x_XWV4o1UrRGcrkAJD2238MSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] vmlinux.lds.h: add _handle_arch_irq RUNTIME_CONST section
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 5:27=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> We will use the runtime constant to optimize the handle_arch_irq
> accessing. This is preparation patch.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index eeb070f330bd..c4af2c7d0eed 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -973,7 +973,8 @@
>                 RUNTIME_CONST(shift, d_hash_shift)                      \
>                 RUNTIME_CONST(ptr, dentry_hashtable)                    \
>                 RUNTIME_CONST(ptr, __dentry_cache)                      \
> -               RUNTIME_CONST(ptr, __names_cache)
> +               RUNTIME_CONST(ptr, __names_cache)                       \
> +               RUNTIME_CONST(ptr, _handle_arch_irq)
>
>  /* Alignment must be consistent with (kunit_suite *) in include/kunit/te=
st.h */
>  #define KUNIT_TABLE()                                                  \
> --
> 2.51.0
>
Reviewed by: Guo Ren (Alibaba Damo Academy) <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
