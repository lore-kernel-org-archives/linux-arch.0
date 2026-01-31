Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE732D0FC
	for <linux-arch@vger.kernel.org>; Sat, 31 Jan 2026 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769844999; cv=none; b=KGR97B6zRzr4Jzngu1+H5BZV3i1RBGCs9BCBgt90PhdnFhJ1y9UF15mY1nTyGOjM1cJ4yTs+j+lt6ePQa19D/Lo3J6HuEoHJatxiIN7sY3Iau3JTDkdQ+PeTsVvE4EQHT0avfIHJCZE+7B3xixy4ZUDwb2a03CWXlYfUGUfiSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769844999; c=relaxed/simple;
	bh=nY7lzQOVExn4AJ6nTUtW8NcMqjv6w/dyQWietm+R40w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5kj68If0S7myroPmhqUI8/y0tMjU9GgwPYgzFIhUylJIYV9Nvkm1NiQFEgYapVpD3152HOrMCc8/FJ4asMO+npjgH6XwJvYskc6qda5W9C+fPfmydkCW3fspRAOmM3/AZUKAvMQ4iUzpKHt/1mWx2tH1uVXPxxUW/qZpwZkPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxUD/sd8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxUD/sd8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480706554beso29983855e9.1
        for <linux-arch@vger.kernel.org>; Fri, 30 Jan 2026 23:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769844996; x=1770449796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n1UjayTk0hO0b45clVXSkBxo9hRuWG9N3/vJ5awb1g=;
        b=fxUD/sd8b3wQtQ+1lw6r6s407RaqfpNZfgGyYQigk6ugXox9dM52OaDnYiwwSqTzEl
         jEGEvibHs+f7Nqnaq7YuFS/JiIXWagxLk3hEhwz0ojyd/vHsiFtDQtX2FIKM4/RVsAzz
         F9HuybNgpagi9qIePKl/lGazzR8F4CR0P39bGKtsdeiqz1Z8AFU/nO9vMJgWj6OH/Cj9
         OyXk8Ln5zM7eieL5kmwj4GykrH3XxYSC/fe1Sh3xnK5tSExP682QdF4rTbYwfBxi6EqC
         7Wy1jeugDsSMWF22gL3pZV85LiwP9vGES3tElukotgVzSbOCKcBDDnCy2Glk5svSwHEE
         SZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769844996; x=1770449796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5n1UjayTk0hO0b45clVXSkBxo9hRuWG9N3/vJ5awb1g=;
        b=pDbCmZ2g0jPKqxOCrwsMl6BhwnhVsBOT4RT4pO2TZObBWPgPfasPcKcDoBLOKqg3jc
         UFFmNup925yW1WYMWOHYqy6mZXn5imAXbsjlryYuo5b+UdfDJLKtCSDtaGpSRcSPLDMa
         ys3Nt6URFxEH4rkNrqBKvay8sXHy+97FjXXasv+hI5qSejWc8ueNQs4QFMiPV0XQ6zKT
         StP6cqhR3lqzhqWwiMOcR19XkvMlfit1Y6Kwk59z+0X/+cCaAdzqHJBdGbt0C5/nC3Hg
         musp8l+1LU4f8k7HF4WkdWKnOvMtcdhyAOMHM3IkbSIMXjMGgJW4Z7Orm/SfuAd1i7Ru
         L9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW2wWIpycczHRmugPgbitciymCtytc4+d7FqqNTxV1bD0p2v6x3IG6kJtbtcuVOKtynPYeoqYa4iI+u@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5jHzVpI1McaMeETW7iwMvBOelAkfeiNXD3+4oFfo1mb3qXA0
	OgtkXzyvu7vIa+hun/3sWK9Fg4Kih1aBHicLfaw2/dWXzaug/0EW6okg
