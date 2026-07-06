Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA502381B1E
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357847; cv=none; b=Y9gMxrSygFA4Rip/nVeUFWXbev8crB1eYpEIpU4lt9P2mYuFSQYdWdHhc0aDgDDvFVXQP0II0i/409dazecBGysQo/QAm91zWTh1uY9wRB0moUNDgnoane0I/gWC69k3QLDxTSpXv6lRiYoF4EYkRgF9O5JwFaIk2JHpntD9QIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357847; c=relaxed/simple;
	bh=UE1/A4JUkdvobYsxruX3DgPOIwXgNzWpCHo/V4LViqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTyP9PDomALbtYkPYuZppiJ7qUQ6lSKUpe35JnOKUK7UbABGDYEVKw6tZvC1LpHRM0KNNRt3FL1OKEsAyp7hudox8eZoTOht/U0zA2pmENHsImbIWnk++pASO+bdSgzwRs3HoIBo2aterm9bwCVe19l/LE8EHeaIOHV90dH+Iig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyf8QR6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyf8QR6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F9B1F0155F
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357846;
	bh=eJA0xUON18WtiblCyjyGpTE1Z5c5pH5jHS0SuDx0JtU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Tyf8QR6XyteL2kdcjnK3HIH0ZI3hOc3X/cm+auLHOlskcZozcYwemYDvvQl21ctLR
	 7J5PJl7oUaSRZISzFkAothy9yf0ZBPr0LtS/JS4CZJg0dJfhUx5T8qrh2noIQ7Dkk7
	 soiDGykDdSZ+60yBvww8LWxPwbjSEa+b0wgJxpLxdZ2rAEslLM7DoOR+kfexVlW5CF
	 GUuDlwo+Yatjxl9gAjXHKgZ6bBKwtsH7K9Lt3vujVvjZm4k29/tEtfNVajFrA4cY69
	 lfkYlxtPajCXUDcY4zKd8OFr5IhJrTf4Hly49zRMcS7hHO3AyNA2sqKYQR5XxT5GDW
	 iwYU2r0PO9mCQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so2677979e87.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Jul 2026 10:10:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro6MVMHn1a+6SYk0Xu+pyzHc+btAAs9RDX6yDMQ6FFDR7AflOh2bQkH+ssuTqz1ZILZASyVmWAXPH07@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjrRiATJ14F0jXYOXo+T1nw0iYpL/GS1lVdfTjHzIJEf/12m4
	l4/0+j4mdPEJ+JmxPtn1udlIjVQZq33LLdu1P2czjF2+nQHEsZtjUVHGu4U5dIOfpONgk4uGjzx
	eKwRFziAID3T5SpqVlQXfVH1TKpJTOjkHEo8PH0Hp
X-Received: by 2002:a05:6512:254e:b0:5ad:5cec:74d4 with SMTP id
 2adb3069b0e04-5b007bc6019mr205711e87.41.1783357844812; Mon, 06 Jul 2026
 10:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner>
 <20260706-dabei-radeln-glitzer-71ecb835029c@brauner> <CAG48ez0sh7vEzBxtaG1HCJ0bmUMmhF_JR3=xXcc4+vpfB6LUOQ@mail.gmail.com>
In-Reply-To: <CAG48ez0sh7vEzBxtaG1HCJ0bmUMmhF_JR3=xXcc4+vpfB6LUOQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 6 Jul 2026 10:10:32 -0700
X-Gmail-Original-Message-ID: <CALCETrW6HO22peDYwA44Kk05YdLbsK4mJ51R7qodLUUBYnspGA@mail.gmail.com>
X-Gm-Features: AVVi8Cfu2si1SpvPZPvwXFx-sB9HeAk226nHqLE8GCDNAolic_zOW6mpgLOpyNU
Message-ID: <CALCETrW6HO22peDYwA44Kk05YdLbsK4mJ51R7qodLUUBYnspGA@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Sergei Zimmerman <sergei@zimmerman.foo>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 9:55=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>

> I mostly agree, though we might want to gate this on no_new_privs just
> to be sure - you could theoretically have a setuid root program that
> gives the caller more privileges if it can't find its config file.
> That's kind of a far-fetched scenario, and in reality it would
> probably fail because the dynamic linker can't be found, but there is
> precedent for other sandboxing stuff also requiring no_new_privs, so
> we might as well require that here, too...
>

My ancient patch did this gating.

FWIW, if we are contemplating letting unprivileged tasks chroot to an
*empty* mountns and they don't have privileges to bind anything there,
then the mnt_may_suid() will prevent them from using execveat to run a
setuid program.

> (I think it actually might be fine to just make chroot entirely
> unprivileged as long as no_new_privs is set, but I don't think we
> should actually do that, that would just be unnecessarily playing with
> fire and would probably confuse some security monitoring tools or
> such.)
>
> We should probably also reject if current_chrooted() is true, for the
> same reason we reject userns creation when that's true.
>

These empty-tree proposals might expose a little issue in
current_chrooted().  We don't want to check whether our root is the
namespace root -- I think we may want to check whether our root has a
parent.  Otherwise once you chroot to an empty tree once, you can't
chroot again, which is silly.  Maybe if we add this empty tree thing,
the definition of current_chrooted should change.

(This is already an issue with open_tree and probably even with
detached mounts before that, but I don't think it's as easily
observable.)
