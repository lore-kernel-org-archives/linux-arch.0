Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5716238C3A
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959159; cv=pass; b=HG9Ett10wrMaCddqM8paeBiYCvxPAudfI3IVxqJEF7xzSYpwsfO9fDJKIVw7SrLebilitt8/NFHhDPsdcAWLKOBt4nhblDG/w2xEfzRNzv2HEggz5gjCWd3Kr9Yc5W91GTqktdtjxkLr9s7nKCfT1XInpHkKKiC4w5wEVfn9bGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959159; c=relaxed/simple;
	bh=ShWRak8oUy88OSaopaw+aLPDpDo1ZpJd6cDyp++LarM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCSqNRzwFZ2QnmUQu3B8yI7IfIRHAOR8EQwgtmbCmhTF+Oa3+l3C3xfPweBpjrC6UEb5H8KSilTYKZi05dsC8D8BsHKmpJ27uVEXVisSy1yp5p9mZfGec/9NDpYahUsYzGm8WOzcSpscTD92ZrVz4knXzcz19DbX7QNteYD3rUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=A5BCDI+7; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A5BCDI+7"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b876f3f603eso992424266b.0
        for <linux-arch@vger.kernel.org>; Tue, 20 Jan 2026 17:32:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768959152; cv=none;
        d=google.com; s=arc-20240605;
        b=ThLmttC08fKmi2MfwRCgJD6DsKyMPx1dEs9Ogk1xyQDCgLCq5EC/z3PbQpwqFAHZ+L
         a15j8jZUpp1zc4wbNgdnz1oGhfOBNP3zGzJO0uTNYdsqq8aOjyTm+nIWcrg/d/HFH5tZ
         EbV3gCZcCHFPlpwGeATVH5LgNEjc0D4aqR4EOZbEzgN5Xf0N6gMoXllOTRzIVA7JLimT
         BxIdahZqZdMOkybPgyUf9LhNK/PCkhH36sQL6wv2YUUoHDE+5Ihxg7l4sFILrLtyNgQ8
         K/vutAbQklWbkOWWNnHnMaRekCuVuWGirqvWhAekU/J/PfPrN665XZFl4Z6IDFQ14+Gv
         vcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=phhznUg1me3aMCDh6RtpPgdrBfYLQTkKfqDDafoKBZI=;
        fh=C6VcfiSlP4niEGohfyFoIVQS2XMlQR29t7iQGyMHTaQ=;
        b=Sfeztdbt0BfQ/MfmCHQkF5s9wY6TJgKyBNGTU285RE4YW3kjRnTSYpi51a+6JHqro9
         DIbleDdXpCGRNpPELDoYwq1uz/mNP7pVIba0ZMvoN5r8+VGUmOVBIci8jm+tleolquzT
         cPggJqIsdeFRrwT/jLq4X2DuQH0bLICEM25s4PAIuhgs5u4h0l99njgVH6ejMisMuvJt
         MgtCN1XiNM88LQSCBX1NYB9MvBS8MxvKSkDmXRO7k3y76IOGMOcxrITE01CLOy6s8Sse
         j+74WJRlJrUscNbeZK/Dd7IfYLkx3wfsF4HEoKYbirQYm3HcHdJtlfUOR9LgwLcAE8u/
         q6IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1768959152; x=1769563952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phhznUg1me3aMCDh6RtpPgdrBfYLQTkKfqDDafoKBZI=;
        b=A5BCDI+7uaow+L1pkR0/vhbZZn6AJyq7brkzi3g5PXQfBD4lA4/eE0X3H0eaNyQ9uI
         BhpW1W5q/SgcOo9bLiXBhGEOuJjNOLdsgI1yomjhhtiMc4yYgjkRRCEZEjOgjfqf0UZm
         alaado9gHlyuyjKWjd2TKsKjKgLfd7fX9KqgYnaBHFx227Fx+cmQlNknKxxjjBc6MhHc
         tG3tvKjpIj28uMUF7HVJL7ZayB6r9Ecpz7T11yD3GxnJ2kYCvSe5zS/YTgO0OkPIEynl
         85aax+WRhLPNanwVxq+Dtb0SSQHEK2jnBzPJpDYm/K1qIbTkzVoB1lPQoyDUEHDmqQ9K
         uN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768959152; x=1769563952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=phhznUg1me3aMCDh6RtpPgdrBfYLQTkKfqDDafoKBZI=;
        b=mhywYJuiDa1NF3eDYxtqPHxy3GdkKkMgTNsQAoQcyamZJwS7LNFWyQ9OHYggI4re49
         SbPXvz5I2+rFwZuzH4Bb69u33w7whCfqObg5G5+3IaiPNNcXp0w/bNKe4/vIFhZSpuIA
         bU1+5qd4LeYtBCKwOXHJ1fGL7LR3tIahIZl60D+ZGC/KJkoaUbaGgXyjaedhWPZA00jj
         yg8yFOX2StiSf5fL5QWzQ9STFAFTtKhE6IUdQXbABUGKKsmSbvj8uoLV2E0edxmHBaJD
         ln25CoXb4YBQSOIKfyI5ut+M82g91ST6kn+fZZWDjlpDKx6VJ/+2OeK11GiDgi4bnb+K
         qUog==
