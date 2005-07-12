Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 12 Jul 2005 12:10:56 -0700 (PDT)
Message-Id: <20050712.121056.77356777.davem@davemloft.net>
Subject: Re: [PATCH 1/2] net: add a top-level Networking menu to *config
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050708003831.GB9883@mars.ravnborg.org>
References: <20050708003831.GB9883@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: linux-arch@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 8 Jul 2005 00:38:32 +0000

> Create a new top-level menu named "Networking" thus moving
> net related options and protocol selection way from the drivers
> menu and up on the top-level where they belong.
> 
> To implement this all architectures has to source "net/Kconfig" before
> drivers/*/Kconfig in their Kconfig file. This change has been
> implemented for all architectures.
> 
> Device drivers for ordinary NIC's are still to be found
> in the Device Drivers section, but Bluetooth, IrDA and ax25
> are located with their corresponding menu entries under the new
> networking menu item.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Patch applied, thanks.
