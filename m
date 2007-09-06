Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:64438 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbXIFV2w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2007 17:28:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so248497rvb
        for <linux-arch@vger.kernel.org>; Thu, 06 Sep 2007 14:28:51 -0700 (PDT)
Message-ID: <1defaf580709061428y29b041f7sf7e3b49eacabd96a@mail.gmail.com>
Date: Thu, 6 Sep 2007 22:28:51 +0100
From: "=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=" <hskinnemoen@gmail.com>
Subject: Re: [PATCH] Removal of dma_cache_(wback|inv|wback_inv) functions
In-Reply-To: <20070906113918.GA1585@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070904115615.GA14986@linux-mips.org>
	 <20070904124212.GR14130@parisc-linux.org>
	 <20070906113918.GA1585@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 9/6/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> So this is looking ok?  I got an ACK from Paul Mundt for SH.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

AVR32 bits look good to me.

Acked-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
