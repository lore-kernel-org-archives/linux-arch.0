Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC388386C25;
	Mon,  1 Jun 2026 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780347546; cv=none; b=J/eaMYw1+XYQqGKM+IvLqRQ/oy9FRz69nN4ah/+T/WwgG8xpx1oXOtmiF2Kcq7V6LTVsFGQ9ggCh2hgKp3gGo8TJg2/sGPJseJy7TxPxWPb3mkMcEkY5KqpGLQwZ12vzqHxgzNKy818lw0M6fC/imvgfUiv4555SabcOoC67sr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780347546; c=relaxed/simple;
	bh=JSuMB78WGrnAVsJ7teKH/zI0mt19h3G7ax62Fj2NvyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=plFGTNz0M+lvKSLMn6n2ix1XPXVL95qy2avLq0cwLkBD8yW5ySkb7Q2XbwPOF6cSSzSBQONY1JaJ59ulOvoNY31IDPzdzLFbSZE563gsgHEcI5TDrmjrD8Fqzj4vzX0Uv1IOYRQFtgBJr9ZnmfsVb9KHJGipKI36RFqpsKLL09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gTmXZ1PYGz1sGWy;
	Mon,  1 Jun 2026 22:58:54 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gTmXY53gdz1sG8c;
	Mon,  1 Jun 2026 22:58:53 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4gTmXY3vBrz1qqlS;
	Mon,  1 Jun 2026 22:58:53 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id e1EAzhraFHWf; Mon,  1 Jun 2026 22:58:52 +0200 (CEST)
X-Auth-Info: FqnxIDPc+CejjKHAe9u56JUkf8btEszKYhyFrkdtC5LkcdNUzyTOWALY7FYpYrLU
Received: from igel.home (aftr-82-135-83-133.dynamic.mnet-online.de [82.135.83.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon,  1 Jun 2026 22:58:52 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 6F0742C16DB; Mon,  1 Jun 2026 22:58:52 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Deepak Gupta via B4 Relay <devnull+debug.rivosinc.com@kernel.org>,
  Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Andrew Morton <akpm@linux-foundation.org>,  "Liam R.
 Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>,  Conor Dooley <conor@kernel.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  Christian Brauner <brauner@kernel.org>,  Peter
 Zijlstra <peterz@infradead.org>,  Oleg Nesterov <oleg@redhat.com>,  Eric
 Biederman <ebiederm@xmission.com>,  Kees Cook <kees@kernel.org>,  Jonathan
 Corbet <corbet@lwn.net>,  Shuah Khan <shuah@kernel.org>,  Jann Horn
 <jannh@google.com>,  Conor Dooley <conor+dt@kernel.org>,  Miguel Ojeda
 <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Benno Lossin <lossin@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linux-riscv@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  alistair.francis@wdc.com,
  richard.henderson@linaro.org,  jim.shu@sifive.com,  andybnac@gmail.com,
  kito.cheng@sifive.com,  charlie@rivosinc.com,  atishp@rivosinc.com,
  evan@rivosinc.com,  cleger@rivosinc.com,  alexghiti@rivosinc.com,
  samitolvanen@google.com,  broonie@kernel.org,
  rick.p.edgecombe@intel.com,  rust-for-linux@vger.kernel.org,  Zong Li
 <zong.li@sifive.com>
Subject: Re: [PATCH v23 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ
 | VM_WRITE
In-Reply-To: <CAKC1njR+dTdvp+BmLGPtgd8dufiUwBtkQ9a-qinELT_Fmi13sQ@mail.gmail.com>
	(Deepak Gupta's message of "Mon, 1 Jun 2026 10:57:41 -0700")
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
	<20251112-v5_user_cfi_series-v23-6-b55691eacf4f@rivosinc.com>
	<87jyslndo4.fsf@igel.home>
	<CAKC1njS=AHu6uHrH4ae8VxcdEbhgiPXYCAoN3F_mnppBd3SwOA@mail.gmail.com>
	<875x44o9hj.fsf@igel.home>
	<CAKC1njSn_rtCj8ii876PNQTk0nsCTfWsb4DzdymufHVthh1Rkg@mail.gmail.com>
	<871peqgp9v.fsf@igel.home>
	<CAKC1njR+dTdvp+BmLGPtgd8dufiUwBtkQ9a-qinELT_Fmi13sQ@mail.gmail.com>
Date: Mon, 01 Jun 2026 22:58:52 +0200
Message-ID: <87wlwif04z.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jun 01 2026, Deepak Gupta wrote:

> riscv uses `VM_SHADOW_STACK`. It's just very simple to use `protection_map`
> with just `VM_WRITE`. On RISC-V, `-W-` is a shadow stack mapping. It's not same
> on x86 or arm64. So `protection_map[VM_WRITE]` simply picks shadow stack
> encoding. We just ensure that PROT_WRITE is converted to
> "VM_READ | VM_WRITE" at vma level.

That does not explain _why_ you need to make that user visible change,
when others can get away without it.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
