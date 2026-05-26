Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A83D8917
	for <linux-arch@vger.kernel.org>; Tue, 26 May 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788835; cv=none; b=ZqpnvULZxuffv2QygWbyvIHBIcLwO/gUIVk/O943fUQtrZ4OPPsOy2spqZh9lfA9Bx/PTWd16n/RyAmllJhyRLl0FphbFc2Ra5MCJtHdWGe9v7xlyAfwhxwI7wo03s6YqSMIp4q/LE+tufUe4RCha/U1U9p/pxdmFqwROoKZNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788835; c=relaxed/simple;
	bh=8+nGGSKlUH2wqELDfgHiAT/VMPWJ2mHhPQF2ouWQF0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDosrStafxCl5+Qz0nlYKweKqxYXHYFAMb3Wz7uyHcFfCA4Xg84HpUEArrCCzX+kECzLmZUAlWaZWqucxkJ/L5SxC39cbxET8f7LZrHHJykShQ+iIda6u8187JRa9tuarysjP/wV5rR51Fgylhnouq8DsgoL5cZyElBzeSYX3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EjQTkHLZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EjQTkHLZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490426d72f7so36691905e9.3
        for <linux-arch@vger.kernel.org>; Tue, 26 May 2026 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779788832; x=1780393632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R17d81rZFtdCmrvPdq6FOwdkUs8CSvLL3BM8+TQqKKA=;
        b=EjQTkHLZWZ8pVUg9gk59c/Y6msmKTq3bu4UiXtP0lNvzAnW1HzNIQOI+8h362r8uOz
         65J1roOpeed/GO/dcNRKF4mcOqiVwLlqNNBvo5kKdzC6J9wILMHJ9BvPhY9ry3PrsA4i
         n4rqddafwx34au/rxzpyxQdfV+/h8Wumnpkqoei2H9VUro489toB9gas7h1XDJkUk8CH
         O+9MN48NZdDBK0b+NhQ0p8I8EarJxSJgpWwmOXqd9qDajMs394MTLqyIaOkGFsYIRRjm
         3rP/59t6+CkpeqFn2g9Jsq3yp1J79p7PG+5nH+WBxj0dEoelXcyuvD+avrfoVM++dNME
         5pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788832; x=1780393632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R17d81rZFtdCmrvPdq6FOwdkUs8CSvLL3BM8+TQqKKA=;
        b=oRABo+GstjskzqBDUiW8sIB2ifU2nioGNwFRUv/7o+YpaQurmxFpT1Wg/S6Sd/YBw0
         YJ9u+47UN9lDWqhxepLOUNAZafPEPYxxj7FTYLW2N1eBdL52+BxnISv97n3nE+hFOqUO
         pRDSGoJLnXg3eYw0Bu5+wBWMTeBOsi3o/2s7wm6n7hlzVrGKIcAoZIMYeSxjcEv0tc0t
         1HPgzFwqA0/BNkIgxfHWLFMsN+6KgarC+6fA7FM0OojLNxnB2NzRJmq9hURaq9xkUkbk
         vjnqzxc3INXgQ/oqSnKBD0YG1JG/RDlZ5rOOI/fUxy/BN0V4FV1T3aS7fSpzFpvVxeGW
         2brA==
X-Forwarded-Encrypted: i=1; AFNElJ+rvo76pDoH5Q8+LbSOya4tn12y0iVm91Q/72SgZGTicSIbSE+FvffAL6fWk2x+jd4MWC4K2M+4yzad@vger.kernel.org
X-Gm-Message-State: AOJu0YzqP+Tf3fsOwcd85J6c6jzPukTjS7JfLFjqOL6Vvno+yPP2cYwi
	FoY7+t7tv1bXay4bZkYjJRoCyYvtxEH3ENepPm8671JSNRkXkBbmqiRMgmSrqg3vmUE=
X-Gm-Gg: Acq92OEJDaHSw6yK66HcH5V+tcksDWKYkOfbb8tFlNlXoGQb3GFENit2ZhXTrYVgg9b
	z70SCvnX6aZVqPKR75+fVxzb0CvLe7mEA6SEoU4ylNhZl91o7JjvvbLeO/h6kwhLGQh6LSEouZI
	wZs7CBgISXcOgj2AjfRWcURW/T3muZOi6j+Q4v7goidek0sidLWSXiecZaszr+4DXhbo40ZIv63
	UsoBsscqScwVpUHIfv/cBoK7022AJj3hb0nYu42LK/tT3fHpsEXaOUla0jS0U+JaZsuW7p17QzX
	8MW87Xx+ZiJ+i8aX4qXjI3ivTFAcBPRKN1MwNzLdyBCynCnYVaXIsyfj9OGteB4MkXppG5gRmuG
	zjdug5ubN+mV+5hUaChpdJrCvT3zdvblW7YZYxctPLBAeIzS++Q4a8jJhcq8xo7YJ8yOlsd6O7j
	VSmvvfgnWxGwqL7XfZ7UxqYq9HZJWJKzpBXm2i8/+ux8OXsnWcImQHTaW8yjYWZ1SerpD1uSkX/
	BHCroVDo4GdjkFT/wBShfi6+xOVZOarcqjezDCGzkkFgQ8b747V7tR4+FXIwsWNA/IyD7ewd4oY
	mY5E
X-Received: by 2002:a05:600c:6209:b0:490:601f:d776 with SMTP id 5b1f17b1804b1-490601fd9admr168561055e9.3.1779788832071;
        Tue, 26 May 2026 02:47:12 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b9asm307921735e9.11.2026.05.26.02.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 02:47:11 -0700 (PDT)
Message-ID: <8de0e6ad-987a-4729-bbd0-8399968dbb48@suse.com>
Date: Tue, 26 May 2026 11:47:09 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/14] module: Switch load_info::len to size_t
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?=
 <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>,
 Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
 Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?=
 <mcaju95@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
 debian-kernel@lists.debian.org
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-6-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-6-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Switching the types will make some later changes cleaner.

Since the updated version drops the patch "module: Deduplicate signature
extraction", I believe this change is no longer necessary.

> size_t is also the semantically correct type for this field.
> 
> As both 'size_t' and 'unsigned long' are always the same size, this
> should be risk-free.

The module 'len' would now start in init_module() as 'unsigned long',
then change in copy_module_from_user() to size_t, and then back to
'unsigned long' when calling copy_chunked_from_user(). The current code
is more consistent and mostly uses 'unsigned long', matching the syscall
interface.

-- 
Thanks,
Petr
