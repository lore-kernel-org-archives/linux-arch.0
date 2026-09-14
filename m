Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162E49CF5D
	for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416886; cv=none; b=CfSK/R6UMbeD97xF2GJXkTwqlhtgoDwPrnMrMwR6LSRI2RU/IZ7LcdC2vtZZYHp8fRWeyqWqH1bpoS0FPN6okZRB2IJLwFCbziP54dpTAV7utCfNaG01zqg2mRzOje0kVcIMreDPiz5OiQlHP7NB0nLED78R8ch6dPaXltTW7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416886; c=relaxed/simple;
	bh=g8JbSv2uB9OVHPX6mK0/xKaLA1R5JXVM4OnU1gOEgUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZPQwR1F2EFLl90crm1Ix8HTxzA6DCUPcHmN3U9WftEVb3L8M+EJ2ypu7F5xyrxWVLrjH1YbPiy+Po1jsGY4SltB+WPBTAUqbZFXbDBpYKtUP+8qsAkwKvVmYA21sJQVf7WG6jcyVlHAPxYnrwq3EfsQgwrUC/GyBTyNYuWRfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ss5XWqr0; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ss5XWqr0"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe5so361433266b.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789416883; x=1790021683; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FhpCYoKplrM1IaRlncQiHxwpj03BaeP0oenEDpXOAEg=;
        b=Ss5XWqr0nA5JTTJ5PlCaz+DVJp0Bx+9jcUrKDMioCzymlAh3ZXiBucaolOe1jNSgGj
         IQozq4INgopg60Ot4/OcPILJvbAXvr8Z5TYzXc4Kh6/nR3my3Npi9uNt7g4bNPdME+yK
         lUk3VW9ktmmxL2SA5Wx3VKV44KYD1L4MgwepM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789416883; x=1790021683;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FhpCYoKplrM1IaRlncQiHxwpj03BaeP0oenEDpXOAEg=;
        b=r9Y4zEA0N0zaOn2KOR0e62kMTCKv6S7jhf0U0syyK3qP986OZ5bBIiK/q+BwzQKSEt
         ytqWhNvFY2XyeS4d5jKNiI1idh/EeIcSowY9IBZz/D1W7x575pOh8LiHdJ+QM2fdj9Ce
         drBS4YKHtxzEdi/2MsCNSF+nANTy+5sfZ049lMqj23/MCXLu42Xh5bz///Vbg9fIaXs9
         8pNt/kcBskFDyqoUpNNqeoPtXgeoBHMwbh4t5y2fskvpJyyREpXcboiagMMWr98tUQR8
         LxEY1/NtVwHpq6zvSiJvpD8A9EXwfmAxf6VYA9YEboQSKTITrsDFT0T0j93qsRqFHTiL
         RxBg==
X-Forwarded-Encrypted: i=1; AKwUvBzl4Ah0RcczUzHaTU46LTqT77zrkfj8+4gnEa0G4a7qRMviJfULwD74h02QHsYx4h8EjKlHdr5SyX9B@vger.kernel.org
X-Gm-Message-State: AFuF++k4yY84K5mcM5U9YBu/2T1pWyYHeTSkHWIXt0c08s+K8I125ozw
	n0Cug516Urcx2b/ndxjiZToVn+fxIxKlJ/2CPn29BD5FCbfFO2MbNGY050Dw73QgGrXRd7IaXRK
	WqF7gs6JipA==
