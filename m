Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200512130130.05186.arnd@arndb.de> 
References: <200512130130.05186.arnd@arndb.de>  <dhowells1134431145@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Tue, 13 Dec 2005 21:03:35 +0000
Message-ID: <27928.1134507815@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:

> I can't see how your code actually detects the over-upping, although it's 
> fairly obvious how it would be done. Did you miss one patch for this?

If owner is NULL, then you've probably upped twice.

David
