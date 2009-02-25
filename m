From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 14/15] bitops: Change the bitmap index from int to unsigned long [frv]
Date: Wed, 25 Feb 2009 12:37:10 +0000
Message-ID: <16693.1235565430@redhat.com>
References: <200902250452.UAA12902@hpdst41.cup.hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:35848 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbZBYMjO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2009 07:39:14 -0500
In-Reply-To: <200902250452.UAA12902@hpdst41.cup.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Justin Chen <jchen@hpdst41.cup.hp.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, bjorn.helgaas@hp.com, justin.chen@hp.com, linux-kernel@vger.kernel.org

Justin Chen <jchen@hpdst41.cup.hp.com> wrote:

> Change the index to unsigned long in all bitops for [frv]
> 
> Signed-off-by: Justin Chen <justin.chen@hp.com>
> Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Mostly okay, apart from:

> -static inline int __constant_test_bit(int nr, const volatile void * addr)
> +static inline int
> +__constant_test_bit(unsigned long nr, const volatile void *addr)

Please move the return type onto the next line also.  Other than that:

Acked-by: David Howells <dhowells@redhat.com>
