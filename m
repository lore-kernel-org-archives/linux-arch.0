Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC03DBD54
	for <linux-arch@vger.kernel.org>; Thu,  5 Mar 2026 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729724; cv=none; b=OfTbDep7X6u9+U7D5H1BgW6w4VMCuR69M9QjoYJe/z7Fesb1c031bssbuUNrfOu7Mog/FJxheAFPLntrvJ7+C9ok5KapPDdPIYtQy0SfEpt3bY2KXOhgpCCdVkqpRJ4cJxGoihZP19yC7LiLjbi/mXMvzbaoygVsUWHNR4p7XKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729724; c=relaxed/simple;
	bh=P86ac5my1fDlI8n2GQxcGL87lpW9m2344uJNQZ3J/J4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y+oJeD88B5MXPF+a/7Us8M58wXTgbtkQiUxuD/poen73qSeO+7h/s/HUAw3Qf/WQ4SSUgN5Pu5s2NE9vxg/gpx+GX8XMOObbfxDx0Y03nfzkrRbGhM4P7rrKWitY/+f9I6lPs2rzV3V/XZulSl2c9dzN68kfZ01nx5rhlVzJ/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJ5moOhk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJ5moOhk"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso103966325e9.1
        for <linux-arch@vger.kernel.org>; Thu, 05 Mar 2026 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729722; x=1773334522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbFvhwKwxof5OBDT/AFQVHeuEBUcV4eoWuedVaHu8Hg=;
        b=wJ5moOhkHhAluxzc6h3ZQyxsF7siY/ARwflQr9ed1NaQ4Q5AEVQ/62VjwYxdUr9U5A
         mUZt1PQT9io84xRQjcl0yWz61IXktnKud4f2oh4zN0O1rKNJRgVg+9Ge6ZpoKzqP8G/X
         6Bp3ULIUA1wg6Gr1xITfCTcsw9ilkAA+C/+3iJFv8WWC2YXDHV9Kzz3kyKNf4k2W2hAn
         TxZnTTaXYXTlEF5ynh5DPzRXQCClaHH6gUOJcCFCSFJZUPk9lxARJ0pul15hbptY/0Xf
         xl6N6utSOnq+Wy7VqaK52I5raH0D+rJGprP15dQazA2qjCeYiVZWzcutmT9set8Ai1vx
         b7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729722; x=1773334522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbFvhwKwxof5OBDT/AFQVHeuEBUcV4eoWuedVaHu8Hg=;
        b=hLtQ46qfIyyTMWZGAlKOmATdxmVvMqvthzjGx3saU6dzSC+whrU8IvcgVdf0RoLSAx
         O7rvnhrylFNzbV72z5RFcfHxKyP43TEs3SAbclvS3F2SahrYmnWQJNdcVS/Y42/kL9N/
         BYR8Edz1u4l0hDq9cfnv/DnC78wY0TKDYB2Xud5nxVqyZTCVCT9a7cXJy+//R2l6xRYd
         rhWoD/7ZG9YSWWx+ar8W0YlKPesDo/eBO91UVZ/qD/Tg88V20EVhFwwApxIr/SSfd1Zj
         NtKP51kjIlpI2ok/1IXbtV+J+L4/SeSWBi4igYxqGYvrC/3vv2rue6Vm7+XNlHs6jD5i
         bedw==
X-Forwarded-Encrypted: i=1; AJvYcCWti0B/sQcYS9dg2bp3ayQS5iOptndqamx9PLs+xK6yFSUBzsiAXj49xHSHOxUCk0kLjHyG5ipDKxvk@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmpVYaiHbUAludmAYDSppsqrCL7dCuXYhzO4Lxdh6AI2DgpYi
	9K54lnZw30QjbU54M2tsPDyAgXjylQipf5Lj6BNBaG06ULlh5A4h+iIml0+PxSHlftD68lb3Yfc
	73EaSq9U6VMLixl49kQ==
X-Received: from wmlc20.prod.google.com ([2002:a7b:c854:0:b0:480:6bde:d3b3])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b26:b0:485:17a7:ba18 with SMTP id 5b1f17b1804b1-485198a6fd6mr101191895e9.30.1772729721708;
 Thu, 05 Mar 2026 08:55:21 -0800 (PST)
Date: Thu, 05 Mar 2026 16:55:18 +0000
In-Reply-To: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-2-6a76bf8b83c7@google.com>
Subject: [PATCH v4 2/8] linker: add kflagstab section to vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="utf-8"

This section will contain read-only data for values of kernel symbol
flags in the form of an 8-bit bitsets for each kernel symbol. Each bit
in the bitset represents a flag value defined by ksym_flags enumeration.

The kflagstab section introduces a 1-byte overhead for each symbol
exported in the ksymtab. Given that typical kernel builds contain
roughly a few thousand exported symbols, the resulting memory increase
is negligible.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/asm-generic/vmlinux.lds.h | 7 +++++++
 scripts/module.lds.S              | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeb070f330bd..8f825dcbfae4 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -536,6 +536,13 @@
 		__stop___kcrctab_gpl = .;				\
 	}								\
 									\
+	/* Kernel symbol flags table */					\
+	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
+		__start___kflagstab = .;				\
+		KEEP(*(SORT(___kflagstab+*)))				\
+		__stop___kflagstab = .;					\
+	}								\
+									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 054ef99e8288..d7a8ba278dfc 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -23,6 +23,7 @@ SECTIONS {
 	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
 	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
+	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }

-- 
2.53.0.473.g4a7958ca14-goog

