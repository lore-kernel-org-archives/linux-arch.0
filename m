Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:34570 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758022AbZFNWPp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 14 Jun 2009 18:15:45 -0400
Date: Sun, 14 Jun 2009 18:15:36 -0400 (EDT)
From: Tim Abbott <tabbott@ksplice.com>
Subject: Re: [PATCH] Improve vmlinux.lds.h support for arch specific linker
 scripts
In-Reply-To: <20090614202244.GA2951@uranus.ravnborg.org>
Message-ID: <alpine.DEB.1.10.0906141621550.24859@vinegar-pot.mit.edu>
References: <20090607185430.GA15299@uranus.ravnborg.org> <alpine.DEB.1.10.0906112032560.9154@vinegar-pot.mit.edu> <20090614202244.GA2951@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Anders Kaseorg <andersk@ksplice.com>
Message-ID: <20090614221536.SsbXxLqq66WKZPeLzmJX6MmnOwyPIKT2wxlhU92nUH4@z>

On Sun, 14 Jun 2009, Sam Ravnborg wrote:

> On Fri, Jun 12, 2009 at 10:52:06AM -0400, Tim Abbott wrote:
> > This patch looks great.  I have a few very minor comments.
> I fixed the above in a separate commit, so

I've looked at the new commit in kbuild-next.git, and it looks good.  You 
should feel free to add my ack to both patches (or a combined patch if 
they end up being squashed together).

Acked-by: Tim Abbott <tabbott@ksplice.com>

	-Tim Abbott
