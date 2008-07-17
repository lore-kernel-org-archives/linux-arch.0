From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] byteorder: add a new include/linux/swab.h to define
 byteswapping functions
Date: Thu, 17 Jul 2008 15:59:53 -0700
Message-ID: <20080717155953.5cddc48d.akpm@linux-foundation.org>
References: <1216148509.6610.14.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54739 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752495AbYGQXA0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Jul 2008 19:00:26 -0400
In-Reply-To: <1216148509.6610.14.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Tue, 15 Jul 2008 12:01:49 -0700
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Collect the implementations from include/linux/byteorder/swab.h, swabb.h
> in swab.h

I'm afraid I've been basically ignoring the storm of byteorder and
related patches simply because I do not have a large enough brain to
work out wth is going on.

I get the impression that there's a great storm of random patches, some
of which are repeats, with a distressing number of updates all with no
overall plan.  Probably I'm wrong about that, but making it all not
_look_ like that would really help.

So ho hum.  I merged these two into -mm, at the tail of the queue, in a
new "byteorder" "tree", probably for 2.6.28.  We could bump them up
into 2.6.27-rc1 if that would help merging followup stuff out into the
subsystem trees during the 2.6.27-rcX cycle.

But please be aware that this ongoing patchstorm is quite confusing
from where I sit, and I just haven't been able to justify expending all
the time which it seems that it requires for me to work out just what
the heck is going on.

So please, send the patches less frequently, in larger batches, after
lots of testing.  Each series should have some overall theme which is
clearly explained in an easy-to-follow fashion.

Ta.
