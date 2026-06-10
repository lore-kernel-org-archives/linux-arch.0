Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A4F9E8;
	Wed, 10 Jun 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120391; cv=none; b=QlyLdCqHs6jAEVh3OaReyxcIFlU3QT8VZYYF6skIqNKNvW1RJJ8LS/rjKogSAMzxjccgyJ/gRIPh4xgKYn4/fs2+f6uNIJBhZzLhziCWWwIZf3tFFuMV5VL15kfv//ou+c9l8FhlxmVaJVGgui6FVtVm1bKCTRLLLpWhLY1qX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120391; c=relaxed/simple;
	bh=GWZ9PDkv6iAEVxTpAqny6/ydn9TMuFl2SSpXyIW0BUE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KMLDSZ0rtR1fk9F0dCIkofIAB7SvOK4QxcGhkiZNof5sDxd+uFL+wc97gLPVDGVRWEEqS1HTqWhG2f2LYFYlejtTO1S72qO2AcnGE9jLKK11A3Fr8ZGI7ueUDrnzpYcxyqcNsAhv3iS2BeuyQODz20b5xnVZZfQ8pVpuf1SeU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JcwOAfGS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I6N1ITuP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JcwOAfGS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I6N1ITuP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CBB35EC01F3;
	Wed, 10 Jun 2026 15:39:48 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 15:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781120388;
	 x=1781206788; bh=NqdYBQWFHFEli9IDL2ysVJrxqttFz0CwMRMUHf20k5o=; b=
	JcwOAfGSwnDPHaqGRBnSrNFvACtlAf++J+VvqEDppE7KjX2zVGASiBjX8XTLyTEb
	cqOBrQI+SuJ9MUd5bfbXFt9pxJdX6BHxI4fPeyft01b0cr+eQOqxK33FYSOvbeZc
	tRrnv08Bfo1Fzhhke1dCErEazmdZrtYtV1GAalCKdeMqMxcJak0S7eIkrFt1tvwm
	CRpQwpdY+xFmBmXNDrxDCNuP7IRP0iNV08B3eZxjgtVXkb7VzZ93TNpNOLgYy1HN
	BeCY4FgiMcw19ZA2d/ENd0Pe0vTNhOvd4toV3b3HleVSV8an8xuBqTMJgieEi9S1
	VIWCftbNWgl1W64w+LTI3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781120388; x=
	1781206788; bh=NqdYBQWFHFEli9IDL2ysVJrxqttFz0CwMRMUHf20k5o=; b=I
	6N1ITuPqciMp+fJS46tN/KAt0w9ZdsFknHL6VsoptSaftiP6ZMysp7hwgtXQmfOV
	oJgYbqNzyYoTuMky2HJujfa8IiXtxDp9dtJ2786fjRixCV7+I9oPd4Fqpq1t80HH
	UaJ/CK8uPdb4/78U0QSq0coY1ZZPfurDnb7XI8jnZkXwhwp9Fo4suxEE/LgssSBM
	hlwesLNZ8j/2qkyRbx8nIZaOwPkDJCG9fr9c1Am3tcZc1d67CMBi4pEcxU0dPheu
	tgv2HzOmTPCQSPF0wetcewMJUL0Rd6qExO4/k9xawqDdC6Z/+g9DfEAZFVlKmsTo
	K1EAJeRgidM8prBnEYjHg==
X-ME-Sender: <xms:hL0pagAGyeARbP60I-PXfw1KKerO2J1PXspSi1Y9-gl3WPgub8wVuA>
    <xme:hL0patVhirQQuEosRQls7Z3zXuxny0BA-g3NFHj2wcI2ZzySGKsDEcwCE7PEO8Xk2
    WNELPol66FZeYL6boNnxXkceyfMyX4MTzt1hb-BNhLFRt99ZRaeXEM>
X-ME-Proxy-Cause: dmFkZTEJXg0EkZJzjkCtDsSVin1L8yZ9dOeiZBu6dVbrUkJcNcMI+00RYYQUt+HNHfq2N6
    awqa3xAnhFAZMvIxKIt5aFgAiBa2veTzjWYXuquThKe0EDKhOmTZ2oeS6Cy73zBiT3fyOo
    WEpuk8Iq+ygICDcHaLClkqAwcHLHplK61L7Yx+O7XWfbiW8CtWq2dBLcunWgdSZtruhl3h
    YJqAIxQubJ8ey2TzHs43gr2IjVHYRyuNBvdmcAJ8UT31zDjtBcKZS4YpE97yyAIRbIiYAe
    GuozHrUZrRHj06VtpsKS+5L4kbirezp/I+P+iLUFQidXTpOVgGLe+Tot2vCWCOpXeiqym0
    +7IU5jKrZDrkrbyjOrFNEwdUz3BkbFHr7VAHPg7PlrVkDK712FVsnuRRTFIlMVLpByP/JD
    HjOaCdy9CNhOeFr5bWZMynuDJO87VB94owBOgmHyAlvT9eNCBS3lv6sh6769UzIT+ErPxU
    mPhjnju3DGUYEm70L+ZydRUcsfQHlMgfBz7tZVcQ9fSw/a9mvDKodE9PDMvyi/fNIP5Vmq
    +PqgaSGCL/To07JCm/vzz/cNRai3A7tzJqnSuVUIIuuvClPtRv74gaX6lD1HyWDUW/ukgV
    dhWUUVLM9fFi8ObGy0xGBx8ogF3tGmDI8oyXeipJQNCzDHl1f8ZvJfYXnsqw
