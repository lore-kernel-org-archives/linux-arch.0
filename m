Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Tue, 13 Dec 2005 01:30:04 +0100
References: <dhowells1134431145@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512130130.05186.arnd@arndb.de>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Am Dienstag 13 Dezember 2005 00:45 schrieb David Howells:
>  (7) Provides a debugging config option CONFIG_DEBUG_MUTEX_OWNER by which
> the mutex owner can be tracked and by which over-upping can be detected.

I can't see how your code actually detects the over-upping, although it's 
fairly obvious how it would be done. Did you miss one patch for this?

	Arnd <><
