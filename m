Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 12 Jul 2005 12:10:47 -0700 (PDT)
Message-Id: <20050712.121047.18708532.davem@davemloft.net>
Subject: Re: [PATCH 2/2] net: move config options out to individual
 protocols
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050708004318.GC9883@mars.ravnborg.org>
References: <20050708003831.GB9883@mars.ravnborg.org>
	<20050708004318.GC9883@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: linux-arch@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 8 Jul 2005 00:43:18 +0000

> Move the protocol specific config options out to the specific protocols.
> With this change net/Kconfig now starts to become readable and serve as a
> good basis for further re-structuring.
> 
> The menu structure is left almost intact, except that indention is
> fixed in most cases. Most visible are the INET changes where several
> "depends on INET" are replaced with a single ifdef INET / endif pair.
> 
> Several new files were created to accomplish this change - they are
> small but serve the purpose that config options are now distributed
> out where they belongs.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Patch applied, thanks.
