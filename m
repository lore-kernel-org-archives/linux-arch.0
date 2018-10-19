Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:37776 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSMxW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Oct 2018 08:53:22 -0400
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <20181017080201.10866-8-hch@lst.de>
In-Reply-To: <20181017080201.10866-8-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 19 Oct 2018 13:48:19 +0900
Message-ID: <CAK7LNATAk1oL8xbwp4RqMcZc5CtU7=YCqN2wHcSOq4RsJtJgRA@mail.gmail.com>
Subject: Re: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in drivers/eisa
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20181019044819.8xBt9nPxKCXn2189QIpDEhtrCnLwzkDDBGkCV6C9i8U@z>

On Wed, Oct 17, 2018 at 5:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Let architectures opt into EISA support by selecting HAS_EISA and

Nit.

HAS_EISA -> HAVE_EISA
since you renamed it in this version.



> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---
-- 
Best Regards
Masahiro Yamada
