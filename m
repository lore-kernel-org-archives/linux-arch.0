Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A93DDDBB
	for <linux-arch@vger.kernel.org>; Tue, 26 May 2026 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792807; cv=none; b=SVTm20AJcqhb/C+nCkRj7wK2Tz7DsBJwQ61YkidofZYxXjyGuKv+o6m7HQx7iFvoXg3tyMJ/iC8iWkjCi7YfzQJ++XsMXosncGuBqIBlwJjG8Ft3deFEv0GHe9hBJGH/E2yOGAHT8gvCwtxL2TriUHkd4JITaOhf/50eAiZfHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792807; c=relaxed/simple;
	bh=2IkIxZNvBAu13Ws4fKNVPeBXSlEtFgUgVx7YLgf7FqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWnbVAbZSlZ2rBSQf5nWzho9B2GqwqvBiZAh8AF7LPEFBrha5GUL4Mfs6pQ3VZjNQyAj4xVQ7iCGtEEgKd7qwEc8jbUor+Y9Xyp2o38w4cEcCZjgEZcyUPSaIk3h/LOUnERV2OmZu8412eVhx5s66wMKfOQINrm0sS8hg885V24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P9vj4BDJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P9vj4BDJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-459bf19e87bso6132335f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 26 May 2026 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779792804; x=1780397604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ankQ6/0PQUNDJRsfxZkkDwmN1Szk45mZhdmBSOH36Gk=;
        b=P9vj4BDJ738bEySM3lt0h10n0hFn2Ykf0bT4a2Ll2krlRcxNrmJeB0syyRYI6qsWiL
         KcemkmekriERSdv9CZwdKcd8B4MLcfYU20brkmsELktEXxiUuOhni82tA4J9/a3JhPyX
         FYbvNfo52NRmuEbOOlML/hghFkxL9ghyvu/UG2Xe9wkOpuHhZkDThcZdSacQlbHMohwl
         VClNx+443LrxM+VJrbHTQ2vd8eKuItYd12wD9sQBySuyelP0e5ZeJVW5RIpSqQZo1hQF
         Hp82oIo3QlZwwIKSWGmjzXT52yIKF+m9a9s34CXrRp1Fneg5HFHq/gtmu41dpQl54wUR
         WSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792804; x=1780397604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ankQ6/0PQUNDJRsfxZkkDwmN1Szk45mZhdmBSOH36Gk=;
        b=i2XsI9MpOC5LWpB7zunTaHJdj3KRVYXY3ckqDvANojpozFILtzOB48pbcGzOgksZjx
         3K27Aun5Zh5/AE5A02ohH/uiA7Gr11+a3JPpHbcCDMbvEhCiLRn0gndQW7kkN7Es2G3g
         m0LtPcLYmkwHAqN8abDy4aIDqQrPI59auudGHxKWNFCwRlvNlUA45Zs6jzsNbrqpgDMj
         msEZcwv+kXnudz1BwwihxkDHSAiEqo7ZhpZedVr36W2NnmAJTlViHDzmVu07poDeOr/T
         52MZaNRxKYPDDGzvkjhPyo+mu+jW53iJD1SSA9eSmAssTnsvR0vMjlSsH++XZRlIV6rm
         +t/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/dhxw3pAnDEYUtLhpsMULQ20oLLwxJ0q9MmiQ7KB/4jYiOsjxwmBqTq2nSJVtx3vQMHtxyEFVidySL@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgzF4O33ptiu3N32ra+IEbiT4axbKkHVLjwBmki/xwMP4W5+/
	S5PToAa6PfzdoW6RrbS7IP5UNKf4QTtK6WnuKebCIBqZKXOsN4dJ9PI4lB2gFVc8FLg=
X-Gm-Gg: Acq92OFpfcRUCfRG+q7kMvWAXxZvKQ2YYisR+gktcDzWP+PYOQ7SeCRMkRTy8QouGBk
	JJEOFH8YzxygCQbFj28sgq0Oz2YJ1mjwMNC3D1mYeWls6HZEVQ5eQb5y13OKBSjVShXxgcKtPH5
	aglcaeE58iFJHux+sO4V4bB0G/Aq+b0cT1edQApnHo3wKLrE1zjQMa2aeUjTp6WVPkrzpmw11co
	qbSHbinQ4mPQFr+Fm26GHNKBSzUsgSSZYBSGJr26Qr7o35OFsQU5PveLiDq65UGYWncia0Kwmkn
	IXf5688fqJ+UgwZ1U8RjYBtvOnE7dc5OcZXcO4luxQjXYw5BkNV+9Q0SS0WRQnPGbP7XgmbLqke
	RuV3HfyYZlkQqKv3Fsfv47jjfFiYqyQpVrpxcfs2eituZrQkucctXauOIFoqyV2wiPe1lVFMYtq
	tnl6lsGPGuOYevCcLvo3JpIXa6ifelN9yk29RaT13TKYtUFJ39WgX25wZs6JVw9rK3tOr9NI0EL
	0FV7swBw1aUMMY3YmI8rCkiLN19m+bskTw4AtjOOKjKYkXHlGdMuw+7D8eW8ZtSHdyMJA==
X-Received: by 2002:a05:6000:2889:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-45eb38c5259mr30630897f8f.26.1779792804025;
        Tue, 26 May 2026 03:53:24 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6bc5479sm36850849f8f.0.2026.05.26.03.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:53:23 -0700 (PDT)
Message-ID: <0a0736a4-2cdd-49f2-9062-e2f18d769fc0@suse.com>
Date: Tue, 26 May 2026 12:53:22 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/14] module: Make module authentication usable
 without MODULE_SIG
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
 <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> The module authentication functionality will also be used by the
> hash-based module authentication. Split it out from CONFIG_MODULE_SIG
> so it is usable by both.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> [...]
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index f535181e0d98..84297da666ff 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -271,9 +271,12 @@ config MODULE_SIG
>  	  debuginfo strip done by some packagers (such as rpmbuild) and
>  	  inclusion into an initramfs that wants the module size reduced.
>  
> +config MODULE_AUTH
> +	def_bool MODULE_SIG
> +
>  config MODULE_SIG_FORCE
>  	bool "Require modules to be validly signed"
> -	depends on MODULE_SIG
> +	depends on MODULE_AUTH
>  	help
>  	  Reject unsigned modules or signed modules for which we don't have a
>  	  key.  Without this, such modules will simply taint the kernel.

Should MODULE_SIG_FORCE be renamed to MODULE_AUTH_FORCE, along with
renaming the sig_enforce functionality in kernel/module/auth.c to
auth_enforce?

-- 
Thanks,
Petr
