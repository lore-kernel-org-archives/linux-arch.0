Return-Path: <SRS0=PuGS=4H=kvack.org=owner-linux-mm@kernel.org>
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 2/6] kernel/extable: Wrap section comparison in sort_main_extable with COMPARE_SECTIONS
Date: Tue, 18 Feb 2020 21:54:19 -0700
Message-ID: <20200219045423.54190-3-natechancellor@gmail.com>
In-Reply-To: <20200219045423.54190-1-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200219045419.PP4452DeROJfsO58UIKzOBNjVZ3KyfdLhD9QWQ6hDqg@z>

Clang warns:

../kernel/extable.c:37:52: warning: array comparison always evaluates to
a constant [-Wtautological-compare]
        if (main_extable_sort_needed && __stop___ex_table > __start___ex_=
table) {
                                                          ^
1 warning generated.

These are not true arrays, they are linker defined symbols, which are
just addresses so there is not a real issue here. Use the
COMPARE_SECTIONS macro to silence this warning by casting the linker
defined symbols to unsigned long, which keeps the logic the same.

Link: https://github.com/ClangBuiltLinux/linux/issues/765
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 kernel/extable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/extable.c b/kernel/extable.c
index a0024f27d3a1..17bf4ccb9de9 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -34,7 +34,8 @@ u32 __initdata __visible main_extable_sort_needed =3D 1=
;
 /* Sort the kernel's built-in exception table */
 void __init sort_main_extable(void)
 {
-	if (main_extable_sort_needed && __stop___ex_table > __start___ex_table)=
 {
+	if (main_extable_sort_needed &&
+	    COMPARE_SECTIONS(__stop___ex_table, >, __start___ex_table)) {
 		pr_notice("Sorting __ex_table...\n");
 		sort_extable(__start___ex_table, __stop___ex_table);
 	}
--=20
2.25.1
