Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:59826 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967966AbXG3THV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jul 2007 15:07:21 -0400
Received: by ug-out-1314.google.com with SMTP id j3so75ugf
        for <linux-arch@vger.kernel.org>; Mon, 30 Jul 2007 12:07:20 -0700 (PDT)
Date: Mon, 30 Jul 2007 23:07:15 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Remove fs.h from mm.h
Message-ID: <20070730190715.GB5776@martell.zuzino.mipt.ru>
References: <20070729223613.GA5916@martell.zuzino.mipt.ru> <alpine.LFD.0.999.0707291706490.3442@woody.linux-foundation.org> <swfhcnmhwqo.wl%takata.hirokazu@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <swfhcnmhwqo.wl%takata.hirokazu@renesas.com>
Sender: linux-arch-owner@vger.kernel.org
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, viro@ftp.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jul 30, 2007 at 10:00:47PM +0900, Hirokazu Takata wrote:
> This change breaks m32r, too.

Apologies. I just finished adding m32r to my cross-build setup, so there
shouldn't be any more such breakages.

