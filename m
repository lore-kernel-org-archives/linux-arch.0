Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39363 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeBWKmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Feb 2018 05:42:42 -0500
Received: by mail-wr0-f194.google.com with SMTP id w77so13575398wrc.6
        for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2018 02:42:42 -0800 (PST)
From: Jack Wang <jinpu.wang@profitbricks.com>
Subject: [stable 4.4 18/29] x86/spectre: Report get_user mitigation for spectre_v1
Date: Fri, 23 Feb 2018 11:42:07 +0100
Message-ID: <1519382538-15143-19-git-send-email-jinpu.wangl@profitbricks.com>
In-Reply-To: <1519382538-15143-1-git-send-email-jinpu.wangl@profitbricks.com>
References: <1519382538-15143-1-git-send-email-jinpu.wangl@profitbricks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com, torvalds@linux-foundation.org, alan@linux.intel.com, David Woodhouse <dwmw@amazon.co.uk>, Jack Wang <jinpu.wang@profitbricks.com>
Message-ID: <20180223104207.6iYz2nFjQl6FE-gF1zJnjDVzxQTOHlI4bSWEzN_6rw4@z>

From: Dan Williams <dan.j.williams@intel.com>

(cherry picked from commit edfbae53dab8348fca778531be9f4855d2ca0360)

Reflect the presence of get_user(), __get_user(), and 'syscall' protections
in sysfs. The expectation is that new and better tooling will allow the
kernel to grow more usages of array_index_nospec(), for now, only claim
mitigation for __user pointer de-references.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727420158.33451.11658324346540434635.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d3b8337..812813e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -291,7 +291,7 @@ ssize_t cpu_show_spectre_v1(struct device *dev,
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Vulnerable\n");
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev,
-- 
2.7.4
