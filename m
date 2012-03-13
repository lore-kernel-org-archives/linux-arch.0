From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 29/35] Disintegrate asm/system.h for Tile [ver #2]
Date: Tue, 13 Mar 2012 13:59:44 -0400
Message-ID: <4F5F8B10.1090209@tilera.com>
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312234058.13888.826.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([206.83.70.75]:21128 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758255Ab2CMR7q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Mar 2012 13:59:46 -0400
In-Reply-To: <20120312234058.13888.826.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de

On 3/12/2012 7:40 PM, David Howells wrote:
> Disintegrate asm/system.h for Tile.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Chris Metcalf <cmetcalf@tilera.com>

This looks like you compile-tested it, at least, and looks about right.  If
further changes seem useful I'm happy to propose them after this hits
main.  So:

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
