Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55618 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239Ab3AJPch (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Jan 2013 10:32:37 -0500
From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v3 04/44] Add HAVE_64BIT_ALIGNED_ACCESS
Date: Thu, 10 Jan 2013 15:30:32 +0000
Message-ID: <1357831872-29451-5-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Eric Paris <eparis@redhat.com>, Will Drewry <wad@chromium.org>
Message-ID: <20130110153032.6Gy0qNWn6VcWwqPuYM02LgRNHNYBP3bcQU2MKfGmt8I@z>

On 64 bit architectures with no efficient unaligned access, padding and
explicit alignment must be added in various places to prevent unaligned
64bit accesses (such as taskstats and trace ring buffer).

However this also needs to apply to 32 bit architectures with 64 bit
accesses requiring alignment such as metag.

This is solved by adding a new Kconfig symbol HAVE_64BIT_ALIGNED_ACCESS
which defaults to 64BIT && !HAVE_EFFICIENT_UNALIGNED_ACCESS, and can be
explicitly selected by METAG and any other relevant architectures. This
can be used in various places to determine whether 64bit alignment is
required.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Paris <eparis@redhat.com>
Cc: Will Drewry <wad@chromium.org>
---
 arch/Kconfig |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 956756c..13f28be 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -94,6 +94,22 @@ config UPROBES
 
 	  If in doubt, say "N".
 
+config HAVE_64BIT_ALIGNED_ACCESS
+	def_bool 64BIT && !HAVE_EFFICIENT_UNALIGNED_ACCESS
+	help
+	  Some architectures require 64 bit accesses to be 64 bit
+	  aligned, which also requires structs containing 64 bit values
+	  to be 64 bit aligned too. This includes some 32 bit
+	  architectures which can do 64 bit accesses, as well as 64 bit
+	  architectures without unaligned access.
+
+	  This symbol should be selected by an architecture if 64 bit
+	  accesses are required to be 64 bit aligned in this way even
+	  though it is not a 64 bit architecture.
+
+	  See Documentation/unaligned-memory-access.txt for more
+	  information on the topic of unaligned memory accesses.
+
 config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	bool
 	help
-- 
1.7.7.6


