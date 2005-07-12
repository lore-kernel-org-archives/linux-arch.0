Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 12 Jul 2005 12:11:23 -0700 (PDT)
Message-Id: <20050712.121123.39661217.davem@davemloft.net>
Subject: Re: [PATCH 1/2] net: add a top-level Networking menu to *config
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050708100211.5a1aebdf.rdunlap@xenotime.net>
References: <20050708003831.GB9883@mars.ravnborg.org>
	<20050708100211.5a1aebdf.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: rdunlap@xenotime.net
Cc: sam@ravnborg.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: randy_dunlap <rdunlap@xenotime.net>
Date: Fri, 8 Jul 2005 10:02:11 -0700

> Can the NETPOLL options that are under
>   Networking support  + Networking options
> (that depend on NETCONSOLE) and the NETCONSOLE option that is under
>   Device Drivers + Network device support
> be moved to the same area?  I don't really care which area,
> but it's a hassle to have to move between them to enable/disable
> them.
> 
> I also think that there is some room for more consistency in
> the presentation of similar Network device categories, but
> maybe that (other) menuconfig patch will address this after
> your patch is merged, since that isn't what this patch was
> addressing.

Please provide a followon patch to make these changes,
as I put Sam's patches into my tree last night.

Thanks a lot.