X-Gm-Gg: AYBFou0MrN1XF7/kJW8T7lRp30HofD8hYIwUU5r1o6BjnZAWoB4mAjtmJc5lzHH8WnO
	pMLQyGhppUOdPmC2UgewYmHRteWULNtBWUmE1xIjzG5nQ3cCeFrdzwi6CwNzBm1l3EqCFd+U/tx
	ExE+W4vgLrv+hK7LwrurzGvcg+vi9kxNUpfYb7itqoWV+mxTVfow9xBqNClCBaVA0v88CPin2On
	7P7Dua+TPRgLwOi7WkL1F8giU4SFCHGioAbqRwDgxf4P1KKlvssFbu3+gvdZP2z7vLL58EkmCRx
	zwHpYnLU31QuwOr3lD4ZB1ny/f8gaI9BL2jNGqh9HrksLlJy+dPjwCdQkV893yhwg+dmD2oYe5i
	J4h1P0lAmK3vL9apBBvT/PPoqRZtLX6EopPuYt80tAyldlyd+ysmLAkYs4EO4iglYqsTmwfmrWc
	uSXsQo2cx1RWn89+/G0AUi2wQyf/ddSbeHXstvadTfKKJdiwHk7HR90mMxvBnagcVzqe8Xceg3N
	fXj1h9xksgoG3VauR7Dn3KUbUgApCe+pKzmThR/PbJvzQho
X-Received: by 2002:a17:907:97c7:b0:c1c:4e36:eec6 with SMTP id a640c23a62f3a-c29b862a3c4mr277695966b.18.1789416883036;
        Mon, 14 Sep 2026 13:14:43 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660ead51sm479086566b.49.2026.09.14.13.14.42
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 13:14:42 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98505364aso3751758a12.3
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 13:14:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy/zHBdrZ8kcA1jmMAWGlpw9VEsedGNftlJGKXshQpu9WaspFSYMCJ+n9pVgd8ZoVsTAbl4gzjlBtja@vger.kernel.org
X-Received: by 2002:a17:907:6d1f:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c29b84c9a48mr280688866b.3.1789416413732; Mon, 14 Sep 2026
 13:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
 <20260914-build-speedup-v2-15-39817ec5db23@kernel.org> <aqhLhVMkNzf_4oJw@jpoimboe>
In-Reply-To: <aqhLhVMkNzf_4oJw@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2026 13:06:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB9MX7vBDQ+WHTUVfSYubLhR-PbABewscqTsxRhg-LbQ@mail.gmail.com>
X-Gm-Features: AcwNN1XwkDuRyfqGBvPSv1hGEYJIl2TPFZFoOf2g9mdtKKeoU1aAJmlE5veL8PE
Message-ID: <CAHk-=wiB9MX7vBDQ+WHTUVfSYubLhR-PbABewscqTsxRhg-LbQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] objtool: cache relocations, do less work
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Mon, 14 Sept 2026 at 12:44, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> BTW, I found another initialization bug: klp-post-link.c uses
> elf_create_section() to create a reloc section, so it missing the
> initialization of rsec->hashed in elf_create_rela_section().  But that's
> moot if we just get rid of the hashing.

Talking about "getting rid of the hashing": the instruction hashing is
obviously a big deal judging by the hash size expansion in that other
patch.

Do we actually look up all instructions by hash in the first place?
From a quick glance, it looks like almost every user of "find_insn()"
is looking for just certain *kinds* of instructions: calls, branches,
returns, endbr.  And branch targets.

Maybe stack updates? I didn't check.

Yet we seem to hash them all - even if they are just some random
ALU-only instruction that is in the middle of a function and never a
target of anything and has no impact on any code flow.

So the question becomes: do we actually need to hash those
instructions at all? Are they ever actually looked up?

I don't know this codebase at all, so maybe that's just a really
stupid question. Feel free to look at me condescendinly, shake your
head and say "Poor Linus has lost the plot".

[ And yes, I see that whole "next_insn_same_sec()" thing, which
obviously *does* look up all the instructions when you iterate over
that function, but it strikes me that using a hash table for that is a
bit strange when the natural way to do it would be with juyst a
"struct instruction *next" field instead.. ]

So if hashing was such a big deal that it showed up clearly on
profiles, maybe the answer isn't just a "make the hash table larger".
If a "next" field were to not only make the hash table much smaller,
but also mean that next_insn_same_{func,sec}() would become a "follow
one pointer", mayeb hashing would become rather cheaper?

Stupid? Or maybe "not completely stupid, but too painful to change"?

         Linus
