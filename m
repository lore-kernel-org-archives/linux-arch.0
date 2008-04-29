Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:57153 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757633AbYD2Sqj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Apr 2008 14:46:39 -0400
Date: Tue, 29 Apr 2008 20:46:23 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Add fast little-endian switch system call
Message-ID: <20080429184623.GA23654@lst.de>
References: <18454.35824.527711.355488@cargo.ozlabs.ibm.com> <20080429184047.47CB7247B4@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080429184047.47CB7247B4@gemini.denx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, mtk.manpages@gmail.com
Message-ID: <20080429184623.2yfRyHKydSGReSiFftGJ1QpzNd8N8VZpmb3DOT2OdR0@z>

On Tue, Apr 29, 2008 at 08:40:47PM +0200, Wolfgang Denk wrote:
> This probably depends a bit on  the  performance  of  the  system  in
> question. Did you measure it - for example - on a 50 MHz MPC850 ?

You got a 64bit kernel to run on a MPC850? wow :)

Not sure what the slowest supported 64bit cpu is (RS64-II?), but Paul
might be right and in this case it really doesn't matter.

