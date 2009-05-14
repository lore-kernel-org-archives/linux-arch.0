From: Roland McGrath <roland@redhat.com>
Subject: [PATCH] feature-removal: arch code lacking CONFIG_HAVE_ARCH_TRACEHOOK
Date: Thu, 14 May 2009 12:13:56 -0700 (PDT)
Message-ID: <20090514191356.30F14FC35D@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45802 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbZENTOV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 May 2009 15:14:21 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org

This documents the intent for generic code to stop catering to old
arch code that has not been updated to the various new interfaces
that are indicated by 'select HAVE_ARCH_TRACEHOOK' in Kconfig.  The
most-used arch's have already converted and some others are starting
to do so.  Help for arch maintainers is available from me and Oleg
if they ask.  (I already submitted 95% of the work for arch/arm,
though it has not gotten any feedback from those arch maintainers.)

The ptrace maintainers and people working on other new features for
user task debugging and tracing need the freedom to reorganize the
generic code and make it depend on the modern set of arch interfaces.
With HAVE_ARCH_TRACEHOOK, such work won't need arch-specific changes.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 Documentation/feature-removal-schedule.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index de491a3..7a52b94 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -437,3 +437,17 @@ Why:	Superseded by tdfxfb. I2C/DDC support used to live in a separate
 	driver but this caused driver conflicts.
 Who:	Jean Delvare <khali@linux-fr.org>
 	Krzysztof Helt <krzysztof.h1@wp.pl>
+
+---------------------------
+
+What:	arch ptrace code not converted to CONFIG_HAVE_ARCH_TRACEHOOK
+When:	2.6.32
+Why:	Crufty old arch code holds up work on generic ptrace code,
+	clean-ups, and new features in the user debugging/tracing area.
+	After the cutoff, generic ptrace code will not try to cater to
+	old arch code, and your arch builds might break if not updated.
+	See arch/Kconfig comments for what code each arch should supply
+	to enable HAVE_ARCH_TRACEHOOK.  Assistance with updating arch
+	code is available for the asking.
+Who:	Roland McGrath <roland@redhat.com>
+	Oleg Nesterov <oleg@redhat.com>
