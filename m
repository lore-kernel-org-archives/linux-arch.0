Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeJPEoZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Oct 2018 00:44:25 -0400
Date: Mon, 15 Oct 2018 15:57:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/8] aha152x: rename the PCMCIA define
Message-ID: <20181015205727.GD5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013151016.31674-2-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181015205727.0qPRyhoty61tjlAn48pTiImF4JR9xEnJIE30zpE8Jvg@z>

On Sat, Oct 13, 2018 at 05:10:09PM +0200, Christoph Hellwig wrote:
> We plan to enable building the pcmcia core and drivers, and the
> non-prefixed PCMCIA name clashes with some arch headers.

In the followup PCMCIA patch, you capitalized "PCMCIA core".
