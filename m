Return-Path: <3weAvXg4KBDoXnajZWjdeccejockkcha.Ykinllphejqt.eXi.Yki@flex--brendanhiggins.bounces.google.com>
Date: Mon, 27 Jan 2020 23:20:02 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-ID: <20200128072002.79250-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
Subject: [PATCH v1 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
From: Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200128072002.pI4EBrJ1Ci_HZIaNlSXBUx4uGt0iBQz5UUGq1Ux95Lk@z>

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e03..0472b02ce16bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2054,6 +2054,13 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running tests.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests.
+			halt:		halt the kernel after running tests.
+			reboot:		reboot the kernel after running tests.
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.25.0.341.g760bfbb309-goog
