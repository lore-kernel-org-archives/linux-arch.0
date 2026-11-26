Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795668789;
	b=xKXBsIrCHzn/tNxolSj6eiebOcqlfiIi+Vh+SFElCIAxR7YNHsWQeqlXCX4SxWXjrNOZ
	 2zR32rSZ0f8W+Eedq9JmmNd+SEGbFijKvy99SOdkirA5x+eOOLbTkvDt9MqbvfWFMEc5r
	 aeGbxhbuIfdfRE21pGwx+Gd1TnKC+PSzMFF2BUl/w+cYek6ayKLsCOfu6eAPTvf3h3nTA
	 OscxNkwRJGYIIlE3xe/rH2/I2w2zRVUi1CIUDmPiWgyn4W5jc+PQqU9Eqcs4z0h04aP2E
	 564k88n46Wm88GP8wZBS7edKHHBBU9Ez3Lb43gcuiEcj0J9d3AXbqqYg4cWV2Q1IstQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
	b=STNfe7WjD7zeRjt1GqDJ1uuG8sjMPtPLr1GOtH875heWpX+8NGhEv6VWlegD0+dUc6u1
	 iRD99HYeWlUnbx0CLvg/iscwPRS4nTZO0q/bga/N67izOMxZ/WyLQgbW2PQ+AXEnTtbjy
	 rlD/4ozk4NugFUTUIX0c1EMNcPXDJgke5gVgOqAgjNMyEiQxdPJIJ3NgVmt47tL+Gvy3E
	 eOBJbRnkYMgWOrIldtoW+R4DwlvWj5NaXE4clg9pNnrkA+wMhnnxm6XJvvxMFT8zpbEzY
	 Xxmd3hbkU19IcbMDsBs75e0ws9dqVbAsW8y2KBoWBq7LezPBCuDyF3+b9sKa33yNYRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Wt/H8uEX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FA606A329
	for <linux-arch@vger.kernel.org>; Thu, 26 Nov 2026 04:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524FA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wt/H8uEX
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55c7445cf85so1380871cf.1
        for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 20:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795668788; cv=none;
        d=google.com; s=arc-20260327;
        b=n0goY796QiboLul18PMuUSLj1tXTJEgrwv7rCeL1+q8nbr99p+EmaMaq0+t4SSp1qJ
         Krx2ze0DKYjcJ60SC1lnt8A4+9wOPsh/a+wBmyy3244BEr43hU4pAm+Dylb+o5W3Dhb2
         OGG45lqjMFdHUHjW2DiEN68xOhc+D4D0FlPxDNpCHXqB82KOqIlH3dzf/LGlzu738VA2
         gaz7+d/j4NLIhpjs+p+BYWbx7EqD8yGpXUAxCls5YlPJ1D0fOk7rqW22dbXU/dmk/xhW
         BhRgIJNnfU++RUWcmwoMjt+vNwugKhBkPgowCCuotGtZAdMqgnDAuqVXn0j8rfGBWl5D
         YvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        fh=QYlyRNHsl84fQUXuDh83yHYVYrEfh2sHk+Ycim+h3oU=;
        b=ajeeaJb9tpRUV+jvlXFloJ7WiTIAJqFpyB+o2Je52pDCoyOQzwGZR+HrTcVRbIWwQ/
         n3u+t+8unUi1vlrTIgq4kwbMLb3CU6VZdAryEgLgipjFYeu6fOU2vJmF3RjA1WEtVhJ6
         HsZhucy7hUCwjtvJIICudsPwIZ3NkiR71YqhojnlF0D8cDsXIt+q+slNbd1rqgVNp3cx
         LkfcE6l8fEVz31rVBTZQy45XMB20u1x9VgQ2yCGYbBFW9B+IwK8KzZrm426++cc5+7sc
         1oKt5is0pMcQyLqvgezIjz/SO8IsUVhyF6Ba9+9q34EbhGuu9B/XMeSIosotWDYpDyFw
         FYCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795668788; x=1796273588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        b=Wt/H8uEXeygfnRJXsnha4ogYR4WFdKKtucv0h74Hl9SvZ7ZVOZ8pyveIu/m+bbBuqU
         7pLEkyr5FS02oSIkkEdcPGP7aMYZHs2eR8ZbSslwbXiv4nig66Yw9zXIl5pT+EHlNoMU
         cQHBNyntCt6+GiY4hESZ00/HEKXKxMOneQnWVqwJdquEVsZ01fF3oKFb+IYLDHDd97P1
         5iwuBre8QUjJjwbIhiuIlmYLUamd902f2vsDR98ELoNLHrtAN91EmUr8k1YyhoPYh3J/
         v+aNlL3NNgtJeSDZE4JVJM46ZiSMrhfEMHEAp3euRyiB3I6N1f0aZKatBbawmZwgSrYV
         rmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795668788; x=1796273588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        b=mum74iFGrXjP014KH2D+x/kMkasl/GOrQjVvSVhaU87I3JHpLG+cU6xuIzbUr0/EKU
         RYZ4sBwbNk/nGLeu2LvURcj+hsTgt7UkaTko9sG9QtfhfEI0H/SZfLy46d7sta8Q34dY
         2VR/6Oeh5YBBRKw9DpPf74lkC92rCxjdRnNU7OAYp8/YzHEtOghIZA08bovkarhVKvkV
         YUwe2VBHM/xsJmLRjgZDqeHw6+imWDNow67vKp6z4UpzPUu3gRaQn5z5ziLyjXyNnKXO
         R6vl1TJpmBkSXYdudmMyYZCGRqb0nhC/nVj0GF0REAVGHuWoswHrvqBpMf2EPpDLa13D
         6lNg==
