Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:35303 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757813AbbIVKaM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Sep 2015 06:30:12 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Tue, 22 Sep 2015 11:30:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 68AF817D8059
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2015 11:31:59 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t8MAU7RS33292428
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2015 10:30:07 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t8MAU7sh002304
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2015 04:30:07 -0600
Date: Tue, 22 Sep 2015 12:30:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/2] mm: add architecture primitives for software dirty
 bit clearing
Message-ID: <20150922123001.09449feb@mschwide>
In-Reply-To: <20150922090935.GA10131@uranus>
References: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
	<1442848940-22108-2-git-send-email-schwidefsky@de.ibm.com>
	<20150921194854.GD3181@uranus>
	<20150922093549.504a5fb3@mschwide>
	<20150922090935.GA10131@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linuxfoundation.org>, Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <20150922103001.dKWi_z5vc5VOV-aiheCrZVDBFgNeDYy5W9OkeTXkuuc@z>

On Tue, 22 Sep 2015 12:09:35 +0300
Cyrill Gorcunov <gorcunov@gmail.com> wrote:

> On Tue, Sep 22, 2015 at 09:35:49AM +0200, Martin Schwidefsky wrote:
> > Thanks. I have added both patches to the features branch of linux-s390
> > for the 4.4 merge window.
> 
> The first patch (x86 and general helpers) seems better to go via
> Andrew (CC'ed) becase they are not s390 only. And while these
> changes are fine for me and you as far as I can say, lets them
> floating around for some more review just to make sure we're not
> missing something obvious.
> 
> And initially the soft-dirty feature has been hittin vanilla by
> -mm tree so I suppose we should continue this way, though I
> don't mind if it gonna be merged via pull request from s390
> side but still ;)
 
Well, the patches will be included in linux-next automatically and
they will get a fair share of testing before the 4.4 merge window
opens. If the patches get picked up via -mm as well, be my guest.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

