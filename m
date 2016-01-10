Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757349AbcAJTbK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Jan 2016 14:31:10 -0500
Date: Sun, 10 Jan 2016 21:31:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 3/3] checkpatch: add virt barriers
Message-ID: <1452454200-8844-4-git-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452454200-8844-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20160110193100.1vTYEBNJiuAxa6GZS_e5CNRRakHjF5jNivVOFk6tOxA@z>

Add virt_ barriers to list of barriers to check for
presence of a comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 15cfca4..4466579 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5133,7 +5133,8 @@ sub process {
 		}x;
 		my $all_barriers = qr{
 			$barriers|
-			smp_(?:$smp_barrier_stems)
+			smp_(?:$smp_barrier_stems)|
+			virt_(?:$smp_barrier_stems)
 		}x;
 
 		if ($line =~ /\b(?:$all_barriers)\s*\(/) {
-- 
MST

