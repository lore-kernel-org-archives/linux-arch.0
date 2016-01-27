Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33463 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935408AbcA0WSb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 17:18:31 -0500
Received: by mail-pa0-f42.google.com with SMTP id cy9so11467976pac.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Jan 2016 14:18:31 -0800 (PST)
Date: Wed, 27 Jan 2016 14:18:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
In-Reply-To: <1453889401-43496-4-git-send-email-borntraeger@de.ibm.com>
Message-ID: <alpine.DEB.2.10.1601271418190.23510@chino.kir.corp.google.com>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com> <1453889401-43496-4-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
Message-ID: <20160127221829.3X7RwTExvQtYQWhB6NOleONToFo4iR5kZv_rwR-JkZQ@z>

On Wed, 27 Jan 2016, Christian Borntraeger wrote:

> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 1MB/2GB pages as well as to print
> the current setting in dump_stack.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
