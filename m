Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C923BB9EF
	for <linux-arch@vger.kernel.org>; Sat, 11 Jul 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772967; cv=pass; b=mbnVOc+pHH9zy1Uz8fP+BSrL7HSSXp6kQ/mS2lZP+UVp4J3Y0UfC4oAmaYAu8EKRVnm/SikW3Yaslm/BOknR0yFYGkOuGKpsnzvhcInAckN9vtM9i+F7CNJRCNM8ZOw0SX9DtfNNzOvmD2hj/uLmbcNEY9LL91gS+guD8GCiGOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772967; c=relaxed/simple;
	bh=lgplXt8OmmYK0O5s0vGlPCfavq5E5GB8C7ljQ3QichI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n51OnNR2EJHP6s4FDY8ikpgPAfV7O7yhLpcGNGV5g4QsQyZegb/jJS34phenhluhgkKbDSxBbeVrqJ2i3Qice+kZCgzeszscz9cad28kh/Qqq8/1EgLfKWozEDx5ovyoO8NdKCvifA+7RR5WFkMD0OT5PxOs9yl9qZYpU2G3wu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhVAsJnP; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhVAsJnP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so2732020a12.3
        for <linux-arch@vger.kernel.org>; Sat, 11 Jul 2026 05:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783772964; cv=none;
        d=google.com; s=arc-20260327;
        b=ICiy9mYen0K1AIwo18tqGlflQskCefJHH0dp7GP7rdmTNj/Zz2sY6JR50VfCsHNfSF
         djtq9EJYDbbXnSIZOf9TuZ+yk5Wb6KE/hPpVNF2RgwAKIp2Km+BBEnl8MVizjVGXynDB
         S89l3GJXEcYYJAYfnuJfbqXvLb7fEC60SylgTP6xq4QB5Aa7XoaYYamYmJMcC9m0KXQz
         ljODJ45gTaUgc5bN3+jMbJOiey/OTRbNrG8R9fjkdtAK++DNunj5jaJCZF1bHLbAAde3
         cJpxhQFWTlX4N3ecd2hh7pxMbKD0LkFHy77XEgc+G6SHLPviLEpLPnRnYuSGgO+Ctx8u
         +s0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        fh=O7bYaicXDUDTqVzLKD9s94GSxJakiPHIzjoL/6ZBbYM=;
        b=CP/zkbHwHG2Y63vlViCZQfqyojoVM+bd3Jar9EVGBvVGibIZQmGGNPzoUnMO+JiRpb
         dDyuRwBBcXPUsIJJYN3oCwnBGjFXl2FicJ3fsOWs09YZpqdniYXEfFcIyFS7l8nV1e4G
         JiP5ofXlA5QmZaZ0mE6NQ1HBxXKeNAQKkz3g0XaDgwu924IR85Dq6C1TcsAK9N/RlvYz
         y24/M8PS/MkmbqUAXcH4ghuzw+iB2snFvFyRlv9igVpp8dSSb3DF1G9ara1ta8KP+0Iq
         kHWURExNIRJTy9j/yp7OcT4OWUequGclMnfxaqKBEgPHUidIy1nOp24GMuL9sedzlfbz
         JZ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783772964; x=1784377764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=KhVAsJnPccLQtlT6BW0pZOI6M33Kq5peNIi+brKc9mXt9N7FYBNxZiwumx0gXF4fIo
         sAO6rzobNlVEoIHs9Nr5Ud7Pqw06Wde6xz1P1K2kPK3YZyfFF/QcLy13zXrkpb8v6zCE
         wa1FryKea8CiALQ/FW+b66R5gxrKvaJKvQ5Z1BuPJv6JghHzUORCw6XB09TKL/k9s/1r
         i0N8avEwa/AHjCgBU1q0AZKoEW1/H84E5Jz1kEDp/nKMXzLRh+UDioLCoc7tRKEjgsZq
         3/2AvXjdSUp8fEKFVNQm320lqiCV3PxeKpLmb2suZXyxqugmSpsqzHjcuuYpicZfDTox
         leNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783772964; x=1784377764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=rO8irfzSYjqVs5IEhQ2thHraV1Bepsbx9qwNaEqmxMlChoihvBjLOdGpnin5lUrvuz
         Xb2WB5HZokC5uX33jWKKc7m0QWIyT50IRlQCMXQLh7T9cKBVo6sPLC4sgJ/SQJKmyLIG
         q6+Yadq5pU8KeQ1yamHLbGBScw9LI0+temexBi27iTAW/HK/QPjLjtktv3iU+8CIt8Et
         ptCEx/4T6IBmPoPFhQPbcOGnipfF0vB7a2P6FY8YueJWpBQf8nhoQ6Ml3OiN7CeVhodM
         0+tf/eyj2OhLULfiTgbupi5WBVGg1RDPf8mfzhrqfQy+EyaZqMH6bQIoagcnhfiL0cNk
         a4Rg==
