Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62569 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787Ab2CMLd4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Mar 2012 07:33:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/35] Disintegrate asm/system.h for Hexagon [ver #2]
Date: Tue, 13 Mar 2012 11:33:32 +0000
References: <201203130916.15118.arnd@arndb.de> <20120312233747.13888.75605.stgit@warthog.procyon.org.uk> <27808.1331632900@redhat.com>
In-Reply-To: <27808.1331632900@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201203131133.32241.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org
Message-ID: <20120313113332.qtk5g_MObJGSHnf_z1-YsDE61PEQhKIXSfwyV4ZMD3g@z>

On Tuesday 13 March 2012, David Howells wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Looking at this example, it could easily use the asm-generic versions of
> > switch_to.h and barrier.h, but that would complicate the dependency chain
> > again.
> 
> Yep.  The plan is to throw more patches on to the end of the series to
> consolidate those.
> 
> In fact, I wonder if we still really need the switch_to() macro wrapper, or
> whether we could replace it with an function, inline or otherwise, that
> returns the macro's third argument.

Sounds like a great idea, yes.

	Arnd
