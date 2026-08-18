Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575C3890E0
	for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2026 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095052; cv=none; b=KTfGhyUToS2oFNrCtcr5J+heDxVbH/afRF2OY9e8UuXHFjWbvvzb7RqjSy4su+jRBUhp88k28yh4sancoSqedYIM+CxpzKtr9N0XgtmDd81peRgOP/sP+67oPyT4QHqg9p6IQFrBOD76DMDIvmkzi5Q2pBNZylgNp7rZHQrv5VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095052; c=relaxed/simple;
	bh=vU6FrvWE607k5Xzh7SdBC7CeruR6Eky4BvR/CT7/VBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jxrUDxJaCorn58XmO2EJp/eiuKyE4HPh1Py7Tc/+oEwYpYsQR7b2FskkXlMFH59msC6bXjPHM7A+zG/mlLhxwqptVF3v5g1m4w8sGTFIzsJV7uj6e7iw2yctPe5CHPI4GxUVdYd/kheXLd8O8Q319GQfQ5FCvC+hE34liBrMo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAbgUXvx; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAbgUXvx"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so682514b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2026 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787095050; x=1787699850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=isOvqMF/5WA0EHYdsGtLtHCnG1u9xSNeKPU4MxGk99M=;
        b=CAbgUXvxTpNuxY+eyi6HCcnOmFUxIfc7K1tUDQw1U6bFF66oO3TMq3xA+HFKl7WlN9
         NVtUPuOgcpGpXuuoZKSqBB+bwwScGKXKc4mJsOl5BqHv0oAkmFUXigouylNwW1f4DNWF
         wNfEoDfyQ4b0yIhr1PblQ3DeAvCMJJZYdxjNe3nU5gKg60o5Z4SNHaUgr1WHPrxW5K5V
         dOhZ3EkyB15W+LFWJeddZM/zhR6sM2/jBRSKL/EMS1gIXV+2djtDk97ztkYOxhQeaK2V
         zcs3hlZmWXB4+lcKH4qeeI7ApGgJ+rS6dUOfsawv7YTkj8ySIp5fG7/x3Yf13l9/BV+S
         Wwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787095050; x=1787699850;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isOvqMF/5WA0EHYdsGtLtHCnG1u9xSNeKPU4MxGk99M=;
        b=DQZ100wUkGjVyLiWpPATBUD0ZNK1ShJCxC04tkAz9riSdZELRhLD0OqtZnf/muUFeW
         /eAIKXTSAFRYGANd+YO32oAQU7qaKJ7Y0MHUhf5RpLN+ZszPHWckaeOzHO5iPbFODAz7
         Z/+7ibeY9Mt9jcv+ImZebPzvHlY475jqaEVEQOW+QNt1wecjbIF1uv95Z5fncoQdfcv4
         0uQwT0+epOFl+zq3ejdbDni+Ww3RUxLV1rUmW47v5Bz85QhyXHRmjZWYo0O5Sl4wgF0N
         F1T+VDHJUvephBoC2aaj7MJDvQ7uFl4C3ybNZrICpwwns05Fq3TOx5EinIbLSeuSe+Ww
         Pp/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoCaP+OJwdH+DD3l1bq6XBM7PSvlPk3yWZpDAy7LdVGgzwTUNtJmXMGxHIevHHx5DIOsj8RV3WrcLsm@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqRXpnSj7JlWKXM5zCmW/s00ZM4zS0qFy51N37tYteT8y0bIp
	DA06g/NqbRU8zRLw9/pl4Yx3O7+KKlW6OdLNpVfN2PCNxOoeENoEIShv2zQ0uhR91zHKL+gy+di
	DAfwGhvRjOw==
X-Received: from pfblb8.prod.google.com ([2002:a05:6a00:4f08:b0:845:4da8:56a5])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23c3:b0:848:3f07:c5a2
 with SMTP id d2e1a72fcca58-851d38399c0mr327599b3a.4.1787095050148; Tue, 18
 Aug 2026 16:17:30 -0700 (PDT)
Date: Tue, 18 Aug 2026 23:16:33 +0000
In-Reply-To: <20260818231646.804507-1-wfelipe@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818231646.804507-1-wfelipe@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260818231646.804507-3-wfelipe@google.com>
Subject: [PATCH v2 2/2] init/Kconfig: make config INIT_ENV_ARG_LIMIT user-configurable
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wilson Felipe Pereira <wfelipe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

INIT_ENV_ARG_LIMIT is defined without a prompt string (`int`), making it
a hidden Kconfig symbol that defaults to 32 (or 128 for UML) and cannot
be configured in `make menuconfig`.

Now that CONFIG_COMMAND_LINE_SIZE is configurable across all architectures,
users who select larger kernel command lines (e.g., 4096 bytes) may pass
more than 32 command-line arguments or environment variables (`foo=3Dbar`) =
to
`/sbin/init`. If INIT_ENV_ARG_LIMIT remains hardcoded at 32, any argument
after the 32nd sets the panic_later flag and causes a hard kernel panic
on boot.

Add a prompt string ("Maximum number of kernel command line arguments") and
a `range 32 4096` to `config INIT_ENV_ARG_LIMIT` so that users can
configure their init argument and environment variable limit when needed,
while preserving the existing default of 32 for standard builds.

Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
 init/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index d03d42ecb0e9..bdd66dc7f628 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -231,9 +231,10 @@ config BROKEN_ON_SMP
 	default y
=20
 config INIT_ENV_ARG_LIMIT
-	int
+	int "Maximum number of kernel command line arguments"
 	default 32 if !UML
 	default 128 if UML
+	range 32 4096
 	help
 	  Maximum of each of the number of arguments and environment
 	  variables passed to init from the kernel command line.
--=20
2.55.0.737.g08866a6d13-goog

