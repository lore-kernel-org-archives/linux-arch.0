From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 10/34] powerpc/PCI: allow reallocation on PA Semi
Date: Wed, 7 Mar 2012 14:35:29 -0800
Message-ID: <CAOesGMiPJg1gbsq_iBc6_6JrOtTonSoic-gGudBNpmz2BEHv8g@mail.gmail.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
	<20120307223255.25669.42520.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61598 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030794Ab2CGWfa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 17:35:30 -0500
Received: by wgbdr13 with SMTP id dr13so6000399wgb.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2012 14:35:29 -0800 (PST)
In-Reply-To: <20120307223255.25669.42520.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Wed, Mar 7, 2012 at 2:32 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> We believe there's no reason to prevent reallocation on PA Semi, so
> revert to the default of "allow reallocation if necessary."
>
> CC: Olof Johansson <olof@lixom.net>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Tested-by: Olof Johansson <olof@lixom.net>
Acked-by: Olof Johansson <olof@lixom.net>
