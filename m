Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426739F182
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560325; cv=none; b=tOMCzllcYXumm92W2iT1FHgLMIThywus2BSpHKJPj1s8tMBeTGr5RwBsY3bDU6KubNcKoP6j8xYeEbJow39QleNc4YUJdn6NJGP8NBo4vyQ4q4oV7NEuk3G2mYATaJfJHAN0hygG6Vz9SCrZ4NK61rRNURxu46/c2/bsetm/ar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560325; c=relaxed/simple;
	bh=bNpRj84rrM86rZbfxqGsulk194sj2YCQCbqiinFXn0k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h9MVzG6phpoW1awMXZmNi0/JudCZkmF3N0npTwQMztoQqUy35lC8SjUU/7Y7CHXpbUu/7/usSrmnAijlMN+fNOIbyYoVTtvcqpHd775ZXJRNw9NCw6nOWRve/bI9lool7LkI6cyIIXSViMB7bqJgPVy5v7/kVmsiuQcwbJl0ewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKK0jXyc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKK0jXyc"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-486fb29a8b8so10531725e9.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560323; x=1775165123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JDEAfTveFPPp/Cvp9vb5cLHHVQOeJ1kP6lbtNESx5U=;
        b=wKK0jXyct+ItBsz/XN7udywpCHS31fm8bzVGnrjSlIbapLhBuU58E6rDYUIw2pT3hK
         O0i0q9Mrvw4JSf4HzZNFofVT02NNhmXUpE0ou2+LkhwRMnFD5UV4qJHsS7dgY39gyboh
         59L3KVe8qPBLWroVkxidQXAEy7Ue4N7v29hoG46Og1FYu6wUvkZTgYupAH43LVPMVKvr
         C/Z2v90f224QBibRiCwrR3JnrROcZQe6EJTIITwTW8TkfUjF6xwNT3Q/UUDDiY4Oib04
         R4+/r2X6pWTQKbezqcZ9eByOJZp/0pz6+9xN3vBFyYGQe5TKE/EMu+P8cxR8RN4MXA8P
         gSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560323; x=1775165123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JDEAfTveFPPp/Cvp9vb5cLHHVQOeJ1kP6lbtNESx5U=;
        b=Dgwlio4woXKD4GoaKBMzTK6wMNru2kLCgJyfKX3ebuvfQMIOkLwAbhAhqDlotvqaGy
         Ss85zMilnhuL5HidiGANYrys8a1lLvCPTb7cVhTzGs0Fs4g8Bnn5Cr0tb8D+1rELq389
         HSV1JfB2jyQlWfp+oSj0XNcIkfZn4kgjcB2FFFrvZ+Y1acoehVNRXOlZPqUav46lajN/
         ILtQX7jGj9uE/R5VjkALr+3xnreLRvBbEMkeO7H1XU49odqxZmaxfC7TloQQsXraNqWb
         BlF0xJFMnu8NXI9a32smuXxMCd4CNnTeRSomHgkBZ79ZJ7JOJHjDTDSlN4gYhcl4Ch1J
         mzig==
X-Forwarded-Encrypted: i=1; AJvYcCX8LORZBVLhCnHnw6lXmHamkWgqs9QYzk/TnV8MW8fl7Wk0lQhBNMS2TUEVF1oJmVQyWGzIOw/jevyf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2IF92PFdiKG714peT7ToXozhFXlRGNmKLbdZ7e1+cLJR1IQE3
	Zo8wVTwi9LaOv+7wHQBK7SJcgWuEPKjMD9cbX4pJ89g4jVOWQrMKOSd7XaiyHMTl1hL3VdmIXSq
	FFfVyQfZc1F6fBwYLbw==
X-Received: from wmlz25.prod.google.com ([2002:a05:600c:2219:b0:485:3b8d:c995])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c113:b0:487:1114:d431 with SMTP id 5b1f17b1804b1-48727ec3c36mr2557315e9.18.1774560322529;
 Thu, 26 Mar 2026 14:25:22 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:25:01 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC2kxWkC/23MQQ7CIBRF0a00fywGKVDiyH2YDoB+KLEWAw3RN
 Oxd7NjhfXk5O2RMATNcux0SlpBDXFuIUwd21qtHEqbWwCiTtKeCPNyifd60IeKiqUKHE+Mc2v+ V0IX3Yd3H1nPIW0yfgy78t/5TCieUSD1I45RRvR1uPka/4NnGJ4y11i/v+hXqowAAAA==
X-Change-Id: 20260305-kflagstab-51a08efed244
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
Subject: [PATCH v5 0/7] scalable symbol flags with __kflagstab
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

This patch series implements a mechanism for scalable exported symbol
flags using a separate section called __kflagstab. The series introduces
__kflagstab support, removes *_gpl sections in favor of a GPL flag,
simplifies symbol resolution during module loading.

The __kflagstab contains an 8-bit bitset which can represent up to 8
boolean flags per symbol exported in the __ksymtab. The patch series
also uses this bitset to store GPL-only flag values for kernel symbols,
thereby eliminating the need for *_gpl sections for representing GPL
only symbols.

