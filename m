Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208E3A75AA
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560328; cv=none; b=gFmg2NWNPef1KtAyW1FHAtVBu7+Tz+/G4o6F0cHUsAlwKzrw/0c4q926e4mhmcajNrqTk/W0DpAsK84XAosNbzWr5U5qLn6boVRZ7T7WG1CtgGWU//5cGtQQQBdlp5XpsN5G4OQili++C4GwK59toNiSgs2csdH1ojR6p3wpdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560328; c=relaxed/simple;
	bh=o/kOrCCo+fMsG/zyKbK9sMlBZ4cdbWSoTsj4GMMdO14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFDN5eunBp6Ru9YEdlWOOao4a08c7y0AldqCn6KfE/+d1qYOBbySjZLsBfloW0Nm/6AoCGBqSSRnRX7E6jM3G/2zcZkgIUwCvFa2G2VAqztNOpLZFtfMWwhDNSLsOxef1uCZRT13T0J3TYvamoep1MRaLSWiPJCO9+wtp8PuWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxNI5G8M; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxNI5G8M"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-485c45885e6so12125255e9.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 14:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560325; x=1775165125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q64ZpAFewOF3l9iLTHkbHOl134UR/SzN3vMtwvmgNnI=;
        b=hxNI5G8MKD8Y5ARvIozlhz0L6kprlBZ5GsMeUGFbUOZE2ppGchpgjat0MZyUOV+SJg
         69P33oU5Obe4GHsK12/6B/C5ckOmdA51CktXZKE9wsOW3eD6x6tw1bTLZONUHKUCJe6u
         z4/kXwABbTJQrr+CyCo9QacA45H/xyBB00xuwTrW36KVx96umKAhQ2S2uQ8w2rlUM1qL
         bdGNyuXMvs0AwDAacYWOq9dzOK7sQmr4laAHgsr7uKZYwCsmicu6CQEt0u+tNMpklp5s
         7fTtfAlfWTMVbvUdyD49vRx77XOu7p8QYzOq3P6t6xwsHk1E5P6OWAKeJTzQeXCvJnBx
         G4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560325; x=1775165125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q64ZpAFewOF3l9iLTHkbHOl134UR/SzN3vMtwvmgNnI=;
        b=WZSOG01qKo7zdDAk9x+jW7hoTwcte7oaWIp5P3x1BuM/fFHLOTbF2YfUoIXiJy5Jyl
         BqThsbA7M/fDOOc05YzMGHY2T6jcMqvfs5z/v40ltz256rjPFSBo2srq/9i1+/WqeshD
         0w0vCUR+aqRiaf7nkGZu62Y9m7IJXppETzyPOEHpDeKPWj2sn0HTXEXQ5jC0Dw/j+Q01
         RHbuSximimV7SASBNlJL7kJBC1WJhNAYhNJ0pXszmKrk9ntZoc5i8Y9enlQ8CGLbRhzC
         y97/5oi5e/r0+x4vNdCdW/QE3SaVHoksK8Hjo0UB0hllgl2JZzzHNIGKpIGk8W+JJ3uO
         fJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnJG9w5/CN7CqMhiyM1n1cqQJL8cZwGtpT3thc3YzibedoIOGbc5+zUam1BleTCofafGEA6dqtNOVd@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHOZDbfUQctIcMISnZqUuy1UWxq6YK8drnGYDT0VQSZ3XheD7
	GsSavoUX8O2FW5A/goCGUccDr3+dtegxaylHdbNIwXE1vBsrmGcmXeZ3P2E0nWqOSzLX/76hoRG
	Yi9voQnIr+4Onbs9iPg==
X-Received: from wmcu15.prod.google.com ([2002:a7b:c04f:0:b0:485:2e9a:31b4])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:e:b0:485:5812:bb9e with SMTP id 5b1f17b1804b1-48727d31801mr2881495e9.0.1774560325336;
 Thu, 26 Mar 2026 14:25:25 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:25:03 +0000
In-Reply-To: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-2-fa0796fe88d9@google.com>
Subject: [PATCH v5 2/7] module: add kflagstab section to vmlinux and modules
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
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 7 +++++++
 scripts/module.lds.S              | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1e1580febe4b..d64a475c468a 100644
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
2.53.0.1018.g2bb0e51243-goog

