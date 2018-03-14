From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] scripts/checkstack.pl: remove blackfin support
Date: Wed, 14 Mar 2018 17:51:25 +0100
Message-ID: <1521046285-9775-1-git-send-email-tklauser@distanz.ch>
References: <20180314143656.1495602-5-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143656.1495602-5-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The Blackfin port has been removed from the kernel, also remove the
blackfin specific bits from the checkstack.pl script.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---

Patch against the Arnd's asm-generic tree.

 scripts/checkstack.pl | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index eeb9ac8dbcfb..cbdf0dfd4c22 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -98,9 +98,6 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 		#     pair for larger users. -- PFM.
 		#a00048e0:       d4fc40f0        addi.l  r15,-240,r15
 		$re = qr/.*addi\.l.*r15,-(([0-9]{2}|[3-9])[0-9]{2}),r15/o;
-	} elsif ($arch =~ /^blackfin$/) {
-		#   0:   00 e8 38 01     LINK 0x4e0;
-		$re = qr/.*[[:space:]]LINK[[:space:]]*(0x$x{1,8})/o;
 	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
 		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
 		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
-- 
2.13.0
