Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F1403144
	for <linux-arch@vger.kernel.org>; Thu, 28 May 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992836; cv=none; b=u6BhBNgrOMegl9fRbhL218fMvGOC6cHfoMNSamKw3XOUsvYvtu8QJWjRtTpLH5hLsbrpkZ07L+xoVygXl23/pRiIe7YzorDa3rdkxtl5N08U2HTCbVehYFIPWSoRZ4V+jk2B16jPrQt+xRY42H4tPfeuGrBST8fCrO6ivulxP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992836; c=relaxed/simple;
	bh=Bi/Ekqnmt+zfvrHKtNJFwE8S0+0gM1iROurgHj5oaVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJayLS57AyJfLX7NkHWUxpuNc8DEeo+PS/cPJy8Ofocpr9EDdAvPHEzBv+pshdJFYkhOqXOzO8F+oEYfkI2bSoR5Yr7OcYDyRy09kHXojZVmAOKu2ss+e4d4MFWLEmjFDMbbsgXxFwoAMsURB8zLQ6N67L8sQfyxIxTMOiRAgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1ZMVEpk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1ZMVEpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF431F0155B
	for <linux-arch@vger.kernel.org>; Thu, 28 May 2026 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992834;
	bh=uNFRPkLBDJywU48J/noDObDM2rNQtdyFBCATGMJKuNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G1ZMVEpk3gU59XUYucRTVMRJcbeiKLzqLpDypug6RLe3b0aZkBevWVae+ifxekpfH
	 oK0A2zbmeC5ZTA99vp4wtydk0KLKr7s6YrhBhqlELKUA4YPvzb9R897/Puix9njxHP
	 BFJw1WeJIjscHQ+t+pbLwwad0o7Rs1f9ACYEbBFtGurd7bOngpecSA58TDf8ZtiVMF
	 Nnxzk9Jx4YRSpY8EU+ZeIq88xf1iP+S/0WJ3tOHqp+jfqCnHUvRStcNy0GkuHYC5VR
	 1Up7KG4/Rq58EQz73+oQzXQqOS/+d1al4rJVbjlIUq9MknFi0WX8EcGkYOPM6fiLft
	 TkIgS9+Syz1Hg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8891febd2so17247871e87.1
        for <linux-arch@vger.kernel.org>; Thu, 28 May 2026 11:27:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ81fbklGD9CoIGD4nFVmuPe77pLzIzTm+v9G0cS6uLm3K/susysP0HaLXJPyXnMutQjQvaYg8B+M1P6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcf3DDh9qv577Mh8S4hl6CAzFviJqVilz0xjJqweSQdaj9+o2M
	aBMjNSFfGvySJuuTsUu4HQzzjMglGeQPzqe1ZP9WjDeOVdz+mStBiNjmBjGAgj0LBEWoXxp/RtJ
	XxbeSdEKBPbxec/TJxRMeFal+HacI0nbJTtiY/oDT
X-Received: by 2002:a05:6512:4017:b0:5a8:87fc:2b34 with SMTP id
 2adb3069b0e04-5aa57e2c285mr81991e87.32.1779992833237; Thu, 28 May 2026
 11:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty>
In-Reply-To: <20260528095235.2491226-1-me@linux.beauty>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 28 May 2026 11:27:00 -0700
X-Gmail-Original-Message-ID: <CALCETrXqWcqn_79sMKnkyKOSAjg4AmcSHsuyH83oW8zJFoV6Dw@mail.gmail.com>
X-Gm-Features: AVHnY4IbWwLdSkNuWrooNBUAlyUyrWFavzF9Z8DQApcFhZZC4EFwzAXsIa5vxFY
Message-ID: <CALCETrXqWcqn_79sMKnkyKOSAjg4AmcSHsuyH83oW8zJFoV6Dw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Li Chen <me@linux.beauty>
Cc: Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
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

On Thu, May 28, 2026 at 2:55=E2=80=AFAM Li Chen <me@linux.beauty> wrote:
>

>
> The template pins the executable and denies writes to that file while the
> template fd is alive,

Please don't.  *Maybe* detect when it gets modified and clear your cache.

Or develop a generic way to open a new fd that's an immutable view
into an existing file such that the fd retains its contents even if
the file changes.  (Think a reflink that's not persistent and has no
name -- you'll need some way to avoid resource exhaustion.)

>
> Workload     Calls  subprocess  spawn_template  time_s       Delta
> (workers)    calls  calls/s     calls/s         seconds
> 1x16         6144      411.04          420.32   14.95/14.62  +2.26%
> 2x8          6144      666.78          690.08    9.21/8.90   +3.49%
> 4x4          6144      955.61         1003.25    6.43/6.12   +4.99%
> 8x2          6144     1048.25         1069.18    5.86/5.75   +2.00%

This is a lot of complexity in the kernel for a teeny tiny gain.

I'm with Christian -- a better spawn API would be great (and much
faster than fork/vfork + exec), but that's a different patch.
