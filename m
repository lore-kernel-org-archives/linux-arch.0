Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E236384CD1
	for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453938; cv=pass; b=V1C15RfeCj8e5QRJ9fPHlJnbvTChEeH4oAcDxH7j45EFFcdkne4AbFiRwV1cBsTGiud6oMO9+F6y5yLPhVHKe5LNPnFVZ6uFxumTZfOlEp8wdvtw5C0IlXlKfqI8PCedgISm1mnmWZSoRZDZVjzFh+pvakb9d/mgh6l6QoSYhvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453938; c=relaxed/simple;
	bh=kmDAMC6MFeucn2qpBg3Klhb1ZEFA9BC3craQuU4rvac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hixPeLJxXhCslZwtWLeiv1zJRtLxmOxTv5cPG3SUXM4LK4hDDDpICWGQZW6Jg88na4huwjTxYkVWWHPz0Y2uLEx14Ap6EOz9tA32iGhTcOaqhKPCnfcgViakzyCUX3PJ9yw+ZFUPdD6lFHZVGp0FfJfttBj0P5s3fQ7LiuCYt6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5CRJ9r3; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5CRJ9r3"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39da614ab21so476003a91.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 23:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789453936; cv=none;
        d=google.com; s=arc-20260327;
        b=b8FWnhsNAn2qq+bvQOiz9tGRMv4BkERn2Im9EP1UaR4ZoGtx7MC1kDVM1g26kweS9u
         KOEe1BHXSTcu9v5YFQxvGzsklC4IYWRnhoaeUEvBBdrqdAClN+osCQ0jEJRx5vXmaQ30
         xxzFm8vAuhTCcOKYdU360u+GueYhnZIbPAHbxBLvMHOv68rTrYioqk7c4KI2WMo5OoMK
         NHQ6nIvDVBp6zZ+xrXDvLFg9MR4ZD4mcs2f8nyUXkgGRXuaGBCNoHwp9OAJQgANjneZd
         gqGG/0pBX/sPTusImAKvG1PEBFNFfY3iS1NbfHnII5cGVjXfbmguGA5aeqaNBubKFh1j
         kDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmDAMC6MFeucn2qpBg3Klhb1ZEFA9BC3craQuU4rvac=;
        fh=5s94sKf5ZiGmyb2N3XuigYrZXZMrbUIQiYKNHhUeub0=;
        b=cUUVHo4hMlbj1kxNgdbC30RQbLxVvVoodLuDf5mWUK5KhGznbf9im/E6WscC2t7Pho
         TYH/7N78ouWNZpOVTqzBdaIhOk4atQGr/yjxclAppPVVA958AVXoJhmeetMx2j61j3RS
         hnOjdpbqnPhG3zUCNTeU8+qBjhCvEK7sT4II1GC0qlMP/uV/zUG86iLgYUHyocu+vXLT
         a7Fzn2i6bCCqG66xow1HBlUNOBCZgdtqcs3l7VYyGXSFFSXuFCZ1YZcg/efmUl0B1PBo
         bM2pK1VY8vCC1TLPkPyXizc+1XDm0r7b6MtMQkovcmsvosCmS+0KvC56qlIVUJnvNLkq
         oBOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789453936; x=1790058736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmDAMC6MFeucn2qpBg3Klhb1ZEFA9BC3craQuU4rvac=;
        b=G5CRJ9r3yU+mY0l+N74B7S/Mjb6TnQqtFCT50TddgkDTFjmeAX7LKtouzxIblxQu7Z
         h7Z4cg9OQsXlODWiJ4sgVavpB9ZRE2A1fqvhWaI1/oMaUm3ZJIy6GIsgazv3vqM5McEt
         xGkXdE0pqihCwZshnRy0aSMMIslo+uYXDX7ueQ3LEQJU48Z96j4JVTpAVHnxfBhXKjop
         mbYpAvHUDnqE3aI2WoyhirXJaLKHJWQBpEM8NK0EDDeCtbvcdTvgNOOCPFFavZBqhcMf
         Bups1FuNo0+Wrg5gZmFapMkMsrAxt8m5jDvfLJ8SCIT13V3atN0IADBmd6R01ATsyRkn
         s+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789453936; x=1790058736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmDAMC6MFeucn2qpBg3Klhb1ZEFA9BC3craQuU4rvac=;
        b=qMNDStPg2/ysv4AlOSeLLCb6y3YHulZ5N4K9Hvw8LqoymJi4paWRS7yOPTAquCZoMc
         0zMC+BCU2xkTsgEAeFPgTAKG+EtpeSfnLLgTXYQms9JR9arVNNHNgps9dtuw9sVQCRCf
         BxQUMZviMXtHFNUgOLN2YUAHjCGMcYF2wJCkfn5BQ3EuRoUxb/I93JPdjNX/rf5+BWr1
         Xt0iOxVWgFEdDP7+lxMpW7ok1V9PA5ErBVCdb+AmcCzm99GUsQWGhCzf+FHbdTHM/yGe
         ZrjQC+66NtPTggB2oUwNgl/wnyAcsTB7JudxxQSmoEmSQ5IbCpsbBTYPRKIxI/pZF/HO
         4n6g==
