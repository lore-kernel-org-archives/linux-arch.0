Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84943DEAB
	for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494978; cv=pass; b=nn5q40FK9GorLfmKINXPlajTuDsvYxgt6c6TyEHlEM+UREV5T1Sbq/YiaFV4l2cMQ78HfdLWENr+XitsiXxtT1ypu8DaHAguLtMxEbj/BgV1XmYkVfjWoUgzelsu1O/Mgbryiv/T18YyENRlS9gnxZXr234NblKNDRZXkSqK+GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494978; c=relaxed/simple;
	bh=P7a2zFFMvnl7AMMV9J8HoSFvOnO26MuCDolXpy7oTxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6FNTUBI58CPtx3lxbtPXDfSqEelTZUFxHf3dfcm+iXCpejxQJVNzYEfC8c1ORfRyOZSXgF7xe80Dh4A4B7P+PsZels0AKZ/qgQl9xM6MPTLczLGIJeSe2PU6hfjh+yXgY4hoNwlVvREbxbcLALxE+SRSBV4BoMNoMLSVc1hNWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eg9cCz3F; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eg9cCz3F"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48442ea8f59so535886f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 10:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494973; cv=none;
        d=google.com; s=arc-20260327;
        b=FcgsZYcindtdQR8/cwZ/doOlNGhIoJZGTziyWIPAviU5gPdiOnylorLeVJj7ax8bmU
         4XiIgrsHaJ0s1lrysbLFxLIfypz+pg48jRjUs7rvoQH8ySw/t8PjalrHtuPwlVCK7H9s
         PX25Ux4u0mHMiY3BZxrA9CNwBMbEbgwbHK36AEsvY7JWzADUmcoJ27zmxfnDPo0yXyWo
         aQxA11lJOXEuMudmU1HpuTm4Cm2uH3cB23I0LWtOd7Y842HoAaMaXjzmbfWO/aofOGM5
         4c2JPmG8T+LhorWV7CyCKFsLpeb8ROoEGHul37Zpndv/DZ0f5F+DdH/1dtr4yKBqw8eQ
         pJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXjIVxCi/wI/JEAgJbDGbjdOXMojQ1soppHskXz6ugY=;
        fh=WVAjXYD8zwdkl2pYmCnbWaTH3IQ2nHd4fgHAPwOagYI=;
        b=QVPIoZXUy4Xx+yqoXTEdIuDJz9gcDkmA8u1Xox8VzuETgSANLCLExcABZPxPBlq+Gy
         C8vCuGCEh5GhfJkVVS8T5hw23ovInzJNRkJY02n/IsaSMp93mEml/Fnyctt8UqnU/jPh
         Oy/lFH2Rfnlkg6ywNTsCb4xkCvxATDCxN7Io031b66yHQEicmQT+g8ZVxEo20472eCU+
         aw5207yHseRuDYUd9CYiqzOYud6ugHfZFGXpMV79FoLMLVR1mKSoG/WVXt5/c5wSp0QG
         CVdBgyz/Uf34CL1imcIp3c+MkosvnFbMNZA424DbhGyNwt3jfGb8yQlfQD+odQDNAxZO
         xyRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494972; x=1790099772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GXjIVxCi/wI/JEAgJbDGbjdOXMojQ1soppHskXz6ugY=;
        b=Eg9cCz3FKQuB9mYeQ9RohNA4MI96fbmNa6vaGSC4S6hrbuF3z+7cv38wzd+GhJ7apX
         dcynolzG0snU4zvfbv9FOzzpG3leDlV6qzGZb+rCLz/cuOE2nenXqkF3O9ji31n15oaE
         zVQFcSxZ+WmPf813V3c1b4USj9WwykZ5kRR3TEZOEvrOEfuWVImuQtxBwwmpkrMx1KR5
         O/we4GbqrzmPKYQqd6oXu86y/JCizk6ljYLUGNvq1U/0eZiEa+rRx0pXT54BapqC4F0w
         uuqf6kzW4vpQsMIw+hVpfepQDAzOFhDiLyyspm73JN3+TPPTikIe7ck6qKUKkRtDJrSJ
         NWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494972; x=1790099772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GXjIVxCi/wI/JEAgJbDGbjdOXMojQ1soppHskXz6ugY=;
        b=DcpKfvLcCDTpdzH1IMWA1C0vTjMxlcs8KT5ehlFcqFmu/phWfZ+u7WK9ptZTmmsSVA
         tpZuAJswd2wh8w15GuAvQ8d5eYw9NImR3b8lx+x9gqQyznQFhp/6bGd33Oy4yji8V3ts
         PVDOyds4PhK0Kah8lipz/7DfPFSUgulvF5fVkTTFNg3x/yb87I3ENbu2NXCzvvMKz20T
         QGgQVvi9JMth6JBc/s3cmAEeFTiU23jvUZanJ2wUmOoNlrEXwKu70pi6AIj28i8DtA9f
         UJjniBRzOwXcnWYelgicWQpiTWnbEb9oECiM6S/XkGoixWGvSTRlSmDTh0FNpzeNTJYv
         Nong==
