Return-Path: <SRS0=eK+U=AG=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390895AbgFYSst (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 14:48:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79898C08C5DC
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 11:48:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r19so4549033qvz.7
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 11:48:49 -0700 (PDT)
Date: Thu, 25 Jun 2020 11:47:52 -0700
In-Reply-To: <20200622231536.7jcshis5mdn3vr54@google.com>
Message-ID: <20200625184752.73095-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200622231536.7jcshis5mdn3vr54@google.com>
Subject: [PATCH v2] vmlinux.lds: add PGO and AutoFDO input sections
From: Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?q?F=C4=81ng-ru=C3=AC=20S=C3=B2ng?= <maskray@google.com>, Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org, Jian Cai <jiancai@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Message-ID: <20200625184752.2J65czy1yjEuF8AZgc5LYZ3dwjOjqWC3Rwh6vra0XmU@z>

Basically, consider .text.{hot|unlikely|unknown}.* part of .text, too.

When compiling with profiling information (collected via PGO
instrumentations or AutoFDO sampling), Clang will separate code into
.text.hot, .text.unlikely, or .text.unknown sections based on profiling
information. After D79600 (clang-11), these sections will have a
trailing `.` suffix, ie.  .text.hot., .text.unlikely., .text.unknown..

When using -ffunction-sections together with profiling infomation,
either explicitly (FGKASLR) or implicitly (LTO), code may be placed in
sections following the convention:
.text.hot.<foo>, .text.unlikely.<bar>, .text.unknown.<baz>
where <foo>, <bar>, and <baz> are functions.  (This produces one section
per function; we generally try to merge these all back via linker script
so that we don't have 50k sections).

For the above cases, we need to teach our linker scripts that such
sections might exist and that we'd explicitly like them grouped
together, otherwise we can wind up with code outside of the
_stext/_etext boundaries that might not be mapped properly for some
architectures, resulting in boot failures.

If the linker script is not told about possible input sections, then
where the section is placed as output is a heuristic-laiden mess that's
non-portable between linkers (ie. BFD and LLD), and has resulted in many
hard to debug bugs.  Kees Cook is working on cleaning this up by adding
--orphan-handling=3Dwarn linker flag used in ARCH=3Dpowerpc to additional
architectures. In the case of linker scripts, borrowing from the Zen of
Python: explicit is better than implicit.

Also, ld.bfd's internal linker script considers .text.hot AND
.text.hot.* to be part of .text, as well as .text.unlikely and
.text.unlikely.*. I didn't see support for .text.unknown.*, and didn't
see Clang producing such code in our kernel builds, but I see code in
LLVM that can produce such section names if profiling information is
missing. That may point to a larger issue with generating or collecting
profiles, but I would much rather be safe and explicit than have to
debug yet another issue related to orphan section placement.

Cc: stable@vger.kernel.org
Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=3Da=
dd44f8d5c5c05e08b11e033127a744d61c26aee
Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=3D1=
de778ed23ce7492c523d5850c6c6dbb34152655
Link: https://reviews.llvm.org/D79600
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=3D1084760
Reported-by: Jian Cai <jiancai@google.com>
Debugged-by: Luis Lozano <llozano@google.com>
Suggested-by: F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google.com>
Tested-by: Luis Lozano <llozano@google.com>
Tested-by: Manoj Gupta <manojgupta@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* Add .text.unknown.*.  It's not strictly necessary for us yet, but I
  really worry that it could become a problem for us. Either way, I'm
  happy to drop for a V3, but I'm suggesting we not.
* Beef up commit message.
* Drop references to LLD; the LLVM change had nothing to do with LLD.
  I've realized I have a Pavlovian-response to changes from F=C4=81ng-ru=C3=
=AC
  that I associate with LLD.  I'm seeking professional help for my
  ailment. Forgive me.
* Add link to now public CrOS bug.

 include/asm-generic/vmlinux.lds.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index d7c7c7f36c4a..245c1af4c057 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -560,7 +560,10 @@
  */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
+		*(.text.hot .text.hot.*)				\
+		*(TEXT_MAIN .text.fixup)				\
+		*(.text.unlikely .text.unlikely.*)			\
+		*(.text.unknown .text.unknown.*)			\
 		NOINSTR_TEXT						\
 		*(.text..refcount)					\
 		*(.ref.text)						\
--=20
2.27.0.111.gc72c7da667-goog
