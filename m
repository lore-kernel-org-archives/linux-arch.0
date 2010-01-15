Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-158.bluehost.com ([67.222.39.38]:46141 "HELO
	outbound-mail-158.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751750Ab0AOSaS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Jan 2010 13:30:18 -0500
Date: Fri, 15 Jan 2010 10:23:37 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/2] resource: align functions now return start of
 resource
Message-ID: <20100115102337.43c47b02@jbarnes-piketon>
In-Reply-To: <1262364050-8540-1-git-send-email-linux@dominikbrodowski.net>
References: <20100101163811.GA8124@comet.dominikbrodowski.net>
	<1262364050-8540-1-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Yinghai Lu <yhlu.kernel@gmail.com>
Message-ID: <20100115182337.3Yi_98XUh1nxPgDpweIsXIs57GmjYGfdIHtjkR2p6CE@z>

On Fri,  1 Jan 2010 17:40:49 +0100
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> As suggested by Linus, align functions should return the start
> of a resource, not void. An update of "res->start" is no longer
> necessary.

Applied these two to my linux-next branch, thanks Dominik.

-- 
Jesse Barnes, Intel Open Source Technology Center
