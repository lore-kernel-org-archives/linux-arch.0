Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76A3D7D8E
	for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901999; cv=pass; b=Z7NmpfgocTTrPxtzw/jelm/iGKOzkPGjECWTblROrksuXLKHCJGbFjEEVZ0TPAwGQyWpY/7iedgXjayPjhwkj158aL8k+NMnnnqllmxlD3KZHMY+Rzfwa/qeafbSISNWCKuMtL2xisgk3QvwQZd4DhebT9o2moQokl0WPcC2vJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901999; c=relaxed/simple;
	bh=ABcg7txfjreOEvrgYloSz7dmSAX99sKg32JTqnOhFhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfQSRYVfkfQ748zV0A/ckic4gS+J1Ln1OVnCpaHp9iUC+ARF2OUrA8j1wzULQHrp8RwWMCzWdJDY+rq+dDG3Ew3huqvkOUF6t3yY8vCr2Ut/wNXZ1k+P8jqF16ZJrojdPLDmunRJQoembCyF8XMlsZ6eWBTIuwNqZZYz9BnTRcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPf6ZmPD; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPf6ZmPD"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ab16a9b0so215441a12.1
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2026 14:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788901998; cv=none;
        d=google.com; s=arc-20260327;
        b=UcjwuB5BFXjqZ6IZAffkDQtCcf8hZ+eUYGkZKM431qSDxwcMBRptaw1RV1XnF/nkH3
         9g4qY1emyPQLg9aB/gFNDeTI0r2QTwTIB3wgLJc3Eo/Xv4y6VZwOLrkJRlbFwMw+cWBD
         QTY5eHMqv0MDPe2w37VtmqAK0L4dhNELL+J7J3hSGfWUMihGkJT9JwsedDctTiBfc3mi
         RKQCvpaCf4FQQUK1N2Y3ApY6GuXdycDdss5kPxFCkamCpqFcVn9Gig6BCd2ixQ2sNH7N
         TEVeStWFFOuxRfYq+QUM/W/I5KLdmNNyh980AiloJuivIWelu9x40Gjq0hCyZz0O1yWm
         Bn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0fhQV0gw/THBej21ZRoleMpcrYInoRUuBgF9MHF69Ek=;
        fh=fscDx7ZDfUnMne/2FYkisvZbbAzKZczxEx4uQfwoW0Q=;
        b=D9ZNyZLrAl/Qro1RRjs2doxmLAiLXdcFiMW8CYz13+220HgzytHicrAwdP0xzuqlHD
         KqxbwXoUfTa3CPGxsP33f6WBPeLacCM3iqeQAbqs6yd0jqOBlU2F2j4jV0PEEcUsOfx/
         9ay5MEiQWR1dEcXcMXmkbADFvOYWG8xopjxGIzhYAXhZF4BU5WwVm3XirqyQ2HjECW4c
         tMPfRq/AzOzby1UnNAN1d4wQipT9FfDsBhRyzk2zTd+ebAfgH8jiy97CQErlsaaK/wPX
         C93PFLUbl/9hNLfw00Z3/SqKK5sXfjfBgD/R9K+hIw5pPJlH/nNFpTqLKySHljzhXekX
         9S7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788901998; x=1789506798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0fhQV0gw/THBej21ZRoleMpcrYInoRUuBgF9MHF69Ek=;
        b=kPf6ZmPD2v4AefzfbB96CY/1Ro8ul1IcFijnGdxXVXzXHHTesc60tRNbKo2R6qNiCV
         COm6UKvfUu6Q7EJ03xDCsbtZZbD+boDtakiCuWcq39IiGKN4AWNMMaVstLpEFMUY9fs/
         fA3Ai9ETukyNfyw4rNxQfgzC3yRmNdwLUvg5cs5n0LI7BG+oMLyNjugmjmLMSwmDxeii
         iJ9ESmD+qArHzXwghsJnFKtjbvVeFcor+5i9UXIjBUduxGmJNTr6bn/S+Vu/qGuE5X55
         I4+dUgYq6dDOehzn331667NXRaNpuSHWvSLVHlvtNcNxcI1Le57wdyswdbpjKOR//hsO
         L2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901998; x=1789506798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fhQV0gw/THBej21ZRoleMpcrYInoRUuBgF9MHF69Ek=;
        b=rdOsAcBvDbpBbMdyyAJP/f9L/DIHqGSA2vry2TDkrblY42SEFOImupQYe2B5vtGgGc
         fh0CJ/Upo7oxbdhEkxQBqrRlWpdAEyo5qnau3m0Jp46vqNrSieXJrkWyp9kRocXN0jpi
         sKSi8OtMR7/f4Xbk3t6gf1DaqdKHzA1iN9ovWzWqLJE90sAYiTQTC63YU88RXcjsQXlf
         Ty0uQ/APurqb1R10hY2b7PMKlzzfMSuS93CUBtfuX3IDiAKvfenarWGUwc4gI53K559x
         w2u8UYEPRWKnkIqfUWX0OhlmoIZKZ94szd/PlynZL5844xgkn0h2RcRi1U9HBUAjYyQd
         g37w==
