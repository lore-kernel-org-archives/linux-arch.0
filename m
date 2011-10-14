Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42615 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756931Ab1JNPOS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Oct 2011 11:14:18 -0400
Subject: Re: [PATCH v2 00/29] Create PCI root buses with correct resources
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Oct 2011 10:14:14 -0500
Message-ID: <1318605254.3018.20.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20111014151414.ha9j0HxhxSH0VLBlH1vw6QL-v4WxD0pe1HmpiyX2tSw@z>

On Thu, 2011-10-13 at 22:27 -0600, Bjorn Helgaas wrote:
> The most generic way to create a PCI root bus is with pci_scan_bus(), but
> that doesn't allow you to specify what resources are available on the bus,
> i.e., what the host bridge apertures are.

Do you have an actual tree for this?  The PARISC pieces look a bit
non-trivial and I'd like to test them out on the various sba/astro/dino
systems.

James


