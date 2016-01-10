Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757935AbcAJOVj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Jan 2016 09:21:39 -0500
Date: Sun, 10 Jan 2016 16:21:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 36/41] checkpatch: add virt barriers
Message-ID: <1452426622-4471-37-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Andy Whitcroft <apw@canonical.com>
Message-ID: <20160110142131.2qhBaKWHP-s_--hFjuLoJNgNpWSKVvC_9d8VE8PR-jg@z>

Add virt_ barriers to list of barriers to check for
presence of a comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a96adcb..5ca272b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5131,7 +5131,8 @@ sub process {
 		}x;
 		my $all_barriers = qr{
 			$barriers|
-			smp_($smp_barriers)
+			smp_($smp_barriers)|
+			virt_($smp_barriers)
 		}x;
 
 		if ($line =~ /\b($all_barriers)\s*\(/) {
-- 
MST

