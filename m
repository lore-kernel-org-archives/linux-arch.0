Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318F413241
	for <linux-arch@vger.kernel.org>; Mon,  8 Jun 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930970; cv=pass; b=X83pmoQ1EAne8rfV5F2kB/MVDLTetW/D7989YyTyz/P9kxWbCDLmi9culzM97gBNg/NbYUtxI5usH47N0NlCw6ldTkg8NG14P1yCd8Sy1AGHcm5hW+eoOoKqjTQNqSsK+dtqB9AdVKYrGrn7/7PgHFcoqK0+OhOEvfGy72CHlB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930970; c=relaxed/simple;
	bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0h5qcVLIzt/ptGEmZuXX5dLVqtvju6tfpVHOQvQyeikCECm2F/VASsxaO0iKq4vJvOwO7+5+tXg24wdR9Jnce/VW4rq+yIl/URgPDQKQk8RAsyTQzSOBzp6VHCMDXaxLLj1AryoC1MycedVvhHLhx5K12OSw1Y/acFh3vPSxIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN4g2w+7; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN4g2w+7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so29122a12.0
        for <linux-arch@vger.kernel.org>; Mon, 08 Jun 2026 08:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780930963; cv=none;
        d=google.com; s=arc-20240605;
        b=LHydgzz42RioIdCrO/vpfOjru3Q5L3+3dLrXP+LIzbJIej6wTTDM6ptbyIE2qm6mtq
         d8IZpWyFr2F4jZqIf6wOG7xP8mqbNJQObiKH0nDAtIviM2u5oWIVHVfHHD3wWr4Q92CD
         DbBuvitgPW9+1nPO4FpN1GX4UYEjv5kiCoKAaa9A7kH9aG8jeRI3FN+89GRbLf4xHn5O
         NDjafPzu9byCuwd5M+LN/RZJhilS1MuX18tBTGP/iuJW0VV7qu8vLuFjQ6uJd7gfItKJ
         To490+rYiWRbfW8z0Bmqeoj8Iqf4R4anxKipciLaVWM06odP/LsLFJq4kOlthpQvqsKL
         E7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        fh=tFtVp5PM5DvCKwmLaOHCTA+XAMlGNfRjDZnSp42QbEA=;
        b=jJQSRZAQV+4XkzlAw60sZut0zaXM5QSVeyRq5Yp+Tan/e1L3wy+MgEwNnSirPB/2wX
         p9YEo5vIJyAirwaw/Yj5HBtsEzPoFJxahT9Jd0qF4p+ZwFApeyB7jrx8wDX36gxtSG53
         kRF9iz7r6drpyNN5y7MZw0TK0Lx696fexgAsJVTcyk+gMsS52qXxJijErDtkrwNAHmzk
         /B+qXBHRz5Trgd+5qy7uGITS/hSXEapMDEzUaVbF0zrtZ2U3lTABjpqc/Klo4Zw3HOSl
         JB/oLowf3e7fr2NYUCCuPeG2VMecYerRo24yItyeYdSK21k2QloUZF5dhKlsA5hOdn5e
         tgVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780930963; x=1781535763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        b=SN4g2w+7L37u55NOHnH62hsXGmHRkvICDQ97Qol/4mqxJN6kaeE8TAGexGnPVk+0Sj
         vOwhOYMqgm/ZclL9AVkos/+Rx8n4xUQp6WI17G0GvGaF7oUhQmM6qa4pgZfpehiTajlm
         1SDyEkqnzK56xnyHFwufRSwSX0EjLVEUE9paFJ3tapzaLxxpDd9MLsnbyCvYHXQ8eyRx
         jqeFQF/H5AIlNqAkFEFS+VpK/60tXK9rrfMmWz4xC7aWMinwx328dqWwShlEraX65KC1
         MjGPFslpEltXzdQ+rgN6o+Eovk1f5szk3IXtjEeBQEUbHxqXHqaAtVntDNampvk7JuT5
         Eqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930963; x=1781535763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        b=g8HdWSYXVN5L7x6b8+rM0PL69iKwxDkWzRU6MyrfhDGQv91RXd3AweA88OrL6ZWxic
         nnKP7f4H/cMLjdGn5+KErdpdIjwkWgEsyT2/3wLXvGIs4c96tHX2YjTJwoJq2z1BORKx
         hMLmIokMN6qr1XtKHLEl/0gf8UwhqlnmnnMf4BkWingYMz2WmBFL0alSfD0KahzDulSp
         EqOqycN/8LcYEf9c9cDrAp1GmAkwoRT1bWP5Yz7Dyfcp2ADSWGBA5suGK2WKzO1wPDt3
         +LQabi47WoHoGoPhdyAtrQD1Geupk8mw8m1PIQO93T5zZhcbRFlAxQxREF0Xo9CDEaf8
         FSmw==
