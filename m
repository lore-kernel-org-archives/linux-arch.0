Return-Path: <SRS0=WjNt=46=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:49724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgCMAit (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2020 20:38:49 -0400
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l, b}e24()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
        <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
        <20200312162507.GF1922688@smile.fi.intel.com>
        <6d932620-3255-fbd8-7fc8-22e4b3068043@acm.org>
        <CAO+b5-rXUU9r-SrCWq2cYbBr5xFqyx4CUMb8xHZv2xYzEP6CyA@mail.gmail.com>
Date: Thu, 12 Mar 2020 20:38:10 -0400
In-Reply-To: <CAO+b5-rXUU9r-SrCWq2cYbBr5xFqyx4CUMb8xHZv2xYzEP6CyA@mail.gmail.com>
        (Bart Van Assche's message of "Thu, 12 Mar 2020 17:29:37 -0700")
Message-ID: <yq1v9n9nl71.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, "linux-nvme @ lists . infradead . org" <linux-nvme@lists.infradead.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <20200313003810.YH_-zkWWPG6CkCT1SU7Lyo11D0oqN4F41YZSm1onGvM@z>


Bart,

> Martin, can I send the second version of my patch series to you or do
> you perhaps prefer that I send it to another kernel maintainer? I'm
> considering to include the following patches:

Happy to take it.

-- 
Martin K. Petersen	Oracle Linux Engineering
