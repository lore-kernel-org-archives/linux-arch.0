Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA3306752
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336674; cv=pass; b=W+d7WixGaqe22lH73lakxmyKmqsdL3ZEPRmEZs0NiFgKvt1Mbgo81moJf/PkB08YRYed9C7wN2+zjUglH/QnAk3fMqcFpE6tCI2RcI6J4vT/L9mDVgx43NiwMhnXpM0YxHIzH0XGc6F1j2Y8aFAE3Yvp4UxSeVBf9kLmSNHGSlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336674; c=relaxed/simple;
	bh=jS/ZEKJo2ddAZIP+307JZp0uZcdcPAaQg1XEpdiajmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrxTNcN8YJv0v0b3FIQC6LGnrtoLZeL45NHRWxutJV64AbxsZLzTp8TgHfZao5w5Du+8XmvTn3G/AaXdQvzxPfe7TlvfrrN8JyN74WF/WNLJOm+JvcCskQ1mOm1skiMBOTt6DZ5iYXAYa71OVLseRpOyCtex6Mp5M4xVbJtPSV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Y8gObGVn; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Y8gObGVn"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e2fc11088dso14444137b3.2
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 10:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336672; cv=none;
        d=google.com; s=arc-20240605;
        b=Actlq9CelKvqjKXZqp86aA02fvJ3N3HgwXLXFNVB1Irsm5YbGoVmIBkaJJ1i+04LLJ
         J/GPwB8jmR3GDVs5UVjzYyqz+r8EFyIaGo33SlsacDz0T5ijT43Jhqju/3LzneVZe1Vh
         BYJ20PRhVgbyjBlf/6G6APBq13r26cGLUQnF2yaC672IT8FelNbAKC7o2bRxUm6udHI9
         Ll1xyuRgE84D22qDOnVJFT+Tbdl9Dh0mknSzJRInhtWG18f53H+k4vuzPENSMRXgcel/
         mM2IE/TYkxR73QRVRoJjW5y5D7+km7WFq1N+qRzQrw1NzyTftxXThHKyDAVuTbOhusAE
         zvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FfE0OEt10KoqyrBxkVX83evIZS2y+17Dt49yMyisaOQ=;
        fh=oS0QDaKq2N1IqHT0Z0WTyE0JPSEWpp1FTQdvMIlbvVo=;
        b=A6E0JFJZe7vsAUBKUH4hyADE6SCwxWHEBC4gcLvfvKj5m77dSf2Gp4kXv1dIlK5gcC
         Geh4rwgj8NVn250XXHFe67CTn5DpqIgCtlKTXGmgyFxprz9pEC/peZb2M9zRlDbqp3jp
         e1r2rAT03bXDB23hE03nJwWmp33f5xCAboH2VKL5JxG76+8A6E6qDxKbb7tpu3zoO01D
         mW08Ae4OFhYnSnJZzPHBLQZ0XxiUJ/CkgMWWQy4d9O7lzYsj9wjQ5Sb622J12xTg0pbo
         pOTjs1YDxrCfnWq868YSGG3oklrzo6YvDadJiHNbks0FYO5+9XNnps0wgablcwzK7yRG
         HPmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1780336672; x=1780941472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfE0OEt10KoqyrBxkVX83evIZS2y+17Dt49yMyisaOQ=;
        b=Y8gObGVnIQEkypCR7OU54mIgGNbVOHe4Lc+1yn54ancdyLNe/ih/f4zzt4VmsHT7EB
         RcPsTBQfqLYFQ6z9qGGt6Hnp4NdvbwA1OzEBLeC/STfKaFf6nQgEoDYPf1ZdUW9tXXYj
         wK6bHimi4TPbAe2xSk0JJgnRZupzA30ZYcNUazyMd5RuTQQ4xAmpSZUzzsyxW2d845tZ
         JeGBx8MP8Ex75k/0VfMVmqYFjS+ayM+mX3glfVuyIGxADVqmHlK2DF/NCYjZJNrQhBfL
         1lgIuk4qmCInUBEv5T1GCUMJs7lsB0TUmfS5l0zFgGPja4SnPZO/pZ6g4p35D2qoPDIM
         mQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336672; x=1780941472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FfE0OEt10KoqyrBxkVX83evIZS2y+17Dt49yMyisaOQ=;
        b=e6uaVJPN4Zz1R2WiGOb5PAm9Vbm+1Wtrl8QKfeApzBT4BFa0hH9sUkZMEUKR62P9Ch
         5HoAB8nrfpwMfzpoRUzRHu3gSEncliy0umvBJLE9TOGXLXyq3g3Vt0q7D7fB6Hc0uMYJ
         xeDDYVTw5+RcE3kWZjg1sVn7KMPZH0xxXDuh7tcFZ2svQmfEgLrDiHj1GvuJcxgpO2O0
         pAM314ofFhZ0lNI+4T2laEecAe0zjoYcAh29o2c7zG1CT9fsxWg3EI24G8eAYsr0bIC1
         bB+ERNS4V2Isu9YNnTLyQ03Xqfxdj2BGt1fxkB2kvonBbOz81N8w+BTekwCkU8HaSmYb
         ndig==
