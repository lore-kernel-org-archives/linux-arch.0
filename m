Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB999293B75
	for <linux-arch@vger.kernel.org>; Mon, 26 Jan 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460209; cv=none; b=bsFfDVKfbPcTZKgXMNkiWTUlg8sFyJ0Jbddg6dHmPDVJTo6pOIjwkCifIgb9xTs4jIPS0u526nmsJswWh9v+8IRx/WrCkzlU0tCaKBe8J9OrbEYN+2MYHrfef5UMnnYyuiQKybfNVprEsL6AMBHMAS0StRZyncm7lbOIKGhU//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460209; c=relaxed/simple;
	bh=2ImvZniPDzFetnyqCWbg0zblKqhE8c/sMpTgsU+ZG+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2PyxwHqRM+bQt3IhAib14fiHV5Y8yNR+6EsYttgGsDrsydPeUlAri8F68a6fWmGtLRu9/FXpPYlA9C0YffkDegqIzoC0g7d8RbvXPlkPNiClzcPT8V48Yt0DVYsfzhofL7ISmVeMRIsz4dgAD+Kq2O46+INS7WYLQBjxJAZn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=PXJ9VFxS; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="PXJ9VFxS"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b70abe3417so11178390eec.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jan 2026 12:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1769460207; x=1770065007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0UipC5QHyJnTmDWXctjUpxhkNyTA6jh9RjXD3Q3T9M=;
        b=PXJ9VFxSjyN7jT6HpQvw3Be1870o/akPKIBYteU+9y4pc4JKWkWSlVVZJG9svjhYaO
         QNQltekxPSEKZz3E8CCa0xhAMOBANuOOR/9BQ7se9cqNTA73kBz6rwlKM3hKE6P3o8jP
         /2pNwK3HcvKn9B8LBxYSHqfcHaOS/aDi2D0wf2orHCgBR2VymuZRj31zkzLDvv2MTTBI
         fBk0YnCYiSx2YDhTvdcnPzdGpjep8uf7u/PBeVG76moqqJ+7dkV5G6nBf/UugVGQ21el
         FGLUeoqcTFBfToCiDMTM5w7Fu+FbZczcDLz51FQymVRGNfcQKrw6r3aMskOgYdoHfwKy
         0peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769460207; x=1770065007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0UipC5QHyJnTmDWXctjUpxhkNyTA6jh9RjXD3Q3T9M=;
        b=N9yZTxaYgKhO+9YvEFNEO+wUgUIHmWdSlVt4s73xxrjHVgOTAP/drVzrkn9ZLs1J5n
         7LfcArdAywODSx2J9pVFGkoBPqeCUsRIYbzKH93YDBHabDZWI7uf1NbL0N9qrXxv6BoT
         URPKxuDHCpQsErSBHjtZvgGl6FYl/DsyHqrqGUHKSGp8DlqPBuR0M/JoQHtoXGXZ7UhZ
         fLwZdZAvi3DtD+nWOCAYm9wDVFa+8CIJHEVPqE6G/RO32aAwVgy5ckcho70xmgjEhcqP
         D3RnMCCu362/XaJi2puEbZqaL95l5aIebasE8YqAVUFDEROXG6zwT8hNGbsnv4GDLgiM
         aw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPbbPCAv8vfIWAzB8Uvbm737fve95sc7YMRyHYRgnLbNvMqMev2PlSbSmBvodKlaYSf1+JHZe0nxBO@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHpiL7q08Li03VBWh6YqIgUGVekutV1WuFHvNQG+R76kSpQMz
	Q5SuUGVsrTXvX91c36ZOrpH1GUkn28aLraJFOlNsEUcHTJvFeMavu/x/L/LcNKHK0V4=
X-Gm-Gg: AZuq6aJD+M/Ih4AqsKHJTjHrSKDokWkyX687qD27D9LigLz7JYoXrTysfbXPeH/6yPl
	BC4RBq1+6upyBGfqZbAjc+Eqm+1h4kzDGmVo1KScTdTPTaO15vK/ZvhMYjnn7V91/Djq3a/HKX/
	u1zupGgrhHmT7y9boletcZpYjbq2cB0lqCDTMWX/jJKLbsMTKXElndsqjJtnOeMcAgMxak6bbjf
	r0kk/r+ANn9XWKzWfnF0hBKHwfM/fIK7qD06e2PybKpOwod8ylyKmMxsJePbMNYZx6ci5r7XVxg
	HAcqPj3hZU9rXxCjMaf+IclOf6dj7YI8dvZbRxKKAcjNKwTFZlWtaypDI/AUsRhNhfb6QRh4QIC
	YA9inv+ZIdh5+89BC7fuL7xaHeo54GJNe0hQZKZ3QUAeOthadjE9kgvJgn0+kU86hYWPP0PU0OL
	QdSpyWsYAkzEt527qmQ/uc
