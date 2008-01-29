Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:38262 "HELO
	web31812.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752333AbYA2WQd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Jan 2008 17:16:33 -0500
Date: Tue, 29 Jan 2008 14:09:52 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: DMA mapping on SCSI device?
In-Reply-To: <479E6E8C.2090501@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <896139.88121.qm@web31812.mail.mud.yahoo.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

--- On Mon, 1/28/08, Robert Hancock <hancockr@shaw.ca> wrote:
> The trick is that if an ATAPI device is connected, we (as
> far as I'm 
> aware) can't use ADMA mode, so we have to switch that
> port into legacy 
> mode.

Can you double check this with the HW architect of the
HW DMA engine of the ASIC?

> This means it's only capable of 32-bit DMA.
> However the other port 
> on the controller may be connected to a hard drive and
> therefore still 
> capable of 64-bit DMA.

If this is indeed the case as you've presented it here,
it sounds like a HW shortcoming.  I cannot see how the device
type (or protocol) dictate how the DMA engine operates.
They live in two different domains.

> The ideal solution would be to do mapping against a
> different struct 
> device for each port, so that we could maintain the proper
> DMA mask for 
> each of them at all times. However I'm not sure if
> that's possible. The 
> thought of using the SCSI struct device for DMA mapping was
> brought up 
> at one point.. any thoughts on that?

The reason for this is that the object that a struct scsi_dev
represents has nothing to do with HW DMA engines.

It looks like your current solution is correct and
x86_64's blk_queue_bounce_limit needs work.

    Luben

