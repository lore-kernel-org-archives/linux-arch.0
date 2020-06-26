Return-Path: <SRS0=gWHa=AH=vger.kernel.org=linux-doc-owner@kernel.org>
Date: Fri, 26 Jun 2020 14:09:08 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-ID: <20200626210917.358969-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
Subject: [PATCH v5 03/12] arch: microblaze: add linker section for KUnit test suites
From: Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-doc-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org, Brendan Higgins <brendanhiggins@google.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200626210908.ZTN4KM9YQEt9d2F8OgFgPjw980K4ctMqHXxy3MXC_t0@z>

Add a linker section to microblaze where KUnit can put references to its
test suites. This patch is an early step in transitioning to dispatching
all KUnit tests from a centralized executor rather than having each as
its own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/microblaze/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d06cd6b..4fc32f8979a60 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -128,6 +128,10 @@ SECTIONS {
 
 	__init_end = .;
 
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
+
 	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
 		/* page aligned when MMU used */
 		__bss_start = . ;
-- 
2.27.0.212.ge8ba1cc988-goog
