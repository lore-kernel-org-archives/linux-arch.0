Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B137F306
	for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2026 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095045; cv=none; b=s194iWqu+1wIU2ckF+CWCKmM4FvTMKv803O25fNsBwyIJR5u2vGSjD8Wzlq7uGkiqWqHgKqqwgW29u7Z6v2vrrkvwEGm3GnopIAte6zHig3txtTmLJYTG+WRy7UIX+SbCBuGVdP68J2gOkf3XhSryb0a0l7RnM5rjUpjj5djDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095045; c=relaxed/simple;
	bh=uO9nDqAz7YG3W4fAtHpBP/Sey5BPPWi/cU3vDu2WIPM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UcQyof0i/p034kpYuetJuiQoEPy3v6KXigkv3T7h01zTaCbX97QMHsWJHdJOroaxY71EITBLrf5c4xiq4ZWK9CbCr6GxTqdz7FxGdq/myGfWD/I3ZixDm53LBdiACHuunDWg76sglwBPX/qgotE5SU6ebxBLpUgzVZ4veN0ohKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxrNOKy6; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxrNOKy6"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848d21bbb55so729338b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2026 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787095043; x=1787699843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Us4VG+LG3CItnApG3/Giy5h2nvbYWbtv9395p9c5DHg=;
        b=HxrNOKy6ntxgjC9mBeV3lApm3UKT8XmAjqs7rCSQYvsRVVII/gpUBOAfUi9F21/5eu
         9MfLVDhUSahHhcFqe4QzaG0eYsidAI8nb3e2MK8/aroGZ7hoWw55KZzCV/wRKqtZiMry
         DLrAyRoTSLsehnX1mBqo/VIQPquY/1IUOc6jlOQZWqjeYzTB96itU4iWJopUUmgT2u4W
         GxDbuZDh05OrG9AO6L/UwkWC0uBftf2qxTDbj9l0vEG8nkKC2Awn4acR+aWCaIa/kjx8
         Qn/oAxn8R7uud+s3EAD0Jg3rpKZaKygajXwdXHkpwzO0sqYYUBnT8kIbZwcR/7sKm/F8
         +9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787095043; x=1787699843;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Us4VG+LG3CItnApG3/Giy5h2nvbYWbtv9395p9c5DHg=;
        b=UAvoPePfw2zpBkfbgIHUWweWLblqJPrgADMckP31R+gsz6/ooo0jWDZ40Z9HbYWxT7
         Rk0iHKASw2RACw6Hw05FMbk0dGBO6DZOhCvbfJJYmaLPDZaoTHupR9MO9xIKVtvgqExe
         pDmfFulivty3dp12vODI3KPgsYNgan9Z7fF1Tv4flHGn8L+0+YxAoH6evX9YpFG5wP5N
         8wCeOrJoEHdi+17yAFaG5vA34mYqYJZBWY0wKLuv9EefV7tR+QAZNa/4P7Mm4j0kyzeU
         15JEqECfOJsRK25QbORyvM51QMi3kQ7+zV7iM7KdJJ76yZDr9nE6HPLE2AIX3SStVUbE
         qHBw==
X-Forwarded-Encrypted: i=1; AHgh+RoYATdCUTCUYl/Jdsb5+IPnUqe0C+0Y0m0+APMkRLV1+iOfBWbosNiY3Kjyv81nrMUTA3olCE+f24Dk@vger.kernel.org
X-Gm-Message-State: AOJu0YxNT2hOPZT8OiNrYF79c0QANIwAZyUkoWr4jsdHG3Rwj0KnJTQI
	vJTrJnOT9EaI+BrLQLG9p96SAAHUjm2lGLDa8jeLmv+MsGA+2CCCOYDO2N0eg3R9+TE323yi/U7
	nZxqFQ9Bn3Q==
X-Received: from pgiz6.prod.google.com ([2002:a63:c046:0:b0:cbe:e4f1:a597])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8c:b0:84e:2722:5d9e
 with SMTP id d2e1a72fcca58-851d38399cemr351833b3a.1.1787095042948; Tue, 18
 Aug 2026 16:17:22 -0700 (PDT)
Date: Tue, 18 Aug 2026 23:16:31 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260818231646.804507-1-wfelipe@google.com>
Subject: [PATCH v2 0/2] init, arch: make command line size and init arg limit configurable
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

This patch series promotes COMMAND_LINE_SIZE from arch/s390/Kconfig to
init/Kconfig to be generally available to other architectures.

In some use cases, such as netboot kernels, rootfs configurations, larger
initramfs setups, require larger sizes. While for embedded workloads, it
can be reduced to save memory.

Since COMMAND_LINE_SIZE can be larger, it also makes sense to allow
INIT_ENV_ARG_LIMIT to be configured.

v1 -> v2
* Squash the Kconfig promotion and architecture header updates into a
  single atomic commit.
* Replace Originally-by with Signed-off-by for Maciej =C5=BBenczykowski.
* Add architectural range constraints for ARM, M68K, NIOS2, PowerPC,
  SuperH, and Alpha based on hardware, buffer, and stack limits.
* Fix Kconfig symbol for PowerPC from POWERPC to PPC.
* Split pre-existing init/main.c logic bug fixes into a separate series.

v1: https://lore.kernel.org/all/20260806061429.474992-1-wfelipe@google.com/

Wilson Felipe Pereira (2):
  init, arch: make CONFIG_COMMAND_LINE_SIZE globally configurable
  init/Kconfig: make config INIT_ENV_ARG_LIMIT user-configurable

 arch/alpha/include/uapi/asm/setup.h      |  4 ++++
 arch/arc/include/asm/setup.h             |  2 +-
 arch/arm/include/uapi/asm/setup.h        |  6 +++++-
 arch/arm64/include/uapi/asm/setup.h      |  4 ++++
 arch/loongarch/include/uapi/asm/setup.h  |  4 ++++
 arch/m68k/include/uapi/asm/setup.h       |  6 +++++-
 arch/microblaze/include/uapi/asm/setup.h |  4 ++++
 arch/mips/include/uapi/asm/setup.h       |  4 ++++
 arch/parisc/include/uapi/asm/setup.h     |  4 ++++
 arch/powerpc/include/uapi/asm/setup.h    |  4 ++++
 arch/riscv/include/uapi/asm/setup.h      |  4 ++++
 arch/s390/Kconfig                        |  8 --------
 arch/sparc/include/uapi/asm/setup.h      | 10 +++++++---
 arch/um/include/asm/setup.h              |  2 +-
 arch/x86/include/asm/setup.h             |  2 +-
 arch/xtensa/include/uapi/asm/setup.h     |  4 ++++
 include/uapi/asm-generic/setup.h         |  4 ++++
 init/Kconfig                             | 19 ++++++++++++++++++-
 18 files changed, 78 insertions(+), 17 deletions(-)

--
2.55.0.737.g08866a6d13-goog