X-Forwarded-Encrypted: i=1; AKwUvBwc0V/7xPuC/SfhppjrBWVs+W2qWhQVfG735wHs/8JEmnyD9zvBxJ7KX1xIVDFegufXY/A+CGBfWHMr@vger.kernel.org
X-Gm-Message-State: AFuF++noCBAjhMn6yXXMzQmQNG7Rn9Y+9v8ibYSN7ywzlmQm9GnOXZ/G
	7VLqbsEABBoro/rxFqmIlsGXme7ORjbWR+jgwPHOuQGz4hw1RkoS8xodkO1fIUT/6LCUZ4HIxuR
	BzCRdHKSRQBnZBEf9WUtRZL7TAcDwb3gWZdzzPION
X-Gm-Gg: AYBFou1SV0C77+hZdsj907l3SZBIwdAnUrOzxHk84dJGeKXuv2PZD2W7ZM0Yo3g2uTM
	mSB1xJuPoQBuOjqDaZ+C1VyMqF9RfWVGBoqvREz0qjHLJbuyv5YyZnBe/284vQE6fr9VPN3Y4oX
	VjzJZI8QGVZ9DkEq5hZGIrTJ1BCsUZdlF9t0bGAgW2qlw183yoNX5yh8fDwpAl6JeCeCJKymQn5
	7krYVABk+I20MbreSmWzkwiWgNDr78qszlmyymIeqYotc+UgvkfrHTJy+nvqf9DqKz2bAFyMerH
	FQpQ0vns7meIkQVJ545dCLE8400SK4C4bBWuTKJmslXOzdvm04oJh5999v/OVoEiKf++6gDjSu9
	6UhvKJfWVQ0D+/lpQwHL+fmzVW2KGcOrKv/LJijPNIZMXmMUEwCcgzdrRYOKskJOC/u4=
X-Received: by 2002:adf:eec3:0:b0:487:13f:4968 with SMTP id
 ffacd0b85a97d-48705b5d792mr5756089f8f.11.1789494972051; Tue, 15 Sep 2026
 10:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
 <20260914-build-speedup-v2-14-39817ec5db23@kernel.org> <202609141056.6AE2C82E@keescook>
 <aqkZvtAKWYf9-1ZW@gremlin> <202609150943.000EC9277@keescook>
In-Reply-To: <202609150943.000EC9277@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 15 Sep 2026 10:56:01 -0700
X-Gm-Features: AcwNN1WPMMWK_d5_qt02ICUH5UNGl72dPPgrM0zv_mQxUiZh6yRKMNR6HBnx31I
Message-ID: <CAKwvOdms6QWc7RMW6hJb3qzgmpK+aw40C7b_h7eG161ie_Y8ZA@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] kbuild: batch module finalisation
To: Kees Cook <kees@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:49=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Sep 15, 2026 at 11:44:01AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Sep 14, 2026 at 11:00:27AM -0700, Kees Cook wrote:
> > > On Mon, Sep 14, 2026 at 10:22:13AM +0100, Lorenzo Stoakes (ARM) wrote=
:
> > > > Module finalisation on allmodconfig builds consists of a large numb=
er of
> > > > very short-lived jobs, and the make job dispatcher cannot possibly =
dispatch
> > > > jobs fast enough.
> > >
> > > This "cannot possibly" sounds like a weird LLM language intensifier. =
I'd
> >
> > Again that's my writing actually, probably best to stop assuming LLM no=
w ;)
>
> Apologies; whatever the opposite of the Turing Test is, I have failed.
> :P The AIs are winning: humans are suspicious of each other now. :)

Is there a term for this yet?  Cylon paranoia?

--=20
Thanks,
~Nick Desaulniers
