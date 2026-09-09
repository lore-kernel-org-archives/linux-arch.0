Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE35625E3
	for <linux-arch@vger.kernel.org>; Wed,  9 Sep 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960174; cv=none; b=PlFZbOf53ffVCSnfXgRw/qm4xmMjAW+Ayi5otg7octi0Fi+VvCCORuBckOdFXabX3dVyJvSEDrutWjk+3zxTpD+rUCWV793yX/IV3SPNXbvS9utq/Fl7ZL/gbLDYdMobgZdCf5DtMYfi8jTpffeoUPaABwlNwDgI0f2oCjmnBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960174; c=relaxed/simple;
	bh=jcPULJdnuPzlzxuwUnOJeHwoHH9WcIC8g/lf4W65c9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bceADCWCotZWVldbRay609yiJDv12PibQEsGgcpSh4K+pHyJiANpXAhU4DROZuBOqsR8EXgYt4T5eVVLw8B60tgSho1vrYV8fFO+yg2IRecclYqfq3LkwyetGcvNdBr/X1vaVqmftz0AsQSKq9BSYKSiHMOxah7XLfw+TutDW+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOAQkl8K; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOAQkl8K"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so44484085e9.2
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788960171; x=1789564971; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A4i81r+GTAXgH5FzYo2ohbuMajjqSfB8ggeOnVykaN4=;
        b=UOAQkl8KiERqAyN2TqwC9Aoj34mFPekiBUxUqsUl3j3yzG+djU+H9dPP1mZE8w+hs/
         rDfiq6xH11+1TPmEWJFbaOS1EFX05RLgsTkBui/cKlMOjsPW/bXtDszAnG/ZVAvqZu90
         qz9XV8euQIg9jFhlelboa6Y1hxtOo77FiG7ouMmDnatEoNLrP5dLzyCktPflbyjNHbLu
         5JvJRCcwzKYkuLcTNeLDdiSfrz0+G+7asuyispB+JL9R++0UMVlZkR0AmB+0niruTkKt
         5yivaCp5i9qkb/0kaEenaV5XEcqdD1LYgg4k3Udn0Xjs40KaISHSq3OZ12lRTIak7BBw
         Mizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960171; x=1789564971;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A4i81r+GTAXgH5FzYo2ohbuMajjqSfB8ggeOnVykaN4=;
        b=Alfs+ii6nlJNaaQ10BYIIIlvTTyyWDljU7EHNHcpPQQL3zzatRCfLX5UEbAwLTLb5O
         pmx9kxOe4WyEvrq4KKvO/GPa/x05KVM8YL6nk/2sYNCu+2KPBJTjX0/le8vHWY5PG6QD
         LFuhhQkcuDZrKKuClUpG3MAgJ/aCwsfTYR+UIc9QAbmKLNqV5V5cAYEi+B2Yl0uWrAp1
         QQUxtF1BrJndkVKHpAjO77BZeHg7Xr7hjtg6iJaLOOjoGQaqVL7+Fr4lHRj4hN8E73hS
         F8j0EOr07j4fmDU0RTaaqInoeJDG6O2cgZ1+DPnnNW3QmgmvQQlmhcUkBnYBbuytsW2U
         /Ang==
X-Forwarded-Encrypted: i=1; AKwUvBzM+LuYtRWeAtYCwCYXy5F2AJzcIRehGkWOaJTXTUH5HIpuJXMMeKrd0DcbzO9oFxaQfZw3BggC6vLv@vger.kernel.org
X-Gm-Message-State: AFuF++kl2vjT9tDQqYmLPkprgQilPbIa//CubFtVrZxxgKADmoiBSFS8
	CscZ/ZbHG9LiJstjsGFACMV27wJKFPikij2Ryy2B/2Jmts6pmNXIFA0/6XC1wfUjqXkedRfWo19
	CVLvekPSfWRSNf0X4Eg==
X-Received: from wmph8.prod.google.com ([2002:a05:600c:4988:b0:490:b475:af08])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:55d2:b0:49c:fa21:e74b with SMTP id 5b1f17b1804b1-49d259252bemr7716245e9.33.1788960170557;
 Wed, 09 Sep 2026 06:22:50 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:22:49 +0000
In-Reply-To: <3gyxhudb5zwrrevc522qjpddnzxbsyxeeqair7tvii6jhfu6kl@f63vlxgftjpl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903185557.183224-1-atomlin@atomlin.com> <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
 <ultg4rym4phqwqrbuz3hqtlse2lgafxebx3un7s3tdht7rz5xy@3ckauomiwqsy>
 <20260905172817.e367c940d750ca3e8484fef9@linux-foundation.org>
 <3cee4548-0ae7-46a7-b437-bf84e5c155ad@app.fastmail.com> <3gyxhudb5zwrrevc522qjpddnzxbsyxeeqair7tvii6jhfu6kl@f63vlxgftjpl>
Message-ID: <aqFdqQ5xCucwijsl@google.com>
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to
 built-in modules
From: Alice Ryhl <aliceryhl@google.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, da.gomez@kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, 
	steve@abita.co, mproche@mail.com, nick.lane@mail.com, rishil1999@outlook.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Sep 06, 2026 at 10:08:57AM -0400, Aaron Tomlin wrote:
>     2.  Mangled Names in Rust
> 
>         For drivers written in Rust, initcall symbols are compiler-mangled,
>         which makes initcall_blacklist= virtually impossible for a user to
>         specify at a boot prompt.

Are you sure?

As far as I can tell, the Rust module! macro applies #[no_mangle] to the
initcall, so no mangling should apply to it. Its name is the name of the
module followed by an underscore.

Alice
