Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39258 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbL1Vhg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Dec 2015 16:37:36 -0500
Date: Tue, 29 Dec 2015 08:37:33 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 09/16] drivers: Initialize resource entry to zero
Message-ID: <20151228213733.GA16152@verge.net.au>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-9-git-send-email-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451081365-15190-9-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org
Message-ID: <20151228213733.ey5BFHH__R73mfmmPYGliShOo877J8GhxyxMke6kgU8@z>

On Fri, Dec 25, 2015 at 03:09:18PM -0700, Toshi Kani wrote:
> I/O resource descriptor, 'desc' added to struct resource, needs
> to be initialized to zero by default.  Some drivers call kmalloc()
> to allocate a resource entry, but does not initialize it to zero
> by memset().  Change these drivers to call kzalloc(), instead.
> 
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> ---
>  drivers/acpi/acpi_platform.c       |    2 +-
>  drivers/parisc/eisa_enumerator.c   |    4 ++--
>  drivers/rapidio/rio.c              |    8 ++++----
>  drivers/sh/superhyway/superhyway.c |    2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)

drivers/sh/ portion:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

