From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 UPDATE 09/17] drivers: Initialize resource entry to zero
Date: Wed, 06 Jan 2016 03:07:03 +0100
Message-ID: <4132474.rE6EsOfV8R@vostro.rjw.lan>
References: <1452028537-27365-1-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1452028537-27365-1-git-send-email-toshi.kani@hpe.com>
Sender: owner-linux-mm@kvack.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alexandre.bounine@idt.com>, linux-acpi@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
