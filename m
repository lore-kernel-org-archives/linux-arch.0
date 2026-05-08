Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9E2F99BD
	for <linux-arch@vger.kernel.org>; Fri,  8 May 2026 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257635; cv=pass; b=IPmJq9kTcbfFbqR/SnykCu5cvIpn4iuuZT5EFvmbcpyecZZ3I1mM8sDwTRy/vgJ1yI4nhof5qSVjfSCdsoVv/5OdERA7zyzhaErOLJWS43dUZBLe/4FhSO8l9YkQNiwUVh49PtNKP7M4kQO5FIIBmMOxVcj4qdvHSEByYWo/upw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257635; c=relaxed/simple;
	bh=q9+X7pxW5kSsnaeT11MvKU+Neq6+weTqZPmaeqJBu9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqWyDHJ9xcWKiPfXIAEzAiT9zKYzigndIk+a/7Liiiv+JiRc6Tlm8WdFHtfdCDFLl55/EpkKSJ8PKdHsxzAJZX0f7JfHtK2rRwVLJTmNJPm50nYsNSmvDZpfAllVAiscZet9KeuhB1rixnKVfNaMYti3z9fMV+hWr2xxTzBc1+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3Qs6PD0; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3Qs6PD0"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1270fc2bdf2so10537c88.0
        for <linux-arch@vger.kernel.org>; Fri, 08 May 2026 09:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778257632; cv=none;
        d=google.com; s=arc-20240605;
        b=fpgRRCbLhDrOIvI+TQlwOqMkJE5QZtnMqT9p0SdIw3ifRmzOtp5yx3CNeABR64WEWX
         dF1/mGSXnMAEQhtnWCmpGKHSl50nFUKR/AhUXVQM5PMqFKPNgA8VQsdTacsh/+59Gs2H
         W8giQxEyxxaT0BhSqCD/wTRn3Mi1BOAi3n1duzMTOWZx31pCzJtY9wuS9LJT6yanMoCu
         YgYFaiQnEQmqFstJQVHn33BLHBfF2EGoifuOMeYPJl8nrRcKnHA7VFxKUomnwJjSQgQq
         fcppQhzXlZtNoqDNiuv7dW19JDAuczBzLqmRG1fVvebFv4uqrsdVAr7AVjHKtLQb/PZy
         Zpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LWrAzUBaU8exS/YJJSUkuMAq0O5XPD4cN6KpasU2G7k=;
        fh=rqfDTlcjxdO+NL1qzcC8vYXYqp3h71xZJRzaBtDUfnY=;
        b=ka+5BWMxW4nD54PrD8UZseo0c04MDUeM8eJZ9zZnGD+oJJxebethl8kfrqOVkE1VQy
         XSFbuYCetGNpf9A+xXhR+sJyAMJwL0839GSV+ubnfQ8DGLGpklrE7bldpqmeSahFpzol
         c4hw5z0aioIifp6+29+GnOKeDTEYi3VozAYU8w4VTsWVUNJ+VJPeH1talpbx8P/mJm+C
         0QmOLjEqZHan5Ae92h77i3llbD7/N6MwFKbOugvmuazmJnd5BX238r7Lhr3r2AkqyYS0
         Cx9TKqJ3bJCMAjPPN4LhQJbLHU+qXX3g+98RyhpVSKKZQyqghbQqgpZO646VWV9wZFKI
         aiKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778257632; x=1778862432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWrAzUBaU8exS/YJJSUkuMAq0O5XPD4cN6KpasU2G7k=;
        b=H3Qs6PD0zJCltlHQjAbX47JZXO4XNtngzDMvSAlbVtI/5taLqbtlRwZIYVSJ1urbxu
         1fyoY77sluDH6mvzhkinIWhkPMFtCc7ftFi55tNXyCsgRkNRQ5hsCNOxP1Ga+IE2Vu8n
         +j5lOQwfYqfHS6B1dxF/Lo5GLd+LBJP7zx9mrNMpd4F/w4VJxvfQbAugeIHeml5I9lqa
         +jkBtYc+wWDq/BpIiTlJEuR8Gyqmkn462VQ1v0V+My+6iuV0cWEWSHijNeDeZCkhXTRV
         usMheqhsoT/kOQ3FXsZocvzq+srT+WCPyVirbaeqyF/YTbKOFC6uUa15xq3qwqGT0tcA
         WUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257632; x=1778862432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWrAzUBaU8exS/YJJSUkuMAq0O5XPD4cN6KpasU2G7k=;
        b=C+viBUaQkwVeQIgPErIOqo7LciqD125QCFBl1HWPu3gea31awuSatBm7SKhzhcn9O7
         0Oq5fRCiY9qwGSua6l2QqI73lk3gG6IxBJCWMZ9mkEVv4wZhDYdLUaan8t27Rsb96Lqz
         GJa4JwRororaZve4BYSTl5ZSU1XKI2fzfpABVCsPzk7AGkl9K0Icpr5o7rDST2bPwGTO
         XGMltvKclQuA8TTjgDQ9b9eE0csWaDfC2ZnhpotJLIWlZzRF2Zl/tEm/7H7DOAPN6jRU
         rc2OZs2wO/UxrN7C/f/EvED8t0yb0Ydoz44AMVgMJ8v6/UoH1trBSSLvdyLo5UJ+GodN
         RASA==
