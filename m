From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 19/35] Move the asm-generic/system.h xchg() implementation to asm-generic/cmpxchg.h [ver #2]
Date: Tue, 13 Mar 2012 09:11:04 +0000
Message-ID: <201203130911.04721.arnd@arndb.de>
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233916.13888.17108.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120312233916.13888.17108.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 12 March 2012, David Howells wrote:
> Move the asm-generic/system.h xchg() implementation to asm-generic/cmpxchg.h
> to simplify disintegration of asm/system.h.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
