Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64269 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751663AbcAFBgY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jan 2016 20:36:24 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 UPDATE 09/17] drivers: Initialize resource entry to zero
Date: Wed, 06 Jan 2016 03:07:03 +0100
Message-ID: <4132474.rE6EsOfV8R@vostro.rjw.lan>
In-Reply-To: <1452028537-27365-1-git-send-email-toshi.kani@hpe.com>
References: <1452028537-27365-1-git-send-email-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alexandre.bounine@idt.com>, linux-acpi@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org
Message-ID: <20160106020703.lamPHGWMX_Dv1HlO49jX6yMaNr-ayigZtdJj--8NmPE@z>

On Tuesday, January 05, 2016 02:15:37 PM Toshi Kani wrote:
> I/O resource descriptor, 'desc' in struct resource, needs to be
> initialized to zero by default.  Some drivers call kmalloc() to
> allocate a resource entry, but does not initialize it to zero by
> memset().  Change these drivers to call kzalloc(), instead.
> 
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Alexandre Bounine <alexandre.bounine@idt.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Acked-by: Simon Horman <horms+renesas@verge.net.au> # sh
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI part.

