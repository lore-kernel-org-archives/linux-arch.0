Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36637 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbcFCSkr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2016 14:40:47 -0400
Received: by mail-pa0-f52.google.com with SMTP id te7so13302971pab.3
        for <linux-arch@vger.kernel.org>; Fri, 03 Jun 2016 11:40:46 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/2] expand use of __ro_after_init
Date: Fri,  3 Jun 2016 11:40:22 -0700
Message-ID: <1464979224-2085-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kernel-hardening@lists.openwall.com
Cc: Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mathias Krause <minipli@googlemail.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20160603184022.D-RRbz4aMMP0aL-GxqQro5zFu_0wZ9yH_QjGjWREoQM@z>

After v4.6 released, a number of people complained that Linux's use of
__ro_after_init was extremely limited, but they did not send patches. In
the interest of showing how to make progress in this area, this is a
set of two patches for x86 and arm, extracted from the grsecurity/PaX
patchset in about an hour. I invite others to continue this work, as it
is relatively easy to accomplish.

Since __ro_after_init doesn't yet support modules (assistence here is
welcome too), markings can only be used on variables that are built
in. And since PaX mixes variables that are read-only after init with
those that are protected with pax_open_kernel() and pax_close_kernel(),
it does take a bit of analysis to make sure the variables aren't used
in those cases.

Thanks,

-Kees

