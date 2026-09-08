Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7C3B9D86
	for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901593; cv=pass; b=lOWylaWsM3mN/VIeugzys+zDlJ4O7qDH5RwudUgBRUuVKf62Kb63w7XNzw6YXAWsmWlxogf1efsJfkKqTkmYvMtdEVYSBaOv/nYV5z4REWL2BThKMUgYKFUY/Tq5n0ysekmAKDTPu/rhCPTszfzKFOLy4C4A7i9i+LHjGfhIU/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901593; c=relaxed/simple;
	bh=cIOFXtCuNna/zYNDEeDAmAkgX9xNg/vNmHFdct8PtpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoG5nZf+Tafp2FecC9fy6rLLKsOV70AqILfKP2QaCqrOmuT1vO/NxtaVLvET7jKa3QY/yByHaEYmy/d3UzE52N4BeYu8ZkGrS/ht0MHTPXXZU1+iFmGp6FlElmqjJHzNJ/eZKcFZEOTQeMsQp6mx77KwM04dlmdxEph4wpI22RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otsf6b66; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otsf6b66"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so71998885e9.3
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2026 14:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788901590; cv=none;
        d=google.com; s=arc-20260327;
        b=qe95mrX7ljZ9WOhuwC4LV/5ttZna0U9slqHF7J8DExRtkfsMzfPSwc7VowPC1yyTDG
         XftDRZkYGCKfANHLystIvyDfWGUZj2mK/+ZsVWHouhx9DJQeWHbE2MqQotH0Bgk3IUx9
         6a8CPJ8oEc5Hei2ysKFIYeK0SrOEKmMDdKtrrJkzYK2Qm+G9rR9QjJdNl9eRJ9BRQV+B
         iS+8zDG7En2RJT1aaXZT5f2CVpFtzwblqeQYGVlTfF+xSJZjtqKpSLUR3fMEAP9VAvc0
         fZ5dip2LvykfCAIB6DqTe58erX0u4HXI4qTnY0FCJzw7lwj/PtTmvktql+e5u+4XiZDU
         XKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/CB3Vtp7eYFgiX1lhWfAP6WjiIrj8nFLFrnLp7SXQSY=;
        fh=oH8vIv9irAwhzqfC09CcrNsFQ+Qg0YfZbPtsTzyWG5o=;
        b=NWTcRvU66wm/rHzPr19yaOnn6shkgm7ZVEtGWa/XaZxubrcfEHh5nXN5TZ3kIncMOH
         JYhfuG4VnzEiahG1e/URDs+4tYHKSpKVNhlXsWC9cbqtbxkIy/66mGd0OPD/XxvFBXXy
         a3m+oiZuzJ8zrHoQA2dn5apFyhwtaz/SuJ1VmqfkJvHSAkjCXI/joR3MEX5K+WpsnKx7
         agX1k+HCisRChMWm7uXZTnjUKRyci9ykgWJ3y7+Ybp/4mS1b8koVlV+c/lN3NRMJw3MJ
         iaICDz4Khv1JJbzjurUIzeBR9Pr8RGzwdDRWyFQTVI2dccqTm933gs4FG2A0DnyW5rRA
         KZFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788901590; x=1789506390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/CB3Vtp7eYFgiX1lhWfAP6WjiIrj8nFLFrnLp7SXQSY=;
        b=otsf6b66eLyN+62lzguVV+VBMlATv6z+svgDrA31hnA5b3fBV3bwYCqshPtnmsyGmv
         QDNDZwx7N31zA+x89VYITcROT5ZRN8TP4ggK6R9uMannUm/MUJSMRZGWkbAMzCuOqlSY
         H6biXYN3dL5DiY2yXed6Ky4yh4BVxXR56j5VYoNJgh5pu6nlbLx8ul8LTxw6ojhP81mJ
         6JTXwtflQYVkO/SfV7yVBVRWnh5SQfasm8wlbFkY625Bkt4jmQ2QbNf1ssWLfzh6NMk7
         l1RjM2KYlCGn6nKE0yFuTlHEHgKavdGE6I5+Sqelz5oi5Z+IpMaKNlUCqzRnSjeVC5x7
         BuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901590; x=1789506390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/CB3Vtp7eYFgiX1lhWfAP6WjiIrj8nFLFrnLp7SXQSY=;
        b=l8qEGf3sKy4soAhFVDa2OANInCivwU9F++tvPzkWSn9FU8h9wX2JG/ngxn9hL2X8kW
         HCyH/OOkW83XqToLNg5k0SJNUzziTo0PRo+l/hNAnecGDxx4Af6TTOOKFLYwVSep7U1d
         gJPW+UXxnkXr8OKolED20u1osITPpIF7D2FNb+6hOXxYsK5R1PtIGWt/kbD31ilXShUn
         znaqT7qQQKB9rBrFaYMHv0X0jHKFs4vlTzcFWgHiiK7eBfGSLi95ksNpkyYlANmav4wb
         qPCMV3CK5rTrMOwglo6CYm4XQ5AAjn7lOJ1ILQUXkwROeKelbd4T4tW77WXE7boahxBE
         7ImQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxQqZ3t36atQwCxCijCKhwhuKpTJKKoUx5njlnssPebcRSn99DFIKSOaY2gSE3rixBWTTsEBkflM8L@vger.kernel.org
