Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A9361DCB
	for <linux-arch@vger.kernel.org>; Tue, 26 May 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800628; cv=none; b=J1upIvgqHEe/EI/Ced/n9ZuYx3Mk8CYZSD+2uVOfAEnMSbXQztK8JjQcEboLDAKIfMtBcaKKUXrHs+FXnmZPaQ27uyxU7TsL6lVaxeYPJzpqz8JOP5uB9ms/tq0drER+HWIADP6IKkxhVbJ8JpjLMKeaOBM35aTk0pUEboDTgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800628; c=relaxed/simple;
	bh=cIV7eVLFj1WSRdO8UJfWGAKcQ4RL3tgfGuH1jAdS3kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqmmeUbIso6iu5zWqwPs/3mzsGRB1O9DUFknGJ9mVH+FzPGO83192OX3SjiZA9WrrA4/m9C3Hc0AxPUr6EkRNshEPDJS7bX5njsQbHX8uAfe2VGRYuBLHWGMGi7ulnG9d+rjZD1VN6E1ajHBwTesaLTjUqUltI5ekTNDzSnql8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EKza7bFe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EKza7bFe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44a5174670eso5942888f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 26 May 2026 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779800623; x=1780405423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=EKza7bFeRfOQx4baBBdJSdVBzM2bve8Vku8qcuHTL1cYVJoQa2hWXbtAPm6EKv+KnF
         IterkP4Vdog+meaG7Vze1zOImzDCFf+4VYTp7uhiBNH9SWeHBhz67Egxfm1Y+vIwLZkq
         iXkupGSTgn20E5+tdlHJ3VTYvJ9nWNOMRCMpxNamsJCwQ3jmAF7d/A4FhvgNh/dKB1k4
         jIdjIY35h4zCtboEngwh4wP1MQ8ujcO+wcL0uxiix57Hu9LdhlaJfHiWyzZZd8DrRvr4
         dWlyVvqCuyLlokSTAwAvFB6yTdsoOhP0YVuxsM1t5zz8rNsgqshkwHrtovjbfmMBXRwA
         jZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800623; x=1780405423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=Pva4jYmq/MWOxjyCgW9Ce4g1SNQdccrK+/FkIu/GwmIY0RiWXXMOwj2GRFeseMRuJG
         fEZg6wpo1WCWh0L6/ecJr5WpT1WUU3IZpZVEqjt4ILKlbkoxAkG9f7PSHfOgLXfPM6Kq
         cjZCgtJDijSdQVpnrcen0c0K7JgMDbwqeMfblzQY9ddKXZlkf7h5/fZCRtaj4QpPEjw4
         7ty9q5eVk344S+4V4IATjU+IVoikO4dlSdxul40Vhgjg1P47VEaq4zNgjhNIz6Hmq2OL
         y+G38hH9v+99Xe2ds1c3lgfZAs4+GapWuT1cY5ejm/ndWo8aRyj34pKBtvHSpG0enZ0u
         8CBw==
X-Forwarded-Encrypted: i=1; AFNElJ8TKP8CarX9edDHLqODW9VsedEM53oVbSJosroLzkuMlHDrVqhFsBEtO611gV2+aMaJW0+bjFnOuc+1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SDTfagp67ukv4zh6vUQhgwvYljzV3iavb8vbZ1deUZFCa5at
	3FIBm1RdMP68PVFop0mv9n/5lWb426Opbq0ebHz6VL5OsUylBOMKcbGISjXzt0tQSUk=
X-Gm-Gg: Acq92OGfsY45DU8Yq4jVmk78DWBJjg6kJW5FOEBuB5rFWuC+GFcRA/rC0/zN+jCqtah
	piMb6KU2idT1467yer1UwLyj3cqbA+wSUz9cWXJzo+7f9Sp7XNtDA6e9h6RUKctl3qhi2pCJ1xg
	B/nMz/bX+J420aFiaEqJFE1UZ2E04z44trC/0C7pSsSyp/wRTs8DigEJN2J7I9aBGPttGmapvHn
	TBHixuCl1pvs2OiSRs30NGC+DUItA9JwHMIAqjv+bkCRJnvtUPq5WaD3C454Jcb6uprxLYswl2E
	39PGrx1eWxaEpjSf4alsYUP0FuSWDz51VutM/Vp+O2AHtQaDFTY/Hs7S89gzYy1tMITwtGq7lx1
	KB0KzAID7lTvIpYalxn2MYNsTB9SHrcgjOONIsj6mep4WaSzBzVwlqG9M7apxgK5A2RKQy0hofV
	PnFbZ6eTlTlszDUnxw1eiUNS1hGHOTW/Dou6rs0ZEaA1dr
X-Received: by 2002:a05:600c:45ce:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-49052c07823mr223327865e9.9.1779800622880;
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a198sm318501285e9.10.2026.05.26.06.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Message-ID: <635fed3c-4e39-4357-acd1-13f1653f9e3d@suse.com>
Date: Tue, 26 May 2026 15:03:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] module: Move signature type check out of
 mod_check_sig()
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
 <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Additional signature types are about to be added.
> As each caller of mod_check_sig() can have different support for these,
> move the type validation into the callers.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
