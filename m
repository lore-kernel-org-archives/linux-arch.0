Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:56362 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbcA0Mrs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 07:47:48 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Jan 2016 12:47:46 -0000
Subject: Re: [PATCH/RFC 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
References: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
 <1453799905-10941-4-git-send-email-borntraeger@de.ibm.com>
 <20160126181903.GB4671@osiris>
 <alpine.DEB.2.10.1601261525580.25141@chino.kir.corp.google.com>
 <20160127001918.GA7089@js1304-P5Q-DELUXE>
 <alpine.DEB.2.10.1601261633520.6121@chino.kir.corp.google.com>
 <20160127005920.GB7089@js1304-P5Q-DELUXE> <56A8BB15.9070305@suse.cz>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <56A8BC6D.9080101@de.ibm.com>
Date: Wed, 27 Jan 2016 13:47:41 +0100
MIME-Version: 1.0
In-Reply-To: <56A8BB15.9070305@suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, David Rientjes <rientjes@google.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
Message-ID: <20160127124741.ENRA20g9XWMD1yGWmV5NBwzs3DQaUbccHry2L5Ox9q8@z>

On 01/27/2016 01:41 PM, Vlastimil Babka wrote:
> On 01/27/2016 01:59 AM, Joonsoo Kim wrote:
>> On Tue, Jan 26, 2016 at 04:36:11PM -0800, David Rientjes wrote:
>>>
>>> If we can convert existing users that only check for 
>>> CONFIG_DEBUG_PAGEALLOC to rather check for debug_pagealloc_enabled() and 
>>> agree that it is only enabled for debug_pagealloc=on, then this would seem 
>>> fine.  However, I think we should at least consult with those users before 
>>> removing an artifact from the kernel log that could be useful in debugging 
>>> why a particular BUG() happened.
>>
>> Yes, at least, non-architecture dependent code (vmalloc, SLAB, SLUB) should
>> be changed first. If Christian doesn't mind, I will try to fix above 3
>> things.
> 
> I think it might be worth also to convert debug_pagealloc_enabled() to be based
> on static key, like I did for page_owner [1]. That should help make it possible
> to have virtually no overhead when compiling kernel with CONFIG_DEBUG_PAGEALLOC
> without enabling it boot-time. I assume it's one of the goals here?

We could do something like that but dump_stack and setup of the initial identity
mapping of the kernel as well as the initial page protection are not hot path
as far as I can tell. Any other places?

> 
> [1] http://www.spinics.net/lists/linux-mm/msg100795.html



