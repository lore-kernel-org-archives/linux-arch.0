Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:4749 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S964927AbWHHOjJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Aug 2006 10:39:09 -0400
Date: Tue, 8 Aug 2006 10:38:31 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 9/13] Generic ioremap_page_range: parisc conversion
Message-ID: <20060808143831.GC4896@athena.road.mcmartin.ca>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com> <11550397962723-git-send-email-hskinnemoen@atmel.com> <1155039796165-git-send-email-hskinnemoen@atmel.com> <11550397964177-git-send-email-hskinnemoen@atmel.com> <1155039796529-git-send-email-hskinnemoen@atmel.com> <11550397963281-git-send-email-hskinnemoen@atmel.com> <11550397961615-git-send-email-hskinnemoen@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11550397961615-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 08, 2006 at 02:23:11PM +0200, Haavard Skinnemoen wrote:
> Convert parisc to use generic ioremap_page_range()
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> 

Looks good. Nice to see such a big reduction in LoC.

Acked-by: Kyle McMartin <kyle@parisc-linux.org>