Petr Pavlu ran a small test to get a better understanding of the
different section sizes resulting from this patch series.  He used
v6.17-rc6 together with the openSUSE x86_64 config [1], which is fairly
large. The resulting vmlinux.bin (no debuginfo) had an on-disk size of
58 MiB, and included 5937 + 6589 (GPL-only) exported symbols.

The following table summarizes his measurements and calculations
regarding the sizes of all sections related to exported symbols:

                      |  HAVE_ARCH_PREL32_RELOCATIONS  | !HAVE_ARCH_PREL32_RELOCATIONS
 Section              | Base [B] | Ext. [B] | Sep. [B] | Base [B] | Ext. [B] | Sep. [B]
----------------------------------------------------------------------------------------
 __ksymtab            |    71244 |   200416 |   150312 |   142488 |   400832 |   300624
 __ksymtab_gpl        |    79068 |       NA |       NA |   158136 |       NA |       NA
 __kcrctab            |    23748 |    50104 |    50104 |    23748 |    50104 |    50104
 __kcrctab_gpl        |    26356 |       NA |       NA |    26356 |       NA |       NA
 __ksymtab_strings    |   253628 |   253628 |   253628 |   253628 |   253628 |   253628
 __kflagstab          |       NA |       NA |    12526 |       NA |       NA |    12526
----------------------------------------------------------------------------------------
 Total                |   454044 |   504148 |   466570 |   604356 |   704564 |   616882
 Increase to base [%] |       NA |     11.0 |      2.8 |       NA |     16.6 |      2.1

The column "HAVE_ARCH_PREL32_RELOCATIONS -> Base" contains themeasured
numbers. The rest of the values are calculated. The "Ext." column
represents an alternative approach of extending __ksymtab to include a
bitset of symbol flags, and the "Sep." column represents the approach of
having a separate __kflagstab. With HAVE_ARCH_PREL32_RELOCATIONS, each
kernel_symbol is 12 B in size and is extended to 16 B. With
!HAVE_ARCH_PREL32_RELOCATIONS, it is 24 B, extended to 32 B. Note that
this does not include the metadata needed to relocate __ksymtab*, which
is freed after the initial processing.

The base export data in this case totals 0.43 MiB. About 50% is used for
storing the names of exported symbols.

Adding __kflagstab as a separate section has a negligible impact, as
expected. When extending __ksymtab (kernel_symbol) instead, the worst
case with !HAVE_ARCH_PREL32_RELOCATIONS increases the export data size
by 16.6%. Note that the larger increase in size for the latter approach
is due to 4-byte alignment of kernel_symbol data structure, instead of
1-byte alignment for the flags bitset in __kflagstab in the former
approach.

Based on the above, it was concluded that introducing __kflagstab makes
senses, as the added complexity is minimal over extending kernel_symbol,
and there is overall simplification of symbol finding logic in the
module loader.

Thank you Petr Pavlu for doing a section size analysis as well as Sami
Tolvanen, Petr Pavlu and Jonathan Corbet for their valuable feedback.

---
Changes from v4:
- squashed patches #4 and #5 to fix a bisecting issue

v4:
https://lore.kernel.org/r/20260305-kflagstab-v4-0-6a76bf8b83c7@google.com

Changes from v3:
- made commit messages more descriptive

v3:
https://lore.kernel.org/20251103161954.1351784-1-sidnayyar@google.com/

Changes from v2:
- dropped symbol import protection to spin off into its own series

v2:
https://lore.kernel.org/20251013153918.2206045-1-sidnayyar@google.com/

Changes from v1:
- added a check to ensure __kflagstab is present
- added warnings for the obsolete *_gpl sections
- moved protected symbol check before ref_module() call
- moved protected symbol check failure warning to issue detection point

v1:
https://lore.kernel.org/20250829105418.3053274-1-sidnayyar@google.com/

[1] https://github.com/openSUSE/kernel-source/blob/307f149d9100a0e229eb94cbb997ae61187995c3/config/x86_64/default

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

---
Siddharth Nayyar (7):
      module: define ksym_flags enumeration to represent kernel symbol flags
      module: add kflagstab section to vmlinux and modules
      module: populate kflagstab in modpost
      module: use kflagstab instead of *_gpl sections
      module: deprecate usage of *_gpl sections in module loader
      module: remove *_gpl sections from vmlinux and modules
      documentation: remove references to *_gpl sections

 Documentation/kbuild/modules.rst  |  11 +++--
 include/asm-generic/vmlinux.lds.h |  21 +++-----
 include/linux/export-internal.h   |  28 +++++++----
 include/linux/module.h            |   4 +-
 include/linux/module_symbol.h     |   5 ++
 kernel/module/internal.h          |   4 +-
 kernel/module/main.c              | 101 ++++++++++++++++++--------------------
 scripts/mod/modpost.c             |  16 ++++--
 scripts/module.lds.S              |   3 +-
 9 files changed, 98 insertions(+), 95 deletions(-)
---
base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
change-id: 20260305-kflagstab-51a08efed244

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