X-Forwarded-Encrypted: i=1; AKwUvByiRvPdYlUduE0CcAl6qGAEse0QdaahR4Fzm1SW+/krjEvG7Wj96CiAEv3VNYe/eK/TdOkMURBERBqY@vger.kernel.org
X-Gm-Message-State: AFuF++kk27W1AUj9NgBWAzkku3usBNnGh7Z+UmzrCUdqmTcpSeM2Z8as
	q9/W1mpjlncyiGX4/t1eIO48drelaliZRQEVFZ72UgsuCRmO5uhJas0Z3yosg/dZG8yw2iEpFJ6
	DXPOBsqJ4dH54D0kPlqtspUncoLeOBPA=
X-Gm-Gg: AYBFou0vy/BG6sbhr4qI0PrptNDTdqX2mf9wE7J7q61WzGN4zNJLVTCQe4uA7NeVXhY
	yVyujRRyugWnNPpL427+yH+a/P/VsqNSE7OwBtp+FD4/jBm1iayRruJnCVaXUd2JeYTz4JbToT8
	17hnr+8qe6vSREOUd8m8oc3rREYTjLsRyzy+o6GIKWcRNvwwknYEHK/fk4U+GoxFdT3RQoIklcu
	koUyKr8d9uDfHjFxmz2sbqTxPFuBxe9pNh8HVb84Zs6a/OQUwRrMo+qz18oT1pTS5lVYuqLMjyJ
	npvDIrJtm/D5bNf9CcQAAIizNJ6ALhBB6Wp+US2fqO0nRwC1tfdsPHEl5njU5XxMn23cpY3YyU1
	CWM2HOpAXSOFsFCwrdyg3JJ6zydPuHUqo9Pxef6hTLyA3sb+NWvS4zM2o6EBTSXsN7DKaZcN6a0
	IQOXquN7e3eIedbakUQZkTKPMj+UqPdrPYBDMBHeBqrMZ2c1IOkfg=
X-Received: by 2002:a17:90b:3882:b0:396:a47f:d38f with SMTP id
 98e67ed59e1d1-39b268ce386mr30178901a91.3.1788901997757; Tue, 08 Sep 2026
 14:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org> <20260908-build-speedup-v1-20-5dc1ac01672d@kernel.org>
In-Reply-To: <20260908-build-speedup-v1-20-5dc1ac01672d@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Sep 2026 23:13:04 +0200
X-Gm-Features: AcwNN1U58TdOwuasMFef5tH_3N3xyJMe8mAu14nPZtzZCuWKC0n_7MgG3XQZVuw
Message-ID: <CANiq72m5C5tNKUWTYYerBt81KtqRLgr-S4c5XLUN1uY5n7mqiQ@mail.gmail.com>
Subject: Re: [PATCH 20/23] kbuild: rust: parallelise rustc front end
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
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

On Tue, Sep 8, 2026 at 10:59=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> A future -j/--jobs option is planned for
> rustc:(rust-lang/compiler-team#1005), so check to see if this available a=
nd
> if so use it.

This is already implemented in nightly as far as I can tell. If it
weren't, we shouldn't add it, even if planned.

(By the way, could you please add Link tags for those URLs?)

> +config RUSTC_HAS_JOBS
> +       def_bool $(rustc-option,-j8)
> +
> +config RUSTC_HAS_ZTHREADS
> +       def_bool $(rustc-option,-Zthreads=3D8)

We can simplify using `RUSTC_VERSION` for these like we do elsewhere.

Cheers,
Miguel
