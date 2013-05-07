From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Build errors caused by modalias generation patch
Date: Tue, 7 May 2013 12:04:47 +0200
Message-ID: <20130507100447.GA15044@linux-mips.org>
References: <20130506160253.GA27181@linux-mips.org>
 <87mws8m3eu.fsf@hase.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:41929 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab3EGKFK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 May 2013 06:05:10 -0400
Received: from localhost.localdomain ([127.0.0.1]:36878 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822675Ab3EGKFDCkn1d (ORCPT <rfc822;linux-arch@vger.kernel.org>
        + 1 other); Tue, 7 May 2013 12:05:03 +0200
Content-Disposition: inline
In-Reply-To: <87mws8m3eu.fsf@hase.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org

On Mon, May 06, 2013 at 07:19:53PM +0200, Andreas Schwab wrote:

> Please try the patch in
> <http://marc.info/?l=linux-kbuild&m=136767800809256&w=2>.

No change in observed behaviour.  I did all my builds in empty object
directories so I don't see why this patch would make any difference.

  Ralf
