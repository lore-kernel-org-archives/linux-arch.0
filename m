Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B83A873C
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560336; cv=none; b=JgNZx+Mv9AcMBfpX3hAfM5lCQLVqd5yEWTrUdXkOf0I3eudrrE57QSR8LiPfHD8CN0EO4WnFjzRYafvX73ASgeECqpfvJ06spjKB0K0Cda8VSy37+yluScqvqzzMLb3Ps30acaEnlZoqWZaKzPgiReq2FeaR9QxxsBlTyg40T8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560336; c=relaxed/simple;
	bh=lUQ7U8VJ/rlQHorgZU+GXUXjuVr+UBXICgrCGqgyAoo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DLt/gYCWtZ522Fxxt06y2kfSL5TE1T+Vl8/RaT1XpYu23//j6A0S9uVnIR+VnT47SKDB5uvqclNYi0tZjwqQvvtJ3P1TwNeJOzu3Q0cIz5Rm7ScIwmoAiRcX6zcK193/Msji/0s7HU/9pPd6BS3+9k5/2vqWwYMzWdPAFMpwCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Md/wQu5l; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Md/wQu5l"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-487018c8244so12384335e9.3
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560332; x=1775165132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug/Aikg8oXAqlbbl6AzYUeKxZkIdPz7Q+TVSZpI0rDA=;
        b=Md/wQu5lBGLdZR4ug5+jWwene+rcsKJ5H0kAQuUNr64d5qGj2BYd08QH/4wYRbQZjh
         C5EuOjzrCA7SzeY3Ec3fCq0118NbHSBeeQCB5Ojq700gXOlYJaUb3jud09W3tS+NMa/t
         qp2CgKfGVm76ii3CWTSkNTOvEulWUbXTNuTQSPJ/u0Nwp6EjHhomLqlKTuHjz7NJLlng
         2GkM4xK5twfnNCsWyEP12q7gYRSMJAigPaJ5zoLbKfZeOnRjWOx/RwPflOfplMGX9HRH
         9W729f3dEW0LPIgefyN42KntPMUq/rqJMNOqHmBQcSz0/AB/jSMJvrt9PbwiWA5ocxxs
         2h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560332; x=1775165132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug/Aikg8oXAqlbbl6AzYUeKxZkIdPz7Q+TVSZpI0rDA=;
        b=o+wCqCC3W8filyb4qOJfikA9J5TVCVDVAD9CiLxmIQC8bhHa0Y3rD//DS/KTgoueK0
         WNLe/eXoHtewHDBUTdxfvHLdjMeYIfaZ/dWL30OIi/MHzWOIU8mWow4/oushAOt+MNp+
         Lvs3Q6I2U3Mq6TuAvdwCOpgVYZfqn5mbU9ltuZCbSv5jioApi1hxDZpNInHmmCrhm7Vm
         sFt1cjBs5vslgPO0SgAT3EmRkCEaA6dgyZZW3enLQ4SYTD4qmo+ZWicwfzEcRv349xi/
         6FUEqoIUbtJ9kY57pejCbbIQNiUvJ+uSGLwDABSge2ebdHXbCY/9FKG5z9HGRpwygo2o
         ahgw==
X-Forwarded-Encrypted: i=1; AJvYcCV8nAyQLR/ajJinvqw43kA8NVw43m5oLE/wMiNLTLFKVH9f22TKjiQx9Y29Z8qQ1pejtU60AsxvRyB0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4sHiUTWTlMphx7DHkD5cI7rwauS4FwSFSWHmx1PMMO02Crv3
	RuOU4RuesLDjtoD73FbRV8OFIMrxOAxcS6OU0oCMavIKKmqA1rlGifr8/k7NzwrIctF5/bLveMA
	nCQbmO44Gqzr7JTRM6Q==
X-Received: from wmsk8-n2.prod.google.com ([2002:a05:600d:8488:20b0:483:6cc0:9daf])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1e:b0:486:fc95:1a91 with SMTP id 5b1f17b1804b1-48727f2373dmr3081075e9.12.1774560332192;
 Thu, 26 Mar 2026 14:25:32 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:25:08 +0000
In-Reply-To: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-7-fa0796fe88d9@google.com>
Subject: [PATCH v5 7/7] documentation: remove references to *_gpl sections
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

*_gpl sections are no longer present in the kernel binary.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 Documentation/kbuild/modules.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index d0703605bfa4..b3a26a36ee17 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -426,11 +426,12 @@ Symbols From the Kernel (vmlinux + modules)
 Version Information Formats
 ---------------------------
 
-	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
-	sections. Symbol names and namespaces are stored in __ksymtab_strings,
-	using a format similar to the string table used for ELF. If
-	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
-	symbols will be added to the __kcrctab or __kcrctab_gpl.
+	Exported symbols have information stored in the __ksymtab and
+	__kflagstab sections. Symbol names and namespaces are stored in
+	__ksymtab_strings section, using a format similar to the string
+	table used for ELF. If CONFIG_MODVERSIONS is enabled, the CRCs
+	corresponding to exported symbols will be added to the
+	__kcrctab section.
 
 	If CONFIG_BASIC_MODVERSIONS is enabled (default with
 	CONFIG_MODVERSIONS), imported symbols will have their symbol name and

-- 
2.53.0.1018.g2bb0e51243-goog

