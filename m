From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/2] mm: add architecture primitives for software dirty
 bit clearing
Date: Tue, 22 Sep 2015 09:35:49 +0200
Message-ID: <20150922093549.504a5fb3@mschwide>
References: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
	<1442848940-22108-2-git-send-email-schwidefsky@de.ibm.com>
	<20150921194854.GD3181@uranus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:46387 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340AbbIVHfz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Sep 2015 03:35:55 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Tue, 22 Sep 2015 08:35:53 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1031B17D805D
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2015 08:37:44 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t8M7Zqu634603234
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2015 07:35:52 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t8M7Zpub026879
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2015 01:35:52 -0600
In-Reply-To: <20150921194854.GD3181@uranus>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org

On Mon, 21 Sep 2015 22:48:54 +0300
Cyrill Gorcunov <gorcunov@gmail.com> wrote:

> On Mon, Sep 21, 2015 at 05:22:19PM +0200, Martin Schwidefsky wrote:
> > There are primitives to create and query the software dirty bits
> > in a pte or pmd. But the clearing of the software dirty bits is done
> > in common code with x86 specific page table functions.
> > 
> > Add the missing architecture primitives to clear the software dirty
> > bits to allow the feature to be used on non-x86 systems, e.g. the
> > s390 architecture.
> > 
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Looks good to me. Thank you, Martin!
> (I cant ack s390 part 'casuse I simply not familiar
>  with the architecture).

Sure, the s390 patch just shows why the new arch functions are needed..

> Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>

Thanks. I have added both patches to the features branch of linux-s390
for the 4.4 merge window.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
