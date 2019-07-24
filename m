Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387517AbfGXVtW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jul 2019 17:49:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1563993952.11067.15.camel@lca.pw>
References: <1563993952.11067.15.camel@lca.pw> <1563914986-26502-1-git-send-email-cai@lca.pw> <31573.1563954571@warthog.procyon.org.uk>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14025.1564004959.1@warthog.procyon.org.uk>
Date: Wed, 24 Jul 2019 22:49:19 +0100
Message-ID: <14026.1564004959@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de, jakub@redhat.com, ndesaulniers@google.com, morbo@google.com, jyknight@google.com, natechancellor@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190724214919.GxZq_tMt43uURpz-trCJ6IJSEXaIX6RUTV4nP7gkSj0@z>

Qian Cai <cai@lca.pw> wrote:

> I have GCC 8.2.1 which works fine.

But you need to check the minimum version, i.e. 4.6:

	#if GCC_VERSION < 40600

David
