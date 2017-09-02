From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 0/2] locking/refcounts, x86/asm: Use unique .text section for refcount exceptions
Date: Sat,  2 Sep 2017 13:09:44 -0700
Message-ID: <1504382986-49301-1-git-send-email-keescook@chromium.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35529 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbdIBUJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Sep 2017 16:09:53 -0400
Received: by mail-pg0-f49.google.com with SMTP id 63so8991659pgc.2
        for <linux-arch@vger.kernel.org>; Sat, 02 Sep 2017 13:09:52 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Kees Cook <keescook@chromium.org>, Mike Galbraith <efault@gmx.de>, "x86@kernel.org" <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

This splits the earlier patch to have the Kconfig enablement separate,
as requested by Ingo.

Thanks!

-Kees
