From: Chris Metcalf <metcalf@alum.mit.edu>
Subject: Re: [PATCH 06/16] arch: remove tile port
Date: Thu, 15 Mar 2018 21:23:46 -0400
Message-ID: <2f2e0cd4-02ca-0e01-7003-e519a7706ee4@alum.mit.edu>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314143656.1495602-1-arnd@arndb.de>
 <20180314143656.1495602-6-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143656.1495602-6-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-arch.vger.kernel.org

On 3/14/2018 10:36 AM, Arnd Bergmann wrote:
> The Tile architecture port was added by Chris Metcalf in 2010, and
> maintained until early 2018 when he orphaned it due to his departure
> from Mellanox, and nobody else stepped up to maintain it. The product
> line is still around in the form of the BlueField SoC, but no longer
> uses the Tile architecture.
>
> There are also still products for sale with Tile-GX SoCs, notably the
> Mikrotik CCR router family. The products all use old (linux-3.3) kernels
> with lots of patches and won't be upgraded by their manufacturers. There
> have been efforts to port both OpenWRT and Debian to these, but both
> projects have stalled and are very unlikely to be continued in the future.
>
> Given that we are reasonably sure that nobody is still using the port
> with an upstream kernel any more, it seems better to remove it now while
> the port is in a good shape than to let it bitrot for a few years first.

Arnd, thanks for dealing with this.

There are a number of tile-specific driver files that are mostly called out
in the MAINTAINERS file.  I would expect you should also delete those.

-F:    drivers/char/tile-srom.c
-F:    drivers/edac/tile_edac.c
-F:    drivers/net/ethernet/tile/
-F:    drivers/rtc/rtc-tile.c
-F:    drivers/tty/hvc/hvc_tile.c
-F:    drivers/tty/serial/tilegx.c
-F:    drivers/usb/host/*-tilegx.c
-F:    include/linux/usb/tilegx.h

Chris