X-ME-Proxy: <xmx:hL0paia-HPj5dpQVGyDh8eMOBO39bArDr2w-JmJ1d1fvN8Hd6GJYSw>
    <xmx:hL0paiXYp0l_HiENIiswa08NyIxTjD8sXC1_HeSrLI6BdoRcyGMS7Q>
    <xmx:hL0paoljrfUsOMPqweTNUVlLBtHvBTJVsEYmaUUuuMdz1GNyZpRhrw>
    <xmx:hL0patAFyxpvWCPMTrAx2fe_tKAM1owJAmjLFHHmcpz4PsRESz16ig>
    <xmx:hL0papyrflcnvuaGFz8TQrH0UuElCwbZSvsYH_FjJfmKA0iEcGXtkJa3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 38D241820086; Wed, 10 Jun 2026 15:39:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A35GQ856c1Rw
Date: Wed, 10 Jun 2026 21:39:19 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steve Grubb" <sgrubb@redhat.com>, "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>
Message-Id: <4c885308-7556-49a9-836b-37089ac3bafb@app.fastmail.com>
In-Reply-To: <2021591.7Z3S40VBb9@x2>
References: <20260610164719.2668906-1-rrobaina@redhat.com>
 <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
 <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com>
 <2021591.7Z3S40VBb9@x2>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026, at 20:13, Steve Grubb wrote:
> On Wednesday, June 10, 2026 1:40:47=E2=80=AFPM Eastern Daylight Time R=
icardo Robaina=20
> wrote:

>> > scripts/syscall.tbl:79  stat64  fstatat64                     =20
>> > sys_fstatat64 scripts/syscall.tbl:80  stat64  fstat64              =
    =20
>> >      sys_fstat64 arch/x86/entry/syscalls/syscall_32.tbl:18       i3=
86  =20
>> > oldstat                 sys_stat
>> > arch/x86/entry/syscalls/syscall_32.tbl:28       i386    oldfstat   =
    =20
>> >        sys_fstat arch/x86/entry/syscalls/syscall_32.tbl:84       i3=
86  =20
>> > oldlstat                sys_lstat
>> > arch/x86/entry/syscalls/syscall_32.tbl:195      i386    stat64     =
    =20
>> >        sys_stat64                      compat_sys_ia32_stat64
>> > arch/x86/entry/syscalls/syscall_32.tbl:196      i386    lstat64    =
    =20
>> >        sys_lstat64                     compat_sys_ia32_lstat64
>> > arch/x86/entry/syscalls/syscall_32.tbl:197      i386    fstat64    =
    =20
>> >        sys_fstat64                     compat_sys_ia32_fstat64
>> > arch/x86/entry/syscalls/syscall_32.tbl:300      i386    fstatat64  =
    =20
>> >        sys_fstatat64                   compat_sys_ia32_fstatat64
>> > arch/alpha/kernel/syscalls/syscall.tbl:224      common  osf_stat   =
    =20
>> >                sys_osf_stat arch/alpha/kernel/syscalls/syscall.tbl:=
225 =20
>> >    common  osf_lstat                       sys_osf_lstat
>> > arch/alpha/kernel/syscalls/syscall.tbl:226      common  osf_fstat  =
    =20
>> >                sys_osf_fstat
>> Hi Arnd,
>>=20
>> Thanks for reviewing this patch! You're right, it seems all these stat
>> variants should be added as well. Steve and Paul, correct me if I'm
>> wrong here, please.
>
> Alpha is unsupported. Those are True64 compatibility syscalls. You can=20
> include it and #ifdef will filter it everywhere else.  But, yeah. I gu=
ess the=20
> rest are ok. I don't pay much attention to the 32 bit arches.

Ah, indeed. I assumed that these were part of the syscalls that
originally came from osf1 but are still used on Linux systems,
but it appears that the stat family was never used like that
with glibc.

The oldstat family is actually in a similar category, as those
were only used on libc5 or earlier. stat64 is definitely
still needed on 32-bit userspace with 32-bit time_t.

     Arnd
