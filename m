Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:41778 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754598AbXIDXtE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2007 19:49:04 -0400
Subject: Re: Removal of dma_cache_* functions?
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070904130707.GA16556@linux-mips.org>
References: <20070904115615.GA14986@linux-mips.org>
	 <20070904124212.GR14130@parisc-linux.org>
	 <1188910630.3435.2.camel@localhost.localdomain>
	 <20070904130707.GA16556@linux-mips.org>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 00:49:01 +0100
Message-Id: <1188949741.8160.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-09-04 at 14:07 +0100, Ralf Baechle wrote:
> I wasn't thinking of touching dma_cache_sync, only the three mentioned
> mostly unused ones.

OK, I suspected not but your subject line:

Removal of dma_cache_* functions?

Worried me in that regard.

Jaems


