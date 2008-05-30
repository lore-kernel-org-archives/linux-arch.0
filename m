From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
Date: Thu, 29 May 2008 21:14:35 -0700
Message-ID: <1212120875.28403.179.camel@brick>
References: <1212092282.28403.107.camel@brick> <483F65CA.4050507@rtr.ca>
	 <20080529195225.5665ae9c.akpm@linux-foundation.org>
	 <1212118661.28403.175.camel@brick>
	 <20080529210859.0feee69d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:11150 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761116AbYE3EOj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 00:14:39 -0400
Received: by el-out-1112.google.com with SMTP id s27so97929ele.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 21:14:38 -0700 (PDT)
In-Reply-To: <20080529210859.0feee69d.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Lord <liml@rtr.ca>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>

On Thu, 2008-05-29 at 21:08 -0700, Andrew Morton wrote:
> On Thu, 29 May 2008 20:37:40 -0700 Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > On Thu, 2008-05-29 at 19:52 -0700, Andrew Morton wrote:
> > > On Thu, 29 May 2008 22:26:18 -0400 Mark Lord <liml@rtr.ca> wrote:
> > > 

> > I'm flexible...although I'd probably get nailed to a cross for changing
> > it again so soon. (the unaligned versions, that is)
> 
> We'll live.
> 
> (I'm not a big fan of the patches, btw.  It's more of an "oh groan,
> because it's there I suppose we really ought to do this" sort of thing.
> (strong objections would save me a lot of work (looks hopefully at
> inbox))).

Well in the case of the le16_to_cpu(*(__le16 *)ptr), it can be
profitable to use the le16_to_cpup..or get_le16 directly as
some arches have optimized versions of the pointer versions.

Harvey
