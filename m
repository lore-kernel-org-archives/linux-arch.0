Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:48333 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbYD2VQs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Apr 2008 17:16:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18455.36914.506429.279177@cargo.ozlabs.ibm.com>
Date: Wed, 30 Apr 2008 07:16:34 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Add fast little-endian switch system call
In-Reply-To: <20080429184047.47CB7247B4@gemini.denx.de>
References: <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
	<20080429184047.47CB7247B4@gemini.denx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, mtk.manpages@gmail.com
Message-ID: <20080429211634.yXYoYhf119a7Rzsm-5bCkC7yUDwRZMg7osbSvMScvH4@z>

Wolfgang Denk writes:

> This probably depends a bit on  the  performance  of  the  system  in
> question. Did you measure it - for example - on a 50 MHz MPC850 ?

The patch only affects arch/powerpc/kernel/entry_64.S.  So no, I
didn't measure it on a 50MHz MPC850, or indeed any 32-bit system. :)

Paul.