X-Forwarded-Encrypted: i=1; AHgh+RpEP1jI7ukcl81oRLYNKIwcDV/0xwnTzQZFqOv45RD8g6JudW0iCd+c8l5Co3N9OOs70n5e9j8Twzo1@vger.kernel.org
X-Gm-Message-State: AOJu0YxLELqVUWnBdjaXL9bni4PxoFmfVUh/N8iCsj2UZrZFQ95y/dN9
	ZIeRve8dNVbRgkI/O0NmbFtVx90NRpzLrtW08h5C5ZgiMHeWFKXMmO7HSQMXe85+xmFlNiB1P8f
	Zz1Bni647cWJPyB1h7YKG6Gm3sytIQgM=
X-Gm-Gg: AfdE7cmpaIwY/TwQEGB4n43Ia6+K2qrdMqRghRtGihVoEAunKGzpUQjtqK4FM0nW4NR
	jCjhBBMZ3//1bUdDBsMflS5lDdEXfDU2gIwoxkJ0cLgHdxlc7H5OY4Q8iheb9n92AqUlV/81tnt
	jpXriQf3oeJ3XHV16B3seZ3Nbbw7BXZVmjXZzHDLrdYrmckEzrPqHxONQkto0Atf+H0NMhq5Bdj
	t6+/652F3/N2mNNjC9uWImzJP56aeLpfirkpAFrDlNmnLVf8hk0lEQPf65IyebxccKi0UdE5I+m
	bNaDx+2ZiB7fC7IEn+xO4jGQkp3zde12mVrq8OD1yaDQdx9htlSrP9aq9BFY3L0=
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr1210325a12.0.1783772963919; Sat, 11 Jul 2026
 05:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Jul 2026 14:29:12 +0200
X-Gm-Features: AUfX_mzOlRB8ana7x7qPQc4frMU9J060tNH0Z2GPCNvL1LYqDKQBjM-XzHbrvno
Message-ID: <CA+=Fv5RpgQ-UeGAT+VcLufte2gAp0H=J5GqZEFR_SuQsmnzy=A@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>


Hi Thomas,

Thanks for the series.

I have an Alpha GENERIC_ENTRY series posted and planned for the next
merge window:

https://lore.kernel.org/linux-alpha/20260706170019.2941459-1-linmag7@gmail.com/T/#t

Only its final patch intersects with this work.

That patch removes Alpha's architecture-specific syscall_trace_enter()
and syscall_trace_leave() implementations, so the Alpha changes in
patches 11 and 12 will disappear once the GENERIC_ENTRY conversion is
applied.

It also currently uses syscall_enter_from_user_mode(), so I will need to
rebase it onto the new entry interface introduced by this series. I
expect the integration to be confined to the final GENERIC_ENTRY patch.

The Alpha-specific changes in patches 11 and 12 look correct to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
