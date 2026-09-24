Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BA48F82A;
	Thu, 24 Sep 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257505; cv=none; b=es+eCdGu52iYgwNJL2vK/82au0xMWPyndePy4NikJb+1uTKfPh8gMEdY2rwZu8rY9YeUd4TTPxyKtNpJBQViX5ai7Zs4w0+1NEcdtca9cTBf5dKCK3IuAP0JfK5kXpLxWuZeLJD8yIlLgK6GBGwUiUD9stRgoCimNnt4cyoGw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257505; c=relaxed/simple;
	bh=gBLnS3+lAYmZ5kf9JL3anFiz4fYL1hWDBsQwL263l/k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=oeibMymZ2W2JkTTmSlZ78RdaUNhOr0tPA5TKKf9cqLpKH7uLkvlJKEoooX1h/9zSAXaAkWXSYftCUSrLtEnLxbGOD7qkYPDN4TX4oYTnYTqLOPmvQodUBBplFH9ERrexzWsim2c4VQE8vryAMEz25rtyffCEbQFwBCE+ZEubMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=RLDQjDdg; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="RLDQjDdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1790257491; bh=gBLnS3+lAYmZ5kf9JL3anFiz4fYL1hWDBsQwL263l/k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=RLDQjDdgt7QOeFzsZ1IJ2gV5fSFGRDLdlg9Hg8hOOmyV2EaUYEmylWQZ+FbmamP+k
	 9HV4NH3s+lyQW3I1h2631oEqX8jsiRLLD+NeiEvAFJwIds6LhMkPngiC4DpAZuF148
	 rF8+PXMx1S4BlGmJPKxfsSC27sAmhA+jZcky1JOxYk1sBk3xrK7mx2nFDVlwP6F7a9
	 VgAG9vpt9fe4xngdnRoKfDHjNcHMMJSMi9YcdfKQ8wgcK8uOam+rSvOIKBH30ANQIb
	 8qGgu2WsXMnMirt/Gjxf56SfoRE6dGwBEetgfAZn8UcOpCXThvHk37EgDli1ofMjMS
	 Uslygc98EPwNA==
Received: from [2001:bf0:244:244::78] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <n.schier@fritz.com>)
	id 6ab52953-0449-7f0000032729-7f000001dcc8-1
	for <multiple-recipients>; Thu, 24 Sep 2026 15:44:51 +0200
Received: from mail-auth.fritz.com (unknown [IPv6:2001:bf0:244:244::78])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 15:44:51 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 20/22] rust: make exports.o depend on the headers
 generated for it
From: Nicolas Schier <n.schier@fritz.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
 linux-hardening@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260923-build-speedup-v4-20-73128809a4a4@kernel.org>
References: <20260923-build-speedup-v4-0-73128809a4a4@kernel.org>
 <20260923-build-speedup-v4-20-73128809a4a4@kernel.org>
Date: Thu, 24 Sep 2026 15:44:48 +0200
Message-Id: <179025748880.4172706.14868306891021608350.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=501; i=n.schier@fritz.com;
 h=from:subject:message-id; bh=gBLnS3+lAYmZ5kf9JL3anFiz4fYL1hWDBsQwL263l/k=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBqtSlTKzAsNb3KAlPLj0QSENJsIHfwnQ8yLJWIb
 PdD13zZvHGJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCarUpUwAKCRCIxryciJpt
 uGGjD/9ODbOePpr2xjRjWb+mk2Bw35BUrXu5KQ8FyIBaOJfC8LNl3dAG0h/epaiw6+gGCUcqCoV
 Q3pj0r8gWUPb7IFUdyND0fm4NnmizKDSAj1aS/iM+1qF6+KcxebfwTqo6pUukhTKO/1bMk+Nc1h
 sxfRc0hHg8cVc1pw7RfGOYc7/hX0Tdowv6YHivIL+uGvlxZeBMEa0y/udNcjq2yEMWD25XvLqbm
 WKEKwqlOVh/F5nd9/WWCSrQhON7emYprPSD5ecZo8Ymjf9C+IeoxHXELJ/sWNx70XKXS0iDS0xg
 zaThLEGoO3SyycErqFEmC3tU0LcMH9KqgikPrJxgApXyuVZVa43I1zjt2hOPv9Za2Y0nMQz+7NQ
 fDMa084Q7RznP4sbTzAQcMAvEFc2WUAx9FSB/oalarygzJGNR+mK1+IN0jv/Cbso0x/oX5jHNbR
 EA1hTotxHDeyJtcvuvfirQLaLikWABqnJux/0r5MU72ClcJN9WRrxx+/ASsOYEHDCOfI1Xfx3R9
 9UjWiL09yC83csxRGUckCg5Dhi7uDpyAoYEgT4fNNs/H75VgKww6qTGQEHcCHUzIKb4RMu1aT1d
 IQyAZppEid3lBMbaABGYBnrFdZOecoKo06mlo7eC+6mz4OhpE4KG/v+UgiRn2DKgmYHNnizchn4
 J8E8QdflQiGphBA==
X-Developer-Key: i=n.schier@fritz.com; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1790257491-3AFDB965-3EF13F3A/0/0
X-purgate-type: clean
X-purgate-size: 503
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-01  mail-id: 863FEA07EC  external: no

On Wed, 23 Sep 2026 18:18:09 +0100, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> rust/exports.c includes the exports_*_generated.h listing the symbols of
> the core, bindings, kernel and helpers objects, but this is not expressed
> in its Makefile.
> 
> This worked previously because the headers are always-y targets, and make
> prepare built all of the rust crates first, which is an implicit
> dependency.
> 
> [...]

Reviewed-by: Nicolas Schier <n.schier@fritz.com>

-- 
Nicolas

