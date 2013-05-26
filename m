From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: alpha: kernel: sprintf(), the minimal buffer length
 is 20 for "0xffffffffffffffff\n"
Date: Sun, 26 May 2013 18:09:07 +0800
Message-ID: <51A1DF43.5090503@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc: linux-alpha@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


For 'opcode_str' in sprintf(), the maximize length of format "0x%llx\n"
is 20 ("0xffffffffffffffff\n"), so need define 'opcode_str' at least 20
length.

Or the big number comes, it will cause issue.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/alpha/kernel/err_marvel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/alpha/kernel/err_marvel.c b/arch/alpha/kernel/err_marvel.c
index ae54ad9..2310082 100644
--- a/arch/alpha/kernel/err_marvel.c
+++ b/arch/alpha/kernel/err_marvel.c
@@ -275,7 +275,7 @@ marvel_print_po7_uncrr_sym(u64 uncrr_sym, u64 valid_mask)
 static void
 marvel_print_po7_ugbge_sym(u64 ugbge_sym)
 {
-	char opcode_str[10];
+	char opcode_str[20];
 
 #define IO7__PO7_UGBGE_SYM__UPH_PKT_OFF__S	(6)
 #define IO7__PO7_UGBGE_SYM__UPH_PKT_OFF__M	(0xfffffffful)
-- 
1.7.7.6
