Return-Path: <SRS0=PuGS=4H=kvack.org=owner-linux-mm@kernel.org>
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 5/6] mm: kmemleak: Wrap section comparison in kmemleak_init with COMPARE_SECTIONS
Date: Tue, 18 Feb 2020 21:54:22 -0700
Message-ID: <20200219045423.54190-6-natechancellor@gmail.com>
In-Reply-To: <20200219045423.54190-1-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200219045422.YmwFswRwMLT3_2W2hZVWnzk9isZsE09kwOrCwqZAsMs@z>

Clang warns:

../mm/kmemleak.c:1950:28: warning: array comparison always evaluates to
a constant [-Wtautological-compare]
        if (__start_ro_after_init < _sdata || __end_ro_after_init > _edat=
a)
                                  ^
../mm/kmemleak.c:1950:60: warning: array comparison always evaluates to
a constant [-Wtautological-compare]
        if (__start_ro_after_init < _sdata || __end_ro_after_init > _edat=
a)
                                                                  ^
2 warnings generated.

These are not true arrays, they are linker defined symbols, which are
just addresses so there is not a real issue here. Use the
COMPARE_SECTIONS macro to silence this warning by casting the linker
defined symbols to unsigned long, which keeps the logic the same.

Link: https://github.com/ClangBuiltLinux/linux/issues/765
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 mm/kmemleak.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index aa6832432d6a..e27655526ba7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1952,7 +1952,8 @@ void __init kmemleak_init(void)
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
 		      KMEMLEAK_GREY, GFP_ATOMIC);
 	/* only register .data..ro_after_init if not within .data */
-	if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
+	if (COMPARE_SECTIONS(__start_ro_after_init, <, _sdata) ||
+	    COMPARE_SECTIONS(__end_ro_after_init, >, _edata))
 		create_object((unsigned long)__start_ro_after_init,
 			      __end_ro_after_init - __start_ro_after_init,
 			      KMEMLEAK_GREY, GFP_ATOMIC);
--=20
2.25.1
