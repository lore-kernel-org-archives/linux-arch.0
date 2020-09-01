Return-Path: <SRS0=ECFR=CK=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9C2C433E7
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6435621D6C
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 14:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pHFKC5o6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pZw3XDBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgIAOsd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgIALt0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 07:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF156C06125C;
        Tue,  1 Sep 2020 04:48:04 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:47:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxqMQ1TSEqyEQ+IxBxu5S9u4JXQU8ctP1bgVHjyFv1k=;
        b=pHFKC5o6R3n4l494bx3212BoYQSmadU6PdLDwU6dAHfLoiUENWYGBNgVKs6bTRymSpJlQb
        YVTvXcI11Ug/OXYM7RL7rsxTJXGkPwoKVF2mY6RORrinA5cI12+3K0j891DEd7JPe20wAv
        WNnTf6HjtKg29eG6W+xwUy+Hb1DMJ1M6OugGQ1X0NjBJ50EY/JmzttD3I4+3UBs1IIlFRi
        EkT1hsqyFtKpGfTbGezlPVKfFIOxotAlrRz8peSsXgnG8ttF3w80LkyfUD7lXFY54yBe3+
        1bFZdtrzfi14+rZY/6+gb+kfzQb2k00An76WGBkbUMBZObKHSnVJYHtA8RihXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxqMQ1TSEqyEQ+IxBxu5S9u4JXQU8ctP1bgVHjyFv1k=;
        b=pZw3XDBEcWLZrfHzVGeT7UR3O9cpTk17enXsS0xz//gHKalFOdP0QPR3lLbFaTaRb1wRcS
        K3BhpQZQhwnFPlBg==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] vmlinux.lds.h: Add PGO and AutoFDO input sections
Cc:     Jian Cai <jiancai@google.com>, maskray@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch@vger.kernel.org, stable@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-7-keescook@chromium.org>
References: <20200821194310.3089815-7-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087937.20229.4955362311782724603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     eff8728fe69880d3f7983bec3fb6cea4c306261f
Gitweb:        https://git.kernel.org/tip/eff8728fe69880d3f7983bec3fb6cea4c30=
6261f
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Fri, 21 Aug 2020 12:42:47 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:35 +02:00

vmlinux.lds.h: Add PGO and AutoFDO input sections

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

Reported-by: Jian Cai <jiancai@google.com>
Suggested-by: F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Luis Lozano <llozano@google.com>
Tested-by: Manoj Gupta <manojgupta@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=3Dadd=
44f8d5c5c05e08b11e033127a744d61c26aee
Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=3D1de=
778ed23ce7492c523d5850c6c6dbb34152655
Link: https://reviews.llvm.org/D79600
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=3D1084760
Link: https://lore.kernel.org/r/20200821194310.3089815-7-keescook@chromium.org

Debugged-by: Luis Lozano <llozano@google.com>
---
 include/asm-generic/vmlinux.lds.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.=
lds.h
index 98d013d..91dcfb9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -581,7 +581,10 @@
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