X-Forwarded-Encrypted: i=1; AFNElJ8BLt55NKb89yXlXirAnN1cH/0yA9hFwyz01h6rdbOZmIDac9FD4ztrELXfUyY1+6MsAyf+l9um8FYN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4janu91VFCbB5CzybGCBkm+DadKauHFKjK76rCoEvzKENUbc
	HB0F8RxyATg/9927x/DP1KEfC0dtmppRaxriwZ0fPsqADYjJ/CFhP1wkFBPe+5cAnyWaovrG6Vv
	cHoF9/WgxcxoCWhMxYgpABgWGCIxqAMrJCXAZO6l3
X-Gm-Gg: AeBDieslGlhQcfYkgt7tNciFX9+DNaiZwHGWDL5Utz8+NpPWo7KKPSGpjUqpcUX3/Ps
	lBaxAJRxSs/TAHNC/zmbXp2ZbBpKBYdjpECCoRR48lcCdtczUTo6wBxMnxYC0WMmhXSzi+F4m5t
	rW1jPp6SOu9v0NqJlrVmN0tM8z+eXP0v1mVplDYF2SpiQAV5ySE208cLpEphiG9edAfPSleV/+9
	EKuEw52S8fJdGJXkY0vJCoSO5LWO6QHNRgs+GwNt+bEDvrzpRA0GyDCfvNxOtK3oIxBd2sZhfve
	hs3bApHmMGY7/v6Si+hDlGefBrHJwo/lYcHDi3HMg74bYSGB
X-Received: by 2002:a05:7022:1b07:b0:132:1e01:86c6 with SMTP id
 a92af1059eb24-1326f1adf79mr146458c88.3.1778257631452; Fri, 08 May 2026
 09:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508-ro-zeropage-v1-1-9808abc20b49@google.com>
In-Reply-To: <20260508-ro-zeropage-v1-1-9808abc20b49@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 May 2026 18:26:32 +0200
X-Gm-Features: AVHnY4Ie_zoehI8s5zgNqv30LukVADTdXtN2wjCtxwLZ63ygAkVHFVZmFiSPGIE
Message-ID: <CAG48ez2ed44M=-qsZO7gwcz5L2njdRdk54d47jEg48MhWTkaew@mail.gmail.com>
Subject: Re: [PATCH] mm: make zeropage read-only
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Seth Jenkins <sethjenkins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 6:12=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> Put the zeropage in the read-only data section - nothing should ever chan=
ge
> its contents. Set up a new section .rodata..page_aligned to mirror the
> existing .data..page_aligned and .bss..page_aligned sections.
>
> There have been several security bugs where the kernel grabs references t=
o
> pages from some userspace-specified source, via GUP or splice, with
> read-only semantics; and then later on, the kernel loses track of the
> pages' read-only semantics and writes into them.
>
> I have seen such bugs in out-of-tree GPU drivers before, and recently
> upstream Linux bugs of this shape have been discovered as well.
>
> One problem with these bugs is that fuzzers and such will have a hard tim=
e
> noticing them, because the kernel has no mechanism to directly detect tha=
t
> such a bug has occurred. It would be nice if we had debug infrastructure =
to
> keep track of whether file pages are supposed to be writable, or such; bu=
t
> for now, the easiest way to make these bugs detectable in at least some
> cases is to make sure that writing the 4K zeropage is mapped as read-only
> in the kernel, so that attempting to write into it immediately crashes
> (unless the write happens through a vmap mapping or such).
>
> This patch might increase the size of vmlinux by 4K since .rodata is stor=
ed
> in the ELF file while .bss is not; but the compressed kernel image size
> shouldn't change much, since it's compressed.
>
> I have tested that with this patch applied, calling
> `get_user_pages_fast(address, 1, 0, &page)` on a freshly-created anonymou=
s
> VMA and writing into the page with
> `*(volatile char *)page_address(page) =3D 0` will cause an oops.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  include/linux/linkage.h           | 1 +
>  mm/mm_init.c                      | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)

Seth pointed out that this is more or less a duplicate of Ard's
<https://lore.kernel.org/all/20260427153416.2103979-19-ardb+git@google.com/=
>.

So this patch is redundant; sorry for the noise.
