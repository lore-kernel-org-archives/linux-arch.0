Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 2/3] add ->compat_ioctl to dasd
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20051213172320.GB16392@lst.de>
References: <20051213172320.GB16392@lst.de>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 13:07:14 +0100
Message-Id: <1134562034.5496.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-12-13 at 18:23 +0100, Christoph Hellwig wrote:
> Add a compat_ioctl method to the dasd driver so the last entries in
> arch/s390/kernel/compat_ioctl.c can go away.  Unlike the previous
> attempt this one does not replace the ioctl method with an
> unlocked_ioctl method so that the ioctl_by_bdev calls in s390 partition
> code continue to work.

Looks better but still doesn't work. The dasd driver specific ioctls do
work but there are some generic ones that are only available on the
normal ioctl path, including BLKFLSBUF, BLKROSET and HDIO_GETGEO. That
makes e.g. the 32 bit version of fdasd fail with "IOCTL error".

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