X-Received: by 2002:a05:7301:d16:b0:2af:7ee:5300 with SMTP id 5a478bee46e88-2b7643466e8mr2954218eec.14.1769460207055;
        Mon, 26 Jan 2026 12:43:27 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa08964sm14741354eec.28.2026.01.26.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:43:26 -0800 (PST)
Date: Mon, 26 Jan 2026 12:43:24 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: Paul Walmsley <pjw@kernel.org>, x86@kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>,
	Valentin Haudiquet <valentin.haudiquet@canonical.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	Jesse Huang <jesse.huang@sifive.com>
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
Message-ID: <aXfR7NhAxHlND3z9@debug.ba.rivosinc.com>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
 <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org>
 <aTxf7IGlkGLgHgI2@debug.ba.rivosinc.com>
 <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
 <CANXhq0rpjSvOThACrB6_MMc8S34--xJsUYZ+HtMu1GUNyk8zOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0rpjSvOThACrB6_MMc8S34--xJsUYZ+HtMu1GUNyk8zOg@mail.gmail.com>

On Wed, Jan 21, 2026 at 09:32:20AM +0800, Zong Li wrote:
>On Thu, Jan 8, 2026 at 11:10 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Hi Paul,
>>
>> I have a bugfix for a bug reported by Jesse Huang (thanks Jesse) in riscv
>> implementation of `map_shadow_stack`.
>>
>> Should I send a new series or only the bugfix-patch for implementation
>> of `map_shadow_stack`
>>
>
>Hi Deepak,
>Not sure if I missed the bugfix patch, I couldn't find it on the
>mailing list. Could I know have you submitted it? If so, could you
>please point me where the patch is?
>Thanks

No you didn't miss anything. I had been busy with job change and even though
change was small. I wanted to do some basic testing before sending fix. I just
sent the fix on this v26 series, patch #10/28.

Sorry about the delay here.

>
>> Let me know. Thanks.
>>
>> -Deepak
>>
>> -Deepak
>>
>>
>>
>> On Fri, Dec 12, 2025 at 10:33 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >
>> > On Fri, Dec 12, 2025 at 01:30:29AM -0700, Paul Walmsley wrote:
>> > >On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:
>> > >
>> > >> v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shadow stack
>> > >> on MMU). Used b4 to pick tags, apparantly it messed up some tag picks. Fixing it
>> > >
>> > >Deepak: I'm now (at least) the third person to tell you to stop resending
>> > >this entire series over and over again.
>> >
>> > To be very honest I also feel very bad doing and DOSing the lists. Sorry to you
>> > and everyone else.
>> >
>> > But I have been sitting on this patch series for last 3-4 merge windows with
>> > patches being exactly same/similar. So I have been a little more than desperate
>> > to get it in.
>> >
>> > I really haven't had any meaningful feedback on patch series except stalling
>> > just before each merge window for reasons which really shouldn't stall its
>> > merge. Sure that's the nature of open source development and it's maintainer's
>> > call at the end of the day. And I am new to this. I'll improve.
>> >
>> > >
>> > >First, a modified version of the CFI v23 series was ALREADY SITTING IN
>> > >LINUX-NEXT.  So there's no reason you should be resending the entire
>> > >series, UNLESS your intention for me is to drop the entire existing series
>> > >and wait for another merge window.
>> > >
>> > >Second: when someone asks you questions about an individual patch, and you
>> > >want to answer those questions, it's NOT GOOD for you to resend the entire
>> > >28 series as the response!  You are DDOSing a bunch of lists and E-mail
>> > >inboxes.  Just answer the question in a single E-mail.  If you want to
>> > >update a single patch, just send that one patch.
>> >
>> > Noted. I wasn't sure about it. I'll explicitly ask next time if you want me to
>> > send another one.
>> >
>> > >
>> > >If you don't start paying attention to these rules then people are going
>> > >to start ignoring you -- at best! -- and it's going to give the entire
>> > >community a bad reputation.
>> >
>> > Even before this, this patch series has been ignored largely. I don't know
>> > how to get attention. All I wanted was either feedback or get it in. And as I
>> > said I've been desparate to get it in. Also as I said, I'll improve.
>> >
>> > >
>> > >Please acknowledge that you understand this,
>> >
>> > ACKed.
>> >
>> > >
>> > >
>> > >- Paul
