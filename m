Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39112 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750952AbYKPPrC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Nov 2008 10:47:02 -0500
Date: Sun, 16 Nov 2008 15:46:57 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] Remove CONFIG_STRICT_DEVMEM
Message-ID: <20081116154657.6629e6bf@lxorguk.ukuu.org.uk>
In-Reply-To: <20081116162149.07f05c7c@kopernikus.site>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
	<1226846868-9595-4-git-send-email-bwalle@suse.de>
	<20081116150901.4d824e6d@lxorguk.ukuu.org.uk>
	<20081116162149.07f05c7c@kopernikus.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, crash-utility@redhat.com
Message-ID: <20081116154657.yIwfUP7t-I33vn1CTIZAtLDp7zJeGqv3XIowygJshA0@z>

> if just that patch doesn't make it, well, ok for me. I just think
> CONFIG_STRICT_DEVMEM is superfluous when the runtime configuration
> option is present.

It should always be "N" because the only other option means "add
pointless code of no value whatsoever"

Which means strict_devmem really belongs in the bitbucket as a bad idea

Alan


