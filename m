Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284833DCD8F
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841316; cv=none; b=CbSzTgQQQqJ+ekKwfamS+fh4OLIGDferKwZeBYS3Kmk7qGpl0xzaJZzJ1VtbapAk5NN21yMdjlmAg7sWF38G9TJD+QZwmEYOHDsnFMQS4+FadP23sEsKknWL4oy+eVJSdTxZrlcArzVcQKtd7iugbU+dg4om+Eh7KiyjAhwz6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841316; c=relaxed/simple;
	bh=NQdl1jXhBDSNriuKrZCDP2J5EVMaBjcrUPDyNxQxkas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxSKvy/3a1i6ZmGxtXCqHuut6YM6MYUlYs8gsLGyPjDeomLGPfOKN8FkEBA+yIMj9+3GvQmSB9Fbc7bDXc15CUlH0ZkE9UuGAIOqKOtfaPI13ya08EWNrHHvU/ejXl6JxfCczHq1Q0fLZYFedyhdV0J0EESQgSYcFrhiEfvhaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVZMvhvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVZMvhvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F21F000E9
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841314;
	bh=+z2eGjaR2XxqSwoLqqHAijQCJxgnb5Yi71u88EQbJ7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lVZMvhvpURn9+NtmjNKAERttoqNX31ZVarA97fkTBGJSJ6MpjH6t/XbY80IiPe9zH
	 GwXC1kHsZGru7y48LMqOuYiZmhU1jCeyjzqeGS/jFuZopuVBDNI2NE/QDsyKhExrbg
	 rSIyROr+wetVzoPOwf+HsXVxUbAFj53tgF9EnIJq3Na9W49/yScbAchtXzGQTcUnEa
	 614RvhH+qDIkhA8nvM8FqFZC2wgPInnJUK04NdV8YKWuAPA89LiNODg7ts6+MHpB+r
	 fU7p5eDgDSbnvdKDjDO4qYzhCuchS/J4lUI8oYfXevy4EyttOWBAj7u7/PzC8d2OUF
	 YmzyLKMK6jHHA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aebae2f310so1804443e87.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 10:41:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpdS+X6kxARsFSSk9k/H9XcopJIOElqDAIPBt7xr7QnpOL9vJYaLrfkb9kdbYyCtJ2tbTzlk4U6J/Ot@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Yt16Y7MsZMn8zQRj01Vh+39Jb+NYS96rNL7DBqnimHQrrG32
	eL3voEw85ef+IoEj29jSz1FjCG/U2Fu8Eo4O3ELDQLJ+oHj3wKX8pIBEYO3gueK33nOTQel2aGk
	l9aRVHFdSmLS0+K4fC28YnAxYJ+/Lv4ef4FV/XZ5p
X-Received: by 2002:a05:6512:1352:b0:5ae:a969:be90 with SMTP id
 2adb3069b0e04-5aebdb9dc40mr1241023e87.25.1782841313034; Tue, 30 Jun 2026
 10:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <eb390c52-eeb3-44b3-88e9-e65c52a26c05@app.fastmail.com>
 <20260630-kippen-jobaussicht-restriktionen-2149cc663b22@brauner> <372c1f13-e6eb-46e6-8685-3c39da4e9f72@app.fastmail.com>
In-Reply-To: <372c1f13-e6eb-46e6-8685-3c39da4e9f72@app.fastmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 30 Jun 2026 10:41:41 -0700
X-Gmail-Original-Message-ID: <CALCETrV8T3KOWgjZL6wy2j7E+Y6zOjfN1aCDsVH4PadvE+yxSw@mail.gmail.com>
X-Gm-Features: AVVi8CeUBlWGEkjHdS5BeIIzHXmtA_f4D4jT5R2_iP12sFg1FBcaLKf8siZYtr0
Message-ID: <CALCETrV8T3KOWgjZL6wy2j7E+Y6zOjfN1aCDsVH4PadvE+yxSw@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: John Ericson <mail@johnericson.me>
Cc: Christian Brauner <brauner@kernel.org>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch <linux-arch@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 10:20=E2=80=AFAM John Ericson <mail@johnericson.me>=
 wrote:
>
> I'll throw in the towel after this email, I promise :)
>
> On Tue, Jun 30, 2026, at 3:14 AM, Christian Brauner wrote:
> > I think Al is about to have a stroke reading this... and I might too.
>
> Hahaha. Alas, C does have a longstanding beef with discriminated unions
> --- I can't do anything about that! (Well, other than wait 15 years for
> this stuff to eventually be rewritten in Rust, that is ;).)
>
> > I agree with the sentiment
>
> Thanks, I appreciate it :).
>
> > You know what the easy solution is: don't allow a struct path to be
> > empty...
>
> Just so we're clear, my quibble here is purely behavioral: the nullfs
> directory can be opened, right? And that open directory can also be
> getdents64ed (yielding no entries, since it is empty), right? If I am
> wrong about these things then sure, no objections from me --- let's ship
> nullfs FDs right away!
>

Christian, how would you feel about a variant of nullfs that fails all
operations instead of acting as if it were empty?  (I'm far from
convinced that this would actually be better, but it at least seems
pretty straightforwardly possible.  And obviously the
nullfs-at-the-root-of-everything would not want this variant.)

> My reasoning for being a bit of a weenie on that behavior is just that I
> think "fail fast" is good. A lot of userspace programs crawl the file
> space pretty willy-nilly (e.g. they are doing some caching thing, or
> they are looking for something, etc.). I suspect the nullfs approach is
> going to result in more "red herring" error messages and google searches
> about "why can't I write to the working directory, not even as root"
> etc. I just think "no directory" vs "immutable empty directory" sends a
> clearer message to userspace, and will align mental models more rapidly.

This is the difference between a greenfield project and working with
existing designs.

If I were designing an OS and its entire API from scratch, then, sure,
the cwd and the root directory would just be well-known items in a
capability table, and they could be absent.

Linux's implementation and its API are not greenfield projects,
though, and it seems pretty silly to try to make this change.

--Andy
