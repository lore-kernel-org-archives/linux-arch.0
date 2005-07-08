Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 8 Jul 2005 10:02:11 -0700
From: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/2] net: add a top-level Networking menu to *config
Message-Id: <20050708100211.5a1aebdf.rdunlap@xenotime.net>
In-Reply-To: <20050708003831.GB9883@mars.ravnborg.org>
References: <20050708003831.GB9883@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
List-ID: <linux-arch.vger.kernel.org>

On Fri, 8 Jul 2005 00:38:32 +0000 Sam Ravnborg wrote:

| Create a new top-level menu named "Networking" thus moving
| net related options and protocol selection way from the drivers
| menu and up on the top-level where they belong.
| 
| To implement this all architectures has to source "net/Kconfig" before
| drivers/*/Kconfig in their Kconfig file. This change has been
| implemented for all architectures.
| 
| Device drivers for ordinary NIC's are still to be found
| in the Device Drivers section, but Bluetooth, IrDA and ax25
| are located with their corresponding menu entries under the new
| networking menu item.

Hi Sam,

I tested this on 2.6.13-rc2, using menuconfig, xconfig, and
gconfig, with various ARCH=arches.

Looking good to me, but I have one small change request.

Can the NETPOLL options that are under
  Networking support  + Networking options
(that depend on NETCONSOLE) and the NETCONSOLE option that is under
  Device Drivers + Network device support
be moved to the same area?  I don't really care which area,
but it's a hassle to have to move between them to enable/disable
them.

I also think that there is some room for more consistency in
the presentation of similar Network device categories, but
maybe that (other) menuconfig patch will address this after
your patch is merged, since that isn't what this patch was
addressing.

---
~Randy
