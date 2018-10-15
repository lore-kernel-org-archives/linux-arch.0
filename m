Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41094 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOQvV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Oct 2018 12:51:21 -0400
Date: Mon, 15 Oct 2018 11:06:56 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/
Message-ID: <20181015090656.GD27159@lst.de>
References: <20181013151016.31674-1-hch@lst.de> <CAK7LNAQ3SNStaA6-tOWhm0QHWpNczO07x9T2F7gMcusduMS7GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ3SNStaA6-tOWhm0QHWpNczO07x9T2F7gMcusduMS7GA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Christoph Hellwig <hch@lst.de>, mporter@kernel.crashing.org, alex.bou9@gmail.com, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20181015090656.4IH7Ci-M0hReByjsNdbQyl6FQQKNlUjbCXL6VcmWQc8@z>

> Thanks for great work again.
> 
> However, I suspect some breakages
> (not testing yet, just quick review by my eyes.)
> 
> I left some comments in individual patches.

Thanks.  I've updated the git tree based on your comments.
