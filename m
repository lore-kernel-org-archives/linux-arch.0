From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/7] Blackfin: Don't redefine
 blackfin serial port symbols
Date: Thu, 26 Aug 2010 15:38:37 -0400
Message-ID: <AANLkTinxwf6kY6hCnUn=ATSYFutCAeSJQ1pgUj11UfD4@mail.gmail.com>
References: <20100826141110.11132.91931.stgit@warthog.procyon.org.uk> <20100826141115.11132.52122.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42513 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0HZTi6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2010 15:38:58 -0400
In-Reply-To: <20100826141115.11132.52122.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

On Thu, Aug 26, 2010 at 10:11, David Howells wrote:
> Various Blackfin machine-specific headers override Blackfin serial port
> symbols from the <asm/bfin_sport.h> header file with exactly the same values.
>
> Remove the duplicates in favour of the master header.

we've got a local patch doing pretty much the same thing, but it's
waiting on driver patches being applied.  so once those are all set, i
can push up the Blackfin one.
-mike