X-Forwarded-Encrypted: i=1; AFNElJ/H9kyipHk+VBfOmZ6vkMADQtSHZ96TmPs7xd0yJ0DVUJpJVqAQSKwJmFWMoHK19/s7NWmCTNLM7RtM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw835xbPnBYBJdPT7bwtkD2Htu7nbjRr5yA66T6XJ3rDry5rWP7
	GMuWfAPJFOtQzFxRTtw3XgLYUNZN5x6g3T0B2PIG90ox8G/DxQR75gzWhvqBWtVwGNcXOYAe8jm
	zbDd855P5pX9H8D0GQgU4qH+nXC1gMcS9f56ebEYxpg==
X-Gm-Gg: Acq92OGrgeKjLhQVwJxU2SmcXRNac58Nd36MOLa1KfWzIbi2J/Q8+tuHiUVNPe1rm1i
	aV9oAyarc1NvRgm8RyA+eZd/PA5KLl0YthjhZiVwl3O9yggM+TB5/2BUr71xLwNdQI1xjG32g2F
	rxA0lKbGzWxSJcdeLEXryYDBdMYNJz3Xxwn9Phf4Etyij0G72vEFGpjMj4Xmafa2DP4U9hpwdPm
	Ax3T1ORlbOHblIfd3LChqGLYqfCcqjpDsPM3D6kJFDFmPb4KtZbcCZ1KyDxZ51m5mVSS7k7nGjn
	YkfUFP2HuJuone3rz5qMhx8FRzldLcldvitBHafMypx4rSYK/e4=
X-Received: by 2002:a05:690c:30a:b0:7be:5f3e:5309 with SMTP id
 00721157ae682-7e05e853e5amr107636127b3.38.1780336672104; Mon, 01 Jun 2026
 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
 <20251112-v5_user_cfi_series-v23-6-b55691eacf4f@rivosinc.com>
 <87jyslndo4.fsf@igel.home> <CAKC1njS=AHu6uHrH4ae8VxcdEbhgiPXYCAoN3F_mnppBd3SwOA@mail.gmail.com>
 <875x44o9hj.fsf@igel.home> <CAKC1njSn_rtCj8ii876PNQTk0nsCTfWsb4DzdymufHVthh1Rkg@mail.gmail.com>
 <871peqgp9v.fsf@igel.home>
In-Reply-To: <871peqgp9v.fsf@igel.home>
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 1 Jun 2026 10:57:41 -0700
X-Gm-Features: AVHnY4J9AUNhuz056EYoPs-ULzO8_fe_9tgwbVh_N3bHNsdR65FJv6ifxqCKuXk
Message-ID: <CAKC1njR+dTdvp+BmLGPtgd8dufiUwBtkQ9a-qinELT_Fmi13sQ@mail.gmail.com>
Subject: Re: [PATCH v23 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Deepak Gupta via B4 Relay <devnull+debug.rivosinc.com@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 10:10=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
>
> On Jun 01 2026, Deepak Gupta wrote:
>
> > This was settled when x86 introduced shadow stack. Instead of having
> > new `PROT_`, it was agreed to create a new syscall for mapping shadow
> > stack memory (syscall: `map_shadow_stack`). Scenarios like `clone3` or
> > co-routines required manufacturing a shadow stack, thus necessitating a
> > new mechanism to create shadow stack style memory in demand. Instead
> > of having a new PROT_ flag,  a new syscall was created.
>
> So what prevents riscv from making use of VM_SHADOW_STACK similar as
> x86, without the user visible effects?

riscv uses `VM_SHADOW_STACK`. It's just very simple to use `protection_map`
with just `VM_WRITE`. On RISC-V, `-W-` is a shadow stack mapping. It's not =
same
on x86 or arm64. So `protection_map[VM_WRITE]` simply picks shadow stack
encoding. We just ensure that PROT_WRITE is converted to
"VM_READ | VM_WRITE" at vma level.

see commit message

"""
Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.
"""

As I said other arches have a VMA flag for shadow stack range but PTE encod=
ings
and overlays are complicated.

>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
