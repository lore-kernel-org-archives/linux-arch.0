Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728670AbfBNSjJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Feb 2019 13:39:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EId4DH056035
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 13:39:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qncg0nc7y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 13:39:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 14 Feb 2019 18:39:05 -0000
Date: Thu, 14 Feb 2019 20:38:55 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 0/4] provide a generic free_initmem implementation
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
 <20190214170416.GA32441@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214170416.GA32441@lst.de>
Message-ID: <20190214183854.GA10795@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org
Message-ID: <20190214183855.83beBqWTxwIQJc7KtZ2K6-kGtoVqVFSgHxokM11Q0hI@z>

On Thu, Feb 14, 2019 at 06:04:16PM +0100, Christoph Hellwig wrote:
> This look fine to me, but I'm a little worried that as-is this will
> just create conflicts with my series..

I'll rebase on top of your patches once they are in. Or I can send both
series as a single set.
Preferences? 

-- 
Sincerely yours,
Mike.
