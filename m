From: Clement Courbet <courbet@google.com>
Subject: [PATCH v2] lib: optimize cpumask_next_and()
Date: Thu, 26 Oct 2017 17:52:01 +0200
Message-ID: <20171026155201.26104-1-courbet@google.com>
References: <CACVxJT9+2wV34iYsQVCeqDi1HnUyJQTc-4Pf2ihW18R0rAmxSA@mail.gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:54824 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932446AbdJZPwf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2017 11:52:35 -0400
Received: by mail-wm0-f43.google.com with SMTP id r68so9265118wmr.3
        for <linux-arch@vger.kernel.org>; Thu, 26 Oct 2017 08:52:35 -0700 (PDT)
In-Reply-To: <CACVxJT9+2wV34iYsQVCeqDi1HnUyJQTc-4Pf2ihW18R0rAmxSA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>, Yury Norov <ynorov@caviumnetworks.com>
Cc: Clement Courbet <courbet@google.com>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Alexey,

> Gentoo ships 5.4.0 which doesn't inline this code on x86_64 defconfig
> (which has OPTIMIZE_INLINING).

I have not actually marked _find_next_bit() inline, it just turns out
that my compiler inlines it.
I've tried out marking the function inline and OPTIMIZE_INLINING does
not un-inline it. I'll send a v4 with an explicit inine.
