Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56086 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964857Ab2CMJwt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Mar 2012 05:52:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 19/35] Move the asm-generic/system.h xchg() implementation to asm-generic/cmpxchg.h [ver #2]
Date: Tue, 13 Mar 2012 09:11:04 +0000
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233916.13888.17108.stgit@warthog.procyon.org.uk>
In-Reply-To: <20120312233916.13888.17108.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <201203130911.04721.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120313091104.jAGHK4tz1qGObAlvB-lVWT2mXihcrh_GaxQkSe-lp0g@z>

On Monday 12 March 2012, David Howells wrote:
> Move the asm-generic/system.h xchg() implementation to asm-generic/cmpxchg.h
> to simplify disintegration of asm/system.h.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

