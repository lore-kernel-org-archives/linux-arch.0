Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35752 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966189AbbD2HbE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Apr 2015 03:31:04 -0400
Received: by wgyo15 with SMTP id o15so18387812wgy.2
        for <linux-arch@vger.kernel.org>; Wed, 29 Apr 2015 00:31:03 -0700 (PDT)
Message-ID: <554088B4.2020804@plexistor.com>
Date: Wed, 29 Apr 2015 10:31:00 +0300
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] scatterlist: enable sg chaining for all architectures
References: <1429973776-7499-1-git-send-email-akinobu.mita@gmail.com>	 <20150428142743.578d1c930aca013b596d7546@linux-foundation.org>	 <1430259419.2181.26.camel@HansenPartnership.com>	 <CAC5umyhM6s4dgJt6BQMhVihh3C8uYd+s2XEZB9UTQKK63OXxfQ@mail.gmail.com> <1430273746.2181.49.camel@HansenPartnership.com>
In-Reply-To: <1430273746.2181.49.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Akinobu Mita <akinobu.mita@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>, target-devel@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>
Message-ID: <20150429073100.KcnYI3xb82JccVmRInu-MJCYXb05urZuUDQpcTidfcc@z>

On 04/29/2015 05:15 AM, James Bottomley wrote:
> 
> Perhaps the best thing to do is just fix target and call it quits?
> 

Right! drivers write code for sg_chaining and on ARCHs that do not
support it the code just works.
Only the max_sg is smaller and the chaining code never kicks in
and is dead code for these ARCHs.

> James

Cheers
Boaz

