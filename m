Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC013B774B
	for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2026 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782343224; cv=none; b=iyfevnvRaKdH5ZvxHC0Vq56X3hi6BfFOvB38paRcWJUDJtdQni0bgeN65QJlsNOz9B71PjurpKp2gSErnjHYHCfx9T175DsTHlR0NIz3BwdySeuAlE+tk7ALmcrfv3hM+PfN5ts60g3QxHAR1/ErHVSt71sge38LIKgcZYrn60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782343224; c=relaxed/simple;
	bh=FqtxWFhxAqLeJeDxZp6+yvzQAQhwoeAOz9hwgZZMrAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QULaBNDC0lD3DytFbMOdhK5Q/kAV4x7KAagswjv/NNbs7zarlM0iCJ0Ujz3WDes8d7poe78JBcRSFKHEBqONGNbyrV83Voph+Bo8+l9YikTDONyPXhkHS9ofexHwCT0Ru46MaI7FE8MQq6L+chLjQXHCYIP6uOwD3Cc26rqzkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmdTJSXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmdTJSXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE91F00ADF
	for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2026 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782343223;
	bh=/jIiNebKNU+6IMyVmekk59ZlLx4QpdG77Io+qQZfEg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HmdTJSXltdTMIk/6ZYdZZp4EOXLVWuyNvP+9ZZeETEfRJfcJ4SkQKs1YFP3ZkDlvR
	 S0ajjXSigiJBJ9xP8Av1J045fDWar/epYLeAa2Rsyz81mIuccuRh3hqTjcOmVa8pHa
	 tlEkeyp8bWglf04XSTxlXhXB+tVtjOukXKp/lhuKTClZjPcMLUuPn6d8XgVElXqzVy
	 olYWlCcJvmHpR8UGwuViXwK8+ZMSPRC5++BwLxj4n5Q4YOLoJCxim4b4eevsJ9pnG4
	 8l2KrfcAZOQnj4UZ2tQwZkL9Eg53t4P/PYRL40yKbSR+JUZbSqW/9rgNjp72GC6HNy
	 rCbhIjQVoZ4YQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so2063111e87.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2026 16:20:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RocvKwYDUiAHl4GeEjRnDHAKRGipInRR3eknx395OF/PY//056s2kj9IkQDgFvl7PL02zcFjEDQCvbB@vger.kernel.org
X-Gm-Message-State: AOJu0YxejwQ/HyX7TP0Z7cseRSQeiNQatLPC/NsZeXcLpKIr8Xe6NOaa
	l30Lm0aMDPuPdIlPYj8759WWUtsVmLhcRqSncrsuw9JMwdgpUf2sAmeHCEZCFObMdlXTo6pBjWf
	QjonuapfTgY+iGY0JVq5ZaOBM6YJRwUhR/gEMaUSU
X-Received: by 2002:a05:6512:70:b0:5aa:6f89:9378 with SMTP id
 2adb3069b0e04-5aea1f4cc51mr17819e87.33.1782343221845; Wed, 24 Jun 2026
 16:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com> <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
In-Reply-To: <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 24 Jun 2026 16:20:09 -0700
X-Gmail-Original-Message-ID: <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
X-Gm-Features: AVVi8CcU53d_udrdy_WfBTRtqPGEK2pcv7rckHwMVUx8ncAdX2VQVQ70Ly2dMNA
Message-ID: <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Andy Lutomirski <luto@kernel.org>
Cc: John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, Christian Brauner <brauner@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 4:06=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
>
> On Wed, Jun 24, 2026 at 3:52=E2=80=AFPM John Ericson <mail@johnericson.me=
> wrote:

> >   - null current working directory: relative paths with traditional,
> >     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't work=
.
>
> It's perfectly valid to cd to a directory that does not belong to
> one's namespace.  We have fchdir.  What's wrong with letting it
> continue working?
>
> Regardless of that, the current directory either needs to be a
> directory or to be nothing at all, and if we support the latter, we
> need to figure out what /proc will show.

Thinking about this more: I think that handling CWD might actually be
a prerequisite for the series and has little to do with namespaces.
Maybe try adding, as a standalone feature, the ability to have a null
CWD.  Define semantics and see what the implementation looks like.

Then, if you add null namespaces, you could optionally make
transitioning to a null namespace set a null CWD.  Or those features
could be orthogonal.