X-Forwarded-Encrypted: i=1; AJvYcCVUpaaqGr4Trztcl83ye9q0gDkEQU8kjBlwrLqg99oLtJDuHy8+acHOUGe7I1FtZ31U+Ry4HXZTTHur@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGlziexevtMfvnEx1kOfqBh8R/QC4wwMrJdIdwOLMwSTnO8DY
	A6+xeQ8eeGbBZCZs8OJuCDXMvVdwFDri5JH/JYc1lcSE6dYCrGEDnj+9TO08JcGLDmj6wpzgW0Q
	e1D+na+PYm0a3o0AlztypFeIjqbwlLkMaU2adu9dzDw==
X-Gm-Gg: AZuq6aI6X/3ICfDWL3f+tsx0iwkP2d3lLdhncC/mxOgMHfN4aT64pxfdu0MDmizCyo3
	+jfISDwCmAgP6Yh0Zp/sjX0oKstTp55Hf7YPHPb5LyjjG5fVe+OxaOQO88DTxqmjuM/x360u+7d
	dWc5LmdF4GwC79ZjY9MmIWVuIab/fJRs6bYRorN/gG7v/EFFQk16TKbmu3H6YoCb52geDEDNWgx
	VnHpdwS7TsFfqCcA/MU765585D4NxlBismnlb8CX7g9Sfrkptf958tqh3b6gJbCHpHmrV403A==
X-Received: by 2002:a17:907:9488:b0:b87:7634:b20c with SMTP id
 a640c23a62f3a-b8796b215a4mr1301363166b.38.1768959152268; Tue, 20 Jan 2026
 17:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
 <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org> <aTxf7IGlkGLgHgI2@debug.ba.rivosinc.com>
 <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
In-Reply-To: <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 21 Jan 2026 09:32:20 +0800
X-Gm-Features: AZwV_QgpJ38WsQTA-JLh1W5jk7su1plcAErfmIKl7ceT3yMsB0wZBJHvBBZ5Ujw
Message-ID: <CANXhq0rpjSvOThACrB6_MMc8S34--xJsUYZ+HtMu1GUNyk8zOg@mail.gmail.com>
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
To: Deepak Gupta <debug@rivosinc.com>
Cc: Paul Walmsley <pjw@kernel.org>, x86@kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
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
	richard.henderson@linaro.org, jim.shu@sifive.com, 
	Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com, charlie@rivosinc.com, 
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
	Valentin Haudiquet <valentin.haudiquet@canonical.com>, Charles Mirabile <cmirabil@redhat.com>, 
	Jesse Huang <jesse.huang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:10=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Hi Paul,
>
> I have a bugfix for a bug reported by Jesse Huang (thanks Jesse) in riscv
> implementation of `map_shadow_stack`.
>
> Should I send a new series or only the bugfix-patch for implementation
> of `map_shadow_stack`
>

Hi Deepak,
Not sure if I missed the bugfix patch, I couldn't find it on the
mailing list. Could I know have you submitted it? If so, could you
please point me where the patch is?
Thanks

> Let me know. Thanks.
>
> -Deepak
>
> -Deepak
>
>
>
> On Fri, Dec 12, 2025 at 10:33=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >
> > On Fri, Dec 12, 2025 at 01:30:29AM -0700, Paul Walmsley wrote:
> > >On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:
> > >
> > >> v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shad=
ow stack
> > >> on MMU). Used b4 to pick tags, apparantly it messed up some tag pick=
s. Fixing it
> > >
> > >Deepak: I'm now (at least) the third person to tell you to stop resend=
ing
> > >this entire series over and over again.
> >
> > To be very honest I also feel very bad doing and DOSing the lists. Sorr=
y to you
> > and everyone else.
> >
> > But I have been sitting on this patch series for last 3-4 merge windows=
 with
> > patches being exactly same/similar. So I have been a little more than d=
esperate
> > to get it in.
> >
> > I really haven't had any meaningful feedback on patch series except sta=
lling
> > just before each merge window for reasons which really shouldn't stall =
its
> > merge. Sure that's the nature of open source development and it's maint=
ainer's
> > call at the end of the day. And I am new to this. I'll improve.
> >
> > >
> > >First, a modified version of the CFI v23 series was ALREADY SITTING IN
> > >LINUX-NEXT.  So there's no reason you should be resending the entire
> > >series, UNLESS your intention for me is to drop the entire existing se=
ries
> > >and wait for another merge window.
> > >
> > >Second: when someone asks you questions about an individual patch, and=
 you
> > >want to answer those questions, it's NOT GOOD for you to resend the en=
tire
> > >28 series as the response!  You are DDOSing a bunch of lists and E-mai=
l
> > >inboxes.  Just answer the question in a single E-mail.  If you want to
> > >update a single patch, just send that one patch.
> >
> > Noted. I wasn't sure about it. I'll explicitly ask next time if you wan=
t me to
> > send another one.
> >
> > >
> > >If you don't start paying attention to these rules then people are goi=
ng
> > >to start ignoring you -- at best! -- and it's going to give the entire
> > >community a bad reputation.
> >
> > Even before this, this patch series has been ignored largely. I don't k=
now
> > how to get attention. All I wanted was either feedback or get it in. An=
d as I
> > said I've been desparate to get it in. Also as I said, I'll improve.
> >
> > >
> > >Please acknowledge that you understand this,
> >
> > ACKed.
> >
> > >
> > >
> > >- Paul
