Return-Path: <SRS0=UTne=45=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33040 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgCLPVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2020 11:21:14 -0400
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l,
 b}e24()
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <4c81594e-6b30-d1ff-31f6-0d8cfbf5ba3c@acm.org>
Date: Thu, 12 Mar 2020 08:21:10 -0700
MIME-Version: 1.0
In-Reply-To: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20200312152110.vUpZSrN0nCr0GA_1sN1oW0C6LHauo5z8D1B1cfS2xlE@z>

On 2020-03-12 04:39, Andy Shevchenko wrote:
> +static inline u32 get_unaligned_be24(const u8 *buf)
> +{
> +	return (u32)p[0] << 16 | (u32)p[1] << 8 | (u32)p[2];
> +}

The argument is called 'buf' and the function body dereferences a
pointer called 'p'. Does this even compile?

Bart.
