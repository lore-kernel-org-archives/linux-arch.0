Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:55984 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752721AbXCEIY5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 5 Mar 2007 03:24:57 -0500
Date: Mon, 5 Mar 2007 09:24:35 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [patch 1/1] avr32: dma-mapping.h
Message-ID: <20070305092435.1b1a215b@dhcp-252-105.norway.atmel.com>
In-Reply-To: <200703030057.l230vkoH024337@shell0.pdx.osdl.net>
References: <200703030057.l230vkoH024337@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, zambrano@broadcom.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 02 Mar 2007 16:57:46 -0800
akpm@linux-foundation.org wrote:

> From: "Gary Zambrano" <zambrano@broadcom.com>
> 
> Added dma_sync_single_range_for_cpu/device to dma-mapping.h in asm-avr32 to
> call dma_sync_single_for_cpu/device.  This patch enables b44 to compile on
> systems with these cpus.  This patch was created with the assumption that
> another method of dma_sync_single_range_for_cpu/device does not exist on these
> architectures.
> 
> Signed-off by: Gary Zambrano <zambrano@broadcom.com>
> Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Applied, although it's still a mystery to me what those two functions
are actually supposed to do and why it isn't ok to just flush the
specified range...

I also moved them below the definitions of
dma_sync_single_for_{cpu,device}() so that it compiles.

Haavard
