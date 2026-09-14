Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9A415B6E
	for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425499; cv=none; b=N41GfIsIulCkyWFVJRBSuyOlhzr0RxgCIx4MdAhGu9rLVPvcCilJowpv0ak84wFag3iIiyrOOcUYTua0OtgAK+D3nGT/ZylM2YigbG/85g4h6OZ9pfraFy3tK0xkBtqYkxVUtRaca332iNWqhYAmoineCKGNI88b2+H2zy0Twn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425499; c=relaxed/simple;
	bh=3pbB/cdA2n+mw9ojxn7xAJ0JjyYJsv3yomOKFEBUOog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAbFK5Hr7jYr6BrdE7JtCL8NxgVsY4gyMleKav5qIdFAiAUxRq+tDvIIEFsZjlzOjwwRQXYmdrCt7lW0YxzOnriYEq7yqIKMSBHAMZOJCpTfRJjsxT2NYXOHGUWJGKh9rFieRPfAUqiDD+PSd9HGU52Iu1ScR81m28h71IIqgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WNIzDr7d; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WNIzDr7d"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294496989aso460351866b.3
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789425496; x=1790030296; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doHeCbdvroV7mGBSmqv1XRXXxfYTXe+sNzLZzLwqdyM=;
        b=WNIzDr7dHVS605wIbL9JqvX6v6vvi6Uf1AEkziiBH2gHB2LMe50iQh0KgU9+sj7S4A
         9//ygVb+brb98v+TUilmT4tacVl+fN0isMGxkyQESu+xtWKBkOA1W6rqQrnrOVgzdD7y
         taGyHa/zECvj+9gdQ1mroq3FhgAaI2l632Vdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425496; x=1790030296;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=doHeCbdvroV7mGBSmqv1XRXXxfYTXe+sNzLZzLwqdyM=;
        b=i2hRNh1mjO0zDyKeiK3M/AsUTB4AZMRnrG3VWgvyzqAm7cDsIFMYYcCynFVHzLSahH
         EZoYENCjv5CMSaZK2K/ICcAISB2G/Nxv1Z4BxaczViO+YBBtEG+rrUWHwwWrvYHsUbLC
         LwMJuGwdWVhhjrHtmlXMKlZCBZqrtiTZ/J8sh9miZc/hbUDyoLQ7WIbAtKleOFzEXoC1
         DIcMjZW6u7aZH4HwxMnTzUciZBg0zNFdb4TJvFrtlfeDd3qb8wbBgUHM1Tfo1kXyde8I
         ycHVF7Uq5wE6Wc/t6hveXzdN0Fda05AaiV9BbTKQgSa9cbjIi66i/Ffl2f6s6lL5jLBO
         WIkw==
X-Forwarded-Encrypted: i=1; AKwUvBwW69DHRdmux6HsTKvB52oTTgnir2UT8PBAiPBNJGsPe7GbdBYwbCqN6UHoIeaP+H7ismKTusXc1SZx@vger.kernel.org
X-Gm-Message-State: AFuF++l084v9UHj/p5zMvP0vhTvP5HIMVMb2mNZleaVIBGzGNdLgmNvZ
	8HqchT2tt2Efs1fnz0MfHtelTfj7iLSBR5GDUHDqAhoJLuDCl+oUhckbtSt3eTLalvMWaj1sOWo
	nSuSOqaoZEg==
X-Gm-Gg: AYBFou03+qg8L928UURqfgb8YkbqTXzjtEmdu/t/xfVV+M+MtIovHRczdi0/7RE8Bd3
	6/NRWA/QNQ1dQzmUkmdmN2yXoYt63wx/WeOyfdlyi7FL3MPto3zv6lefbC97m5TNFrcjQtErziJ
	JhQDoaH+pcogKlfgRlePoFpb6QRpMhE4TyCMc905bNL94oWP48J7AeqFgGrnrUlPbhq7WdRMrK5
	niWgv6ovcdmsPHWYciCC9hioFlLIKnYZXH3eZTAFW+BtMHU9sl2RXpyA+w3OXN6W5MRwARAqKJZ
	vyvJYAVC69yf4xwprA5aP/8Oybxn/BMS7CU679UfcO7a2xn2OD6Ya09KNFuTC2sH2/h0quOxGJp
	/2XJ1Dupbf6aOjs0Gfqqsy/ydeYvffcC2LpjoypQKDPZooQAZl/rwZjZ9s1mjPPsXRGwVtvramM
	ypN152jAeUZNFBWyq+smgknpqs67CDfWNVE9McwYy54jwNasEe3wLI25rf+QZeJljnqOwmFrk45
	5J3Wevm5u3Z3yM+G3TGi/rK7JCcj29ggRj/hbZ5aKxXTBJJSQ==
X-Received: by 2002:a17:907:3e8c:b0:c26:1648:a075 with SMTP id a640c23a62f3a-c29b87d8638mr297895566b.48.1789425496362;
        Mon, 14 Sep 2026 15:38:16 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966066b6asm477805266b.34.2026.09.14.15.38.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 15:38:16 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294496989aso460349966b.3
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 15:38:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw0bWOuydBqd43zwySBw+Uq323g9hIWkRkTNz7bAPms0f/npZ817pWYd2N2/KlHSEn3YFcwZYqFC9Pu@vger.kernel.org
X-Received: by 2002:a17:907:97c9:b0:c29:4415:2ebb with SMTP id
 a640c23a62f3a-c29b860109bmr315536666b.8.1789425035842; Mon, 14 Sep 2026
 15:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
 <20260914-build-speedup-v2-15-39817ec5db23@kernel.org> <aqhLhVMkNzf_4oJw@jpoimboe>
 <CAHk-=wiB9MX7vBDQ+WHTUVfSYubLhR-PbABewscqTsxRhg-LbQ@mail.gmail.com> <aqhmhmgrnN3Mw8yG@jpoimboe>
In-Reply-To: <aqhmhmgrnN3Mw8yG@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2026 15:30:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3BKkCYtmfs5sORF_+Oumv2Gc8D+YxkMp9W2-mvLS=Ug@mail.gmail.com>
X-Gm-Features: AcwNN1UnWAKTndckmaJ94decAtfrWRGA6P58dk0oXtHcS9ajgGc6O7ZKSXjYJOY
Message-ID: <CAHk-=wj3BKkCYtmfs5sORF_+Oumv2Gc8D+YxkMp9W2-mvLS=Ug@mail.gmail.com>
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

On Mon, 14 Sept 2026 at 15:23, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> There might be more efficient ways to structure the considerable amount
> of data, like replacing "struct instruction" with "struct basic_block"
> or so, but it's hard to know whether that would be a net positive.

Yeah, I was thinking that you'd only hash instructions as you find
them if they are obvious "I need this instruction", and then try to
hash them *again* if they are branch targets (and just have a "already
hashed" flag).

That way random number instructions would not be on the hash - unless
they become branch targets.

And you wouldn't ever really have to track any complicated decisions
(like that whole "basic block" thing - I agree that it's painful,
because the shape of a basic block will change over time as you find
branch targets).

But not a big deal. More an idle thought brought on by that other
patch that changed the hash table size, and this discussion that was
talking about the hashing - or not hashing - of sections.

So more of a "if it is easy and straightforward" kind of thing.

             Linus
