Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:45402 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbdJYP2z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2017 11:28:55 -0400
Received: by mail-wm0-f46.google.com with SMTP id q124so2666892wmb.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Oct 2017 08:28:54 -0700 (PDT)
From: Clement Courbet <courbet@google.com>
Subject: Re [PATCH v2] lib: optimize cpumask_next_and()
Date: Wed, 25 Oct 2017 17:28:41 +0200
Message-ID: <20171025152841.6746-1-courbet@google.com>
In-Reply-To: <20171025145938.wpr7spsujounqudk@yury-thinkpad>
References: <20171025145938.wpr7spsujounqudk@yury-thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>, Yury Norov <ynorov@caviumnetworks.com>
Cc: Clement Courbet <courbet@google.com>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20171025152841.lx-N8YDF58hSYhOBTqIccojxs6STU5k0XHl9BoVc7vA@z>

Thanks for the comments Yury.

> But I'd like also to keep _find_next_bit() consistent with
> _find_next_bit_le()

Not sure I understand what you're suggesting here: Do you want a
find_next_and_bit_le() or do you want to make _find_next_bit_le() more
like _find_next_bit() ? In the latter case we might just want to merge
it with _find_next_bit() and end up with an extra is_le parameter :)
