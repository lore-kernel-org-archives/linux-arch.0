Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B93DBD61
	for <linux-arch@vger.kernel.org>; Thu,  5 Mar 2026 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729673; cv=none; b=LVxP5UD02Gkqm9XQZObEv0UJNyYf22csks2zCfyYOWlZIliKcBvtK3afOLFbZ5QsEcKvDXPcVtruTXxz/btOc4OSB8sCoGxGfBpkOYWi7LtGPLYgtEDPGkCWy3HNtVAfvcy3pYVqMzVWjtrdD5I0qJTQ1655iKOr11EvRD3Vzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729673; c=relaxed/simple;
	bh=P86ac5my1fDlI8n2GQxcGL87lpW9m2344uJNQZ3J/J4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UjJDW/741/poM+lySbQQ5eJdn+7Hs7sdSXbIPhnZbCmPFkQByUZUUb/U7plyXZ4sYdsr6XPXEjNAvgmR1JQuPVU7NMbPB+xljs8b5tMqkOq7Tt31UnfAuCHf7GZCCdXnbnGVBVbSfzV1tIVDDSMhT6WSVL97Antlg5aV/lszaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIC9YsA/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIC9YsA/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836abfc742so66197265e9.0
        for <linux-arch@vger.kernel.org>; Thu, 05 Mar 2026 08:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729670; x=1773334470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbFvhwKwxof5OBDT/AFQVHeuEBUcV4eoWuedVaHu8Hg=;
        b=CIC9YsA/S7B74m6EcNsCBGM+3FTucRXi0kJgFe58qZaaPk6P6OpTVNGuLwuwuO7PLY
         LWtEfrCHamzxiYXBm1Ofpz/KBeQqi+uBNNI+PreXdCLVJvG2+LDyokB1l7a4SRH/hbuZ
         LAG/1Qnd34hDOye8VTsP7ZrlNmcpC1aZhcN330xTTrxkX2t4TZypQb67PBGGBYx6ae0y
         hgGAj4PyulvCiISCq7/+MqE8z4cbT4C5/pZxcoQ7O5eOOEcg1Pr7OlzhGVhkjWKyOu3U
         KT5Zj0kzFm2jEf2u/I33zgCYBkUbZHSyUgEX+bq8PTK1iGm8dqmFDe4N++0F/zPz/2Pk
         6lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729670; x=1773334470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbFvhwKwxof5OBDT/AFQVHeuEBUcV4eoWuedVaHu8Hg=;
        b=oB7prjRevI8bjp3cIxLAPEBrFbHSrA90lVymzt8Y0Wl7D7CB8mn3grB1/EG2SUMGZr
         zNfmnoYpO463Gbi9W5UQlZnz03hgJ4QJz+L4TbGfiHxd9BM+LKyKTqDYP98JMMSauTvm
         q3HwQTHUA4c2FTNT9ESwPYe1UgcmYF89ejiz9EGJdneTKHiZ8Z7tTWJbiDEEwnsuztDG
         wxNmI8awQAyNNknMU362vDmXNFJPjkkeFEZtbBNpg1q+KcOV2+6wiJ96n2ujYPd6WbYi
         vNBneO6OPxgXI4kTckR4gcZ0NwGNgaqTvpdyEQhEYs2dchb9RTBFHF73Z3Vibxc5HBpU
         aY+g==
X-Forwarded-Encrypted: i=1; AJvYcCUFF2SVC7sIMF8iepORtKrehPzTlGoj/uiKQSTnshPmfzEjoK5pAAQpsf8IVZZEvNeHVD1Pdy716Ans@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJO8zxlQGj6m0rqZZnzNiL+84WvN93eUnIedzf8Of87QCL8Ie
	Oeikuvm/3Pr025be5hTAunXF1W+ephttaRy+wc2oIzMm8SELGYX8UwYYEbF6jmKmva6NgkyAVjk
	sCwhb3HqUnVXUEYX5SA==
X-Received: from wmap19.prod.google.com ([2002:a7b:cc93:0:b0:483:26c3:383e])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d6:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-485197d662amr130569275e9.0.1772729670078;
 Thu, 05 Mar 2026 08:54:30 -0800 (PST)
Date: Thu, 05 Mar 2026 16:54:22 +0000
In-Reply-To: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-2-4fe6eea27e30@google.com>
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

