From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Date: Wed, 24 Jul 2019 22:49:19 +0100
Message-ID: <14026.1564004959@warthog.procyon.org.uk>
References: <1563993952.11067.15.camel@lca.pw> <1563914986-26502-1-git-send-email-cai@lca.pw> <31573.1563954571@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1563993952.11067.15.camel@lca.pw>
Content-ID: <14025.1564004959.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de, jakub@redhat.com, ndesaulniers@google.com, morbo@google.com, jyknight@google.com, natechancellor@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Qian Cai <cai@lca.pw> wrote:

> I have GCC 8.2.1 which works fine.

But you need to check the minimum version, i.e. 4.6:

	#if GCC_VERSION < 40600

David
