Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:24109 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab3JJTud (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2013 15:50:33 -0400
Message-ID: <52570507.9080704@tilera.com>
Date: Thu, 10 Oct 2013 15:50:31 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: [PATCH 28/34] tile: handle pgtable_page_ctor() fail
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com> <1381428359-14843-29-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1381428359-14843-29-git-send-email-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20131010195031.wBlcczttcobcuW23nr_VXDkor9u0p89mA8cXWrdJX3w@z>

On 10/10/2013 2:05 PM, Kirill A. Shutemov wrote:
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> ---
>  arch/tile/mm/pgtable.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

