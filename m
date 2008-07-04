From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 4/5] byteorder: fix direct byteswap includes
Date: Fri, 04 Jul 2008 09:37:53 -0700
Message-ID: <1215189473.16647.80.camel@brick>
References: <1215144734.16647.70.camel@brick>  <27042.1215185863@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:34527 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbYGDQiA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jul 2008 12:38:00 -0400
Received: by py-out-1112.google.com with SMTP id p76so798731pyb.10
        for <linux-arch@vger.kernel.org>; Fri, 04 Jul 2008 09:37:57 -0700 (PDT)
In-Reply-To: <27042.1215185863@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, 2008-07-04 at 16:37 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > +#include <asm/byteorder.h>
> 
> Please use <linux/byteorder.h> rather than <asm/byteorder.h> when including
> stuff from .c files outside the include and arch directories.

asm/byteorder.h is the file included everywhere else, and before my
patches, linux/byteorder.h didn't even exist.  Thus, when preparing my
patches I made sure that including asm/byteorder.h continued to be the
way to get this functionality.

I could add another patch  on top that makes linux/byteorder the one we
want included and search/replace the existing asm includes, but I thought
that was a bit too big to do in one go.

If people think this is the way to go, I'll prepare a patch to change the
includes.

> And whilst you're at it, Documentation/byteorder.txt is yours for the
> creation:-)

Already working on an update to unaligned_access.txt, I'll get to
byteorder next.

Harvey
