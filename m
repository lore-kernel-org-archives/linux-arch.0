Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48021 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab2A3OTc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2012 09:19:32 -0500
MIME-Version: 1.0
In-Reply-To: <d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
References: <cover.1327877053.git.mst@redhat.com>
	<d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
Date: Mon, 30 Jan 2012 08:19:31 -0600
Message-ID: <CACoURw6docF1E4KwvfAAwh3GG0KFo15erj+JJwu0HHB-wtswig@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib: add NO_GENERIC_PCI_IOPORT_MAP
From: Shane McDonald <mcdonald.shane@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Myron Stowe <myron.stowe@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, James Morris <jmorris@namei.org>, "John W. Linville" <linville@tuxdriver.com>, Michael Witten <mfwitten@gmail.com>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120130141931.IZ5yakpMpqLcPLqQy93XJcpIo49OSZka3ji5AntYKrI@z>

Just a minor nit on the comment:

On Mon, Jan 30, 2012 at 6:18 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Some architectures need to override the way
> IO port mapping is does not PCI devices.

Should this line read "IO port mapping is done on PCI devices."?

> Supply a generic function that calls
> ioport_map, and make it possible for architectures
> to override.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Shane