X-Forwarded-Encrypted: i=1; AKwUvBxm9ABtQV739hj0e+vROmbboViOxDj0rPgpB7VBa0HwjUCsZziPx0ADMW1+sUTe63YfSG13xlrvFUh0@vger.kernel.org
X-Gm-Message-State: AFuF++mwq48YU+anxu3HVQhpUhkz/B7ylhevzFbwZGX61Q8igtuJToKy
	QDWenhy0y1SAjFlEpeLd6KHj7KBBHmGz3eOVETt4JR6S+PdJMYfqU6rIAyCtgHx8zo3ycr8kyhO
	tYxxOrIavXtsk7WuhMqEMceC75IFeYpo=
X-Gm-Gg: AYBFou19ZC4BLXZraoFzkQUIx25CRIGnzE96nGRBYOWubma4OrcIghjn0mQHpX8wugG
	Dh/YZAXp/KVULQoG/oPSlmVNhFZO9TR43sin5yQBBjkUjNX7owVgJMPksQmd9Zpxkq1Z4ABZIvG
	NPEmJg6hPL+Dk8etILLim5bH1QC4GrjpwM6dnwEo8dZZdXmjQjPR3OLdEMmtqQlnZVYj2hHWt0q
	8+MrXQRl3KL36/V3x1k9EuGuifXhMTGI1yFqVnfCZi8PLWj1Hdq6emxu2m/v8fzv36NVZjnmei6
	O43wbWvjosejafkXFiiMSyrxNB1EGQGugr8LzEls1L0mqHfYYPUC4mCXdrGoqg8see8snIBgotx
	ls5biIYOUHNiGKBrJi9iX9R3OpSFIKMlI4eY3ojlLdslvjvDItuXE7DsLFhsAOnlFSkJuwvUY5t
	OJRrDOwuFm3V+LOLxSPKgbtjNxSYdLN6rS0BS2ph+LgrzaVEfvBQ==
X-Received: by 2002:a17:90b:390d:b0:396:d27b:86a4 with SMTP id
 98e67ed59e1d1-39dec02ca06mr8212249a91.2.1789453935885; Mon, 14 Sep 2026
 23:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org> <20260914-build-speedup-v2-18-39817ec5db23@kernel.org>
In-Reply-To: <20260914-build-speedup-v2-18-39817ec5db23@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Sep 2026 07:32:02 +0100
X-Gm-Features: AcwNN1XuX4yn0GdoJd77RsJx70W4snllWWAl7hBlEl0V9VQzhH3zC86aEhQjx38
Message-ID: <CANiq72naY0=iBaxfbWQaPv_06X4SjFSix4NybDQdht33+Tcs0g@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] kbuild: rust: optionally parallelise rustc front end
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
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:24=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> Rust crates are compiled in a serial chain on the critical path - core,
> bindings, kernel crates and then the drivers - each a rustc invocation.

This confused the LWN article... :)

There is a critical path in the graph, indeed, and doing it in
`prepare` is painful, but to clarify: each crate is already built in
parallel with others where possible, and the fact that each crate is
built by one `rustc` is unrelated, plus the flag this patch proposes
is also unrelated to that.

I guess the LLM was trying to add context to the numbers below, but it
looks like it will easily confuse readers.

> Each time a change is made to any of the bindings, it triggers a rebuild.

This seems oddly focused (i.e. not sure why `bindings` is mentioned in
particular). It is also at least independent of this patch, i.e. it
will remain true regardless of the patch.

> rustc has a parallel front end, enabled with -Zthreads, available since
> rust 1.84 [0] and therefore on every rustc the kernel supports.
>
> It is not yet stable and its output is not reproducible, so it cannot be
> used by default - stabilisation is being worked on [1].

Not sure what it means by "by default". In any case, the main issue
with the flag is that it has had issues recently, not so much the fact
that it is unstable.

> Add optional build parameter KBUILD_RUST_THREADS, which when set passes
> that many threads to rustc.
>
> Observed build time changes with KBUILD_RUST_THREADS=3D8 (rustc 1.98, cla=
ng):

I assume the improvements are most notable due to the work being on
`prepare`, i.e. there is no other work available. When that is
relaxed, this should be way less needed. Though it will be still very
nice to have for full Rust rebuilds, like when changing the compiler
versions often, due to `core` mainly (e.g. I have to do that often, so
I would like it :).

In any case, I am not sure about adding a Kbuild variable already for
this at the moment, especially with that name, i.e. it is not really
"threads" but "frontend jobs" and the flag will not be called that in
the future anyway.

And if someone wants to risk their kernel builds, then they can
already pass the flag today...

(We probably also want to know what the flag will finally do before
committing to particular names, e.g. whether it affects
codegen/reproducibility in any way. But perhaps Kbuild doesn't mind
having new variables that may be replaced soon.)

Thanks!

Cheers,
Miguel
