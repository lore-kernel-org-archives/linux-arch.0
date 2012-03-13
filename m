From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/35] Split the switch_to() wrapper out of asm-generic/system.h [ver #2]
Date: Tue, 13 Mar 2012 09:11:30 +0000
Message-ID: <201203130911.30478.arnd@arndb.de>
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233926.13888.93973.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63194 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759883Ab2CMJwp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Mar 2012 05:52:45 -0400
In-Reply-To: <20120312233926.13888.93973.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 12 March 2012, David Howells wrote:
> Split the switch_to() wrapper out of asm-generic/system.h into its own
> asm-generic/system.h as part of the asm/system.h disintegration.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
