Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729596AbfBMVyX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 16:54:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DLrb9M147462
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 16:54:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qmt7dubdg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 16:54:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Feb 2019 21:54:20 -0000
Date: Wed, 13 Feb 2019 23:54:11 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: initramfs tidyups
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
Message-ID: <20190213215411.GF15270@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213215411.pCwAl4UtlwbEON9VKvXTvC_ktaOdhZid5clcxxntbxs@z>

On Wed, Feb 13, 2019 at 06:46:13PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> I've spent some time chasing down behavior in initramfs and found
> plenty of opportunity to improve the code.  A first stab on that is
> contained in this series.
 
For the series:

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

-- 
Sincerely yours,
Mike.
