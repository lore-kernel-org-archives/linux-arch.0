Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379D3AA1B2
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560105; cv=none; b=ap4Rjt+P6zE9rLSJaf4Jvx19f2Ox3Zk30ojlKcMJ56EHBeI6pTIXnQeKQYI/opn7WOqAJfFx/+6jDC+RmzK03u9WXBjFG+CW8WGRphOddr0oKS2yhZLCjFgFy1W5DzQ8zcv0WDJXU0muZXvOh96FeuU608L5BnrNGjYAPxpLMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560105; c=relaxed/simple;
	bh=lUQ7U8VJ/rlQHorgZU+GXUXjuVr+UBXICgrCGqgyAoo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJgu84h/9bwlpqdhjOlyeRpVkm0DSPtoTvNKRRJbYF2MlTOZfCfrAwz3LsGQqFg5D8nktZ7Mwvnsfi4yVhF9WG9atJSuBgAIhu0VWXONIVrYmr7mofIFehxqd2DVdaZXS680YfQTXFuxKcQ7uZLX+TczJLuUEHEdDSCFOt0TaMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcWPV3pK; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcWPV3pK"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6681cd18f53so1365950a12.3
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560102; x=1775164902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug/Aikg8oXAqlbbl6AzYUeKxZkIdPz7Q+TVSZpI0rDA=;
        b=BcWPV3pKHrJbLeaD1QDi7UMU/yvSXfqpWsAu7yZn64atRtCF1tVLOmrrrA2I9E69B/
         b8YFSAqN4P15VWaUnnEtQ3vGOzWRvyETAllv6Ev1Tn/SD0nuA+CR5aDpmDkJBz1rjIx8
         wIUXPmZBrv0cv2uE9s2GAg1zy75XJQClMN157YuGbPOafWVwQbU/9dB84oOIL7QJJ0a/
         EvSQeZncQBHhzHH2MNiAXh8OakhA3ZIy1/8RF4hDNt3RFkgLNwn1IQ1GE2d6l+yu2M4w
         ZNolgTFiEW7txEUjp6XJjZiefJ/5c0nt63eciR1nRKgpvPoLoBjzAbEweHIlpjdH4UWQ
         zpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560102; x=1775164902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug/Aikg8oXAqlbbl6AzYUeKxZkIdPz7Q+TVSZpI0rDA=;
        b=SC+OrJ1WUfVBI/gpEmcfoDyTciPPTsZI3QaNSXYuyneGVd4g20CoX3tjVuoBWfbk18
         wXXST0CKNhNLUwCHf/wyY8+BCR8riaepdYCvP6rgCuE/aBxicXlFdWwtEm4NouBeLaSN
         MpkqMLarN4eCoFKN+khLB6YkMPOd6kUGz8e+tYexRoOE6kACB/SwzmfXyN2K4BXjoOJl
         t3k1waqekX857azsJg/CGkZYkj2u4p5jmgNlS58aHvv6Ujy55UyYw4XzbcBtxRUbBmF8
         6A3gLS47KlltlkChP3O0Q/0QHT16cOqBu7Rf7qyMt9VqmMUD5nxkXHignCjoGXv/4EhM
         l/zw==
X-Forwarded-Encrypted: i=1; AJvYcCXZKTRKMaIdHyjKfhoZwOwSf8TwasvgXoqXjyFIo3+hH/zzNLXKmgOhrSGqdswHEe6zjve3usC+wS63@vger.kernel.org
X-Gm-Message-State: AOJu0YzycVc+Av7Hi0KWl82iS6iPe46bW07INgrWkp0hoV6gGSKEIEkr
	uTz918qcQcFlz689HJb6FPYzHIR1c1rX348BoZfMneSFPd1IE7C3fuND42crG6/bj5MZUdPoO9g
	cLWp2Zl5T16guyVRnDQ==
X-Received: from edr23.prod.google.com ([2002:a05:6402:44d7:b0:665:108f:6bfb])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:27cb:b0:668:502d:80b6 with SMTP id 4fb4d7f45d1cf-66a826e1ceemr5762559a12.26.1774560101441;
 Thu, 26 Mar 2026 14:21:41 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:21:35 +0000
In-Reply-To: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-7-455cd723dddf@google.com>
Subject: [PATCH v5 7/7] documentation: remove references to *_gpl sections
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, gprocida@google.com
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

