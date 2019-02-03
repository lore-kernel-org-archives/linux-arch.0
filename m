From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] Rename include/{uapi => }/asm-generic/shmparam.h really
Date: Sun,  3 Feb 2019 10:44:37 +0900
Message-ID: <1549158277-24558-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Commit 36c0f7f0f899 ("arch: unexport asm/shmparam.h for all
architectures") is different from the patch I submitted.

My patch is this:
https://lore.kernel.org/lkml/1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com/T/#u

The file renaming part:

  rename include/{uapi => }/asm-generic/shmparam.h (100%)

was lost when it was picked up.

I think it was an accident because Andrew did not say anything.

Fixes: 36c0f7f0f899 ("arch: unexport asm/shmparam.h for all architectures")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

 include/{uapi => }/asm-generic/shmparam.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename include/{uapi => }/asm-generic/shmparam.h (100%)

diff --git a/include/uapi/asm-generic/shmparam.h b/include/asm-generic/shmparam.h
similarity index 100%
rename from include/uapi/asm-generic/shmparam.h
rename to include/asm-generic/shmparam.h
-- 
2.7.4
