From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/3] sh: use the the PCI channels's io_map_base
Date: Mon, 30 Jan 2012 20:50:45 +0300
Message-ID: <4F26D875.7050403@mvista.com>
References: <cover.1327877053.git.mst@redhat.com> <60def7835613710ecae4878ae5742c45b05791df.1327877053.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42656 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab2A3QvU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2012 11:51:20 -0500
In-Reply-To: <60def7835613710ecae4878ae5742c45b05791df.1327877053.git.mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Myron Stowe <myron.stowe@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, James Morris <jmorris@namei.org>, "John W. Linville" <linville@tuxdriver.com>, Michael Witten <mfwitten@gmail.com>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org

Hello.

On 01/30/2012 03:19 PM, Michael S. Tsirkin wrote:

> commit 43db595e8b5d78ce5ad2feab719814a76e3ad2e5

    Please add that commit's summary in parens.

> failed to take into account the PCI channels's
> io_map_base for mapping IO BARs.
> This also caused a new warning on sh.

> Fix this, without re-introducing code duplication,
> by setting NO_GENERIC_PCI_IOPORT_MAP
> and supplying a sh-specific __pci_ioport_map.

> Reported-by: Kevin Cernekee<cernekee@gmail.com>
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

WBR, Sergei