X-Forwarded-Encrypted: i=1; AL+hErGYQU7+F4ak0FDd3AsDRQhFOnsF/NxuJz0EMfw8fZlrnK7r2US8Ds+Hy8BQNNE/DwPFOjIUk4rGQhvH@vger.kernel.org
X-Gm-Message-State: APuU4Z/J6VGtX8gtXPKzyYGIO53wT7CpBuqq81CAlw0m07+dNxzGe8fS
	JO3cfGZvTtJBvzQAEhlIdMqa8X6s2Ed3zrLw1EFKDJ3HjeybK6kmaPPi+4A+VbZn7hBOAgFHQKK
	pBCHjP0uSAR7YBYBpdwo7YjrcQqcdG+b5jWGylLrR
X-Gm-Gg: AZFdTZezyG5KwAxXWds1JqZ5zkvMaOr6B9creZcEkVntnC1smmngLEqxxmgRAg+fcDY
	DleB7q0H/gOu2qN9f6NRgaVE3uz90mXNpaHDAvt06/opTiujnwgaPJiAQ4JgTftu9AOoSp9yJI6
	FmL5vx3TNQuyDrhgzNpGmPbWr3JFjZFH2ub4MF0gFR4lUrM+jOluYcg9PyhQRfkbbljhfrmdTjW
	op9DLPE2O7BG0gzWQyibGnO8v/8Os9ClSDJHagFLmROos0WTnRciUX6/BXIG2+03m57m2nyl+QV
	y9dEjqeAm6bLEk7OX4Bg8FJjmEm0/jvwLbdQ3J1h4FnvHOtwabgAQfSkjMVQX5HCTg7u1ApgJLE
	qza06ExZxantXZg8C4wUkHz+0/FHZw8V3GazS9TrlgpJBPy4OKSDXV255SA==
X-Received: by 2002:a05:622a:1e86:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-55d88127bafmr101738501cf.4.1795668787640; Wed, 25 Nov 2026
 20:53:07 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com> <DN4FM3TBOJ9T.2QOOL77P5HETO@garyguo.net>
 <20261125132225.00254c37@gandalf.local.home>
In-Reply-To: <20261125132225.00254c37@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Nov 2026 20:52:56 -0800
X-Gm-Features: Aa3M54pMQmXw5Cgtc0EakW9NOiIZs8STgUuBigJfJMSZlzejGTE6XZMetCnzc-8
Message-ID: <CAP-5=fWkUW787c4dGx9rccucqD67dfRgwBB_SoCxFnfZXtXP-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/30] unwind: Minimal DWARF CFI unwinding for user
 and kernel space
To: Steven Rostedt <rostedt@goodmis.org>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 10:22=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 25 Nov 2026 16:28:02 +0000
> "Gary Guo" <gary@garyguo.net> wrote:
>
> > A quick question: how do you plan to get this working on 32-bit ARM whi=
ch has
> > its own EHABI?
>
> Do we care? Isn't ARM 32 mostly deprecated at this moment? Or at least no=
t
> adding new features.

There has been recent work on both MIPS and Alpha for perf events, so
supporting ARM32 EHABI doesn't seem unreasonable. Devices like the
Raspberry Pi Zero W/WH, which use a 32-bit CPU are end-of-life in 2030
(according to https://endoflife.date/raspberry-pi ). It is
out-of-scope here, but extending the kernel and verification
infrastructure shouldn't be hard.

Thanks,
Ian

> -- Steve