X-Gm-Message-State: AFuF++ms8T+jCBF4maz2f2ChS2UO9J+pZXu4S+OmdCojQqwa2gFN0oet
	NfWHWxRRWIuUcmMHw3QRyyhCJxI4E/sS3tDL9wxcgaepM/VY/QGLdkIo2WoYZzcgxdkk4SqP0WF
	jf4gRVYzj0VYT07+FiZ74lhiYrK0MN/uRJfi+g9vR
X-Gm-Gg: AYBFou0fjBhQ+aKA45LX0Xy1YJa0abq7mnmDNE7P2Xifuo3qBHp6AL7BImi4lyMAdm8
	qKk0iFNjozOtbZrUQWPB6REO7JF7uDdEdFLHly09agktsq/lm2nkFEWYZMAwK8E8Fzg9FYQbeQs
	qFEhBGQbiQlVRAATps2vIVl4ZyRmsg5WQR5v9wniCvhvvmmX4/K0K5YjcEQcE7zpP7hxmr1Mf/9
	Z2jrkOdewHGm353Lz2rqSmjY9A8Ruua9ZUkK7KsrrpIvb/W2Swc2W5mNlijwIJ6+uaFchXHWFU7
	ynXM4T1w3F2X0ZqsKfeqNy7BYOMwCg9tIQD4jcZtdkxSCvB6PDwLoK88Tm5IP8kBSHnjwKp+SPv
	O+9XS7PDqcTPVvNTmd8LyqD08oEJfiNn4KGy8t3N8FR406o5v7dIj4SAI
X-Received: by 2002:a05:600c:6091:b0:49c:eb17:cf3b with SMTP id
 5b1f17b1804b1-49cf8252497mr286154405e9.8.1788901589479; Tue, 08 Sep 2026
 14:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
In-Reply-To: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 8 Sep 2026 14:06:18 -0700
X-Gm-Features: AcwNN1Vne6n6eJi0vjoX52mygVY2Bf7Bhttyek2fKXqRHQxDJ8Lg5WpFcLyZtjc
Message-ID: <CAKwvOdmdFdW8=y+s5NLoNeKz4LVbmW8tr+JqJ26wqYFJDdARFQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] kbuild: significantly speed up kernel builds
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Schier <nsc@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:55=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> A typical kernel build consists of a frustratingly large amount of time
> spent stuck in single-threaded bottlenecks.
>
> It turns out that there's a lot we can do about this and doing so
> significantly impacts kernel build times.


> Fundamentally the series improves build times by parallelising
> single-threaded tasks as much as possible and improving the efficiency of
> code used in the build process.

Cool!  I have not reviewed this patch series, but am supportive of
solving the problem, since I do recall this being an issue;

i.e. it always annoyed me that despite have a 128 core machine, much
of the build is sequential!  Having all those cores and not saturating
them during a build was always something I noticed (usually have
system monitor always showing system load, always) but never had time
to look into.

It would be cool if your LLM could generate any visualizations of
what's going on during a build? Seeing what's serial vs parallelized
in perhaps useful. Particularly when you can compare the before vs
after.
--=20
Thanks,
~Nick Desaulniers