X-Gm-Gg: AZuq6aJLbNd9Pd65RHpKcJspq46UvKiOeAINCrJtHn1OI3OQlxGFHJjN47W5WDR8Jnf
	tQ3lYk58DPPTj+3FM3fItTN27xU1q7aUCPi3nRLN3xriR6NVHts8Y0TRJ+yIe83U80dbxU3nwnL
	S1vbNIy02MGZ6RgdZLWEIwjVQUo50pWw9YZD4XOlPq9bXxzqWRVZqAqoVDUjskzlS5/1HchnSpv
	4nPr3rBOQ0157c2qlGqPaFdFPj6wZs47wr99eGl83RYdV4FOzSIQpc/8HycFj/tFpNq0udUh8ru
	f4TGct/Efug0KjxGeaMXSI0TPdVLcxa06KTqAd5z0CSyFcqRohgSYw1xOaAhi14rpb6Z27xM34q
	CaHgHMtyLefg0ZW4gupzgJRAMl9REXKEWI+cl/c/cMeTYCOCx4h8a1IFI/knO5N1XqRGXBfUech
	LF
X-Received: by 2002:a05:600c:1e89:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-482db4ac0f4mr57301605e9.34.1769844995600;
        Fri, 30 Jan 2026 23:36:35 -0800 (PST)
Received: from legion.lan ([2a02:a58:9200:ea00::700])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cd8fadfsm248952145e9.0.2026.01.30.23.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 23:36:35 -0800 (PST)
From: =?UTF-8?q?Mihai-Drosi=20C=C3=A2ju?= <mcaju95@gmail.com>
To: linux@weissschuh.net
Cc: arnd@arndb.de,
	arnout@bzzt.net,
	atomlin@atomlin.com,
	bigeasy@linutronix.de,
	chleroy@kernel.org,
	christian@heusel.eu,
	corbet@lwn.net,
	coxu@redhat.com,
	da.gomez@kernel.org,
	da.gomez@samsung.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	f.gruenbichler@proxmox.com,
	jmorris@namei.org,
	kpcyrd@archlinux.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lkp@intel.com,
	maddy@linux.ibm.com,
	mattia@mapreri.org,
	mcaju95@gmail.com,
	mcgrof@kernel.org,
	mpe@ellerman.id.au,
	nathan@kernel.org,
	naveen@kernel.org,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	nicolas.schier@linux.dev,
	npiggin@gmail.com,
	nsc@kernel.org,
	paul@paul-moore.com,
	petr.pavlu@suse.com,
	roberto.sassu@huawei.com,
	samitolvanen@google.com,
	serge@hallyn.com,
	xiujianfeng@huawei.com,
	zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Date: Sat, 31 Jan 2026 09:36:36 +0200
Message-ID: <20260131073636.65494-1-mcaju95@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The current signature-based module integrity checking has some drawbacks
in combination with reproducible builds. Either the module signing key
is generated at build time, which makes the build unreproducible, or a
static signing key is used, which precludes rebuilds by third parties
and makes the whole build and packaging process much more complicated.

I think there is a middle ground where the module signing key is generated
using a key derivation function that has as an input a deterministic value
on the build host, such as /etc/machine-id . The problem with this approach
is that only hosts knowing the value will be able to reproduce the build.

Maybe this is a solution to NixOS secret management? Introduce minimal
impurity as a cryptographic seed and derive the rest of the secrets using
something like Argon2(seed, key_uuid).

There might be another approach to code integrity rather than step-by-step
reproducibility. One may exploit the very cryptographic primitives that make
reproducibility hard to ensure that reproducibility is most  likely valid.

For example, the module signing issue, the build host publishes four artifacts:
* The source-code
* The compiled and signed binary
* The build environment
* Its public key

Now, we don't need to sign with the private key to know that building the source
code using the specific build environment and signing the result with the private
key will result in the claimed binary. We can just compile and verify with the
public key.

So a traditional workflow would be:
compiled_module + module_signature == module

In this case we build the module, sign it with whatever key, distribute the
builds and the private key to whoever wants to reproduce the build. Or we build
locally and the key stays with the end-user.

While the cryptographic approach would be:
verify(compiled_code, module.signature) is True

In this case we distribute the builds, source code and the public key. While
everyone can ensure that the compiled code is the result of the build
environment and source code. The signature is verified using cryptographic
means.

As long as no one cracks RSA or an algorithm of our choosing/has an absurd
amount of luck, the cryptographic approach would be just as good as the traditional
approach at ensuring that a program has stopped with a certain output.