X-Forwarded-Encrypted: i=1; AFNElJ+Pb7ls6TgLgOH1/irFdT2HQkywp0GIUegS1DbCOi3kAuOhs3RQY4Rsd9xAHpXgEpRqWbJofkmduoxz@vger.kernel.org
X-Gm-Message-State: AOJu0YxscwcqMepKCniyifJxlCOFoCgFpbNvxgKufmePmpCXrov8KCC8
	OW4cKdk1LgJ4CqOCd4diWPVKff+QaafTrkbP7awJRSxZfWtgUR0vU8cvRkhmTnawI3AcCaRBXqN
	vn+Y5UNPxKl4TqZjD6jHmnM10ZTCU5TU9McddHnAP
X-Gm-Gg: Acq92OH+uYvCtCVXVW34LPOIvQCu3dAfjnDzLboDYu0mWBsl39t8c6KXbwsdyRm1Jum
	UZ3vS0zWY5PA1YKJvYFiPRHdk3hclqtt4GltDAXhm7VBvYtiWHAVi6jlH4dK3A4p1zmS4bKDNhY
	Adc1litbT6aSi5To4cCnXTvlBRwTc+ukfRfBVXFeOATPfpU3NuzRlqwba2PErHJHJDfaPK5SxFx
	XwBXIT9imDsbqTcJSSGCWnQxmQdBVIgR9HTyGFGLnvolNdHyzWL1J5qHWnwDTxArZ9L/Ym+EASn
	PYG+znCDKdkssgr89R6wRSdp2U42uYCprtDlEA7lpB8sDE9J
X-Received: by 2002:aa7:d848:0:b0:68f:d41d:ca5d with SMTP id
 4fb4d7f45d1cf-68fe907ab8amr167661a12.11.1780930962621; Mon, 08 Jun 2026
 08:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
In-Reply-To: <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
From: Jann Horn <jannh@google.com>
Date: Mon, 8 Jun 2026 17:02:06 +0200
X-Gm-Features: AVVi8CcAEOXMmuMTSZ94akkMqWU1PSwZDT3Kns1-hWwyFL18yvP1h0y8fjumjnQ
Message-ID: <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Li Chen <me@linux.beauty>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 2:55=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> This problem is dear to my heart and I have been pondering it on and off
> for some time now. The entire fork + exec idiom is terrible and needs to
> be retired.

It seems to me like vfork+exec is a decent UAPI building block, on
which you can build nice-looking userspace APIs, though I agree that
this is not an ideal direct interface for application code.

> Additionally there is a known problem where transiently copied file
> descriptors on fork + exec cause a headache in multithreaded programs
> doing something like this in parallel. I only did cursory reading, it
> seems your patchset keeps the same problem in place.

I think we almost have UAPI that would let you avoid this issue?
You can use clone() with CLONE_FILES, then unshare the FD table with
close_range(3, UINT_MAX, CLOSE_RANGE_UNSHARE). That is not currently
implemented to be atomic with stuff that happens on other threads, but
if we changed that, and it doesn't provide a good way to carry some
FDs across, but it feels to me like this could be fixed with a variant
of close_range() that removes O_CLOEXEC FDs except ones listed in an
array.

> There are numerous impactful ways to speed up execs both in terms of
> single-threaded cost and their multicore scalability, most of which
> would be immediately usable by all programs without an opt-in. imo these
> needs to be exhausted before something like a "template" can be
> considered.

(I think probably a large part of this would be stuff that happens in
userspace, like dynamic linking.)

> Per the above, the primary win would stem from *NOT* messing with mm.

As you write below, I think we have that with CLONE_MM? The C function
vfork() is kind of a terrible API because of its returns-twice
behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
wrapped by libc in a way similar to clone() (with the child executing
a separate handler function), or if it was used in the implementation
of some higher-level process-spawning API, it would be a perfectly
fine API?

Or am I misunderstanding what you mean by "messing with mm"?

> As in, whatever the interface, it needs to create an "empty" target
> process (for lack of a better term).
>
> In terms of userspace-visible APIs, a clean solution escapes me.

I think we already have relatively good API for this - you can use
clone() to create something that initially shares almost all the state
that a thread would, and then incrementally unshare resources and go
through execve().
