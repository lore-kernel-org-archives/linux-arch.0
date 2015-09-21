From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 1/2] mm: add architecture primitives for software dirty
 bit clearing
Date: Mon, 21 Sep 2015 22:48:54 +0300
Message-ID: <20150921194854.GD3181@uranus>
References: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
 <1442848940-22108-2-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34518 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073AbbIUTs5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2015 15:48:57 -0400
Received: by lbbmp1 with SMTP id mp1so57133301lbb.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2015 12:48:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442848940-22108-2-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org

On Mon, Sep 21, 2015 at 05:22:19PM +0200, Martin Schwidefsky wrote:
> There are primitives to create and query the software dirty bits
> in a pte or pmd. But the clearing of the software dirty bits is done
> in common code with x86 specific page table functions.
> 
> Add the missing architecture primitives to clear the software dirty
> bits to allow the feature to be used on non-x86 systems, e.g. the
> s390 architecture.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Looks good to me. Thank you, Martin!
(I cant ack s390 part 'casuse I simply not familiar
 with the architecture).

Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>
