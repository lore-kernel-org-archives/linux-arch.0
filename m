From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 6/8] mm: Make transparent huge code not depend upon the
 details of pgtable_t
Date: Wed, 3 Oct 2012 00:49:21 +0200
Message-ID: <20121002224921.GR4763@redhat.com>
References: <20121002.182718.250164928532772411.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45243 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901Ab2JBWt3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Oct 2012 18:49:29 -0400
Content-Disposition: inline
In-Reply-To: <20121002.182718.250164928532772411.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org

Hi Dave,

On Tue, Oct 02, 2012 at 06:27:18PM -0400, David Miller wrote:
> 
> The code currently assumes that pgtable_t is a struct page pointer.
> 
> Fix this by pushing pgtable management behind arch helper functions.

This should be fixed in -mm already, it's from the s390x support.
