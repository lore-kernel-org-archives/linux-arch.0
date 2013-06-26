Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:54926 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3FZE7W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 00:59:22 -0400
Message-ID: <51CA66FD.1010708@asianux.com>
Date: Wed, 26 Jun 2013 11:58:53 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
Subject: [PATCH] arch: m32r: kernel: use 'COPY_UNALIGNED_HWORD' instead of
 'COPY_UNALIGNED_WORD'
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "dhowells@redhat.com" <dhowells@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20130626035853.8UJBvo1c0dKKa6onsBDW4jasRiu8XR8kG5yI56XQAo0@z>

For 'hvalue' and 'hlocation', need use 'COPY_UNALIGNED_HWORD' instead

The related warnings (with allmodconfig)
    CC      arch/m32r/kernel/module.o
  arch/m32r/kernel/module.c: In function ‘apply_relocate_add’:
  arch/m32r/kernel/module.c:127:8: warning: ‘*((void *)&hvalue+2)’ is used uninitialized in this function [-Wuninitialized]
  arch/m32r/kernel/module.c:127:8: warning: ‘*((void *)&hvalue+2)’ is used uninitialized in this function [-Wuninitialized]
  arch/m32r/kernel/module.c:127:8: warning: ‘*((void *)&hvalue+3)’ is used uninitialized in this function [-Wuninitialized]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m32r/kernel/module.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/m32r/kernel/module.c b/arch/m32r/kernel/module.c
index 38233b6..bcad14c 100644
--- a/arch/m32r/kernel/module.c
+++ b/arch/m32r/kernel/module.c
@@ -124,7 +124,7 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
                         relocation = relocation & 0xffff;
 			/* RELA must has 0 at relocation field. */
 			hvalue = relocation;
-	    		COPY_UNALIGNED_WORD (hvalue, *hlocation, align);
+			COPY_UNALIGNED_HWORD(hvalue, *hlocation, align);
 			break;
 		case R_M32R_SDA16_RELA:
 		case R_M32R_LO16_RELA:
-- 
1.7.7.6
