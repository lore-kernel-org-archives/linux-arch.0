From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v2] arch: m68k: math-emu: unsigned issue, 'unsigned long'
 will never be less than zero
Date: Thu, 30 May 2013 16:21:36 +0800
Message-ID: <51A70C10.6000408@asianux.com>
References: <51A6F0C6.9050806@asianux.com> <m2a9ndndu5.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <m2a9ndndu5.fsf@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


'oldmant.m32[1]' is 'unsigned long' which never '< 0', and the original
author wanted to check the highest bit whether set.

So need make the bit test explicit (which is better than type cast form
'unsigned long' to 'long').

The related warning: (with EXTRA_CFLAGS=-W ARCH=m68k for allmodconfig)
  arch/m68k/math-emu/fp_arith.c:522:4: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]



Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m68k/math-emu/fp_arith.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/m68k/math-emu/fp_arith.c b/arch/m68k/math-emu/fp_arith.c
index 08f286d..239eb19 100644
--- a/arch/m68k/math-emu/fp_arith.c
+++ b/arch/m68k/math-emu/fp_arith.c
@@ -519,7 +519,7 @@ static void fp_roundint(struct fp_ext *dest, int mode)
 				return;
 			break;
 		case 0x401e:
-			if (!(oldmant.m32[1] >= 0))
+			if (oldmant.m32[1] & 0x80000000)
 				return;
 			if (oldmant.m32[0] & 1)
 				break;
-- 
1.7.7.6
