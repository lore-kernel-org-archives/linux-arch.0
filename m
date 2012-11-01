From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn-yOkvZcmFvRU@public.gmane.org>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of function 'iowrite32'
Date: Thu, 01 Nov 2012 14:38:29 +0100
Message-ID: <87k3u5h296.fsf@nemi.mork.no>
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
	<20121101103339.GD410@arwen.pp.htv.fi>
	<20121101105034.GE410@arwen.pp.htv.fi>
	<20121101130420.GB20982@kroah.com>
	<20121101132342.GE12489@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121101132342.GE12489-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org> (Felipe Balbi's message
	of "Thu, 1 Nov 2012 15:23:42 +0200")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

=46elipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:

> btw, only alpha and x86 seem to be providing all of those, but if you
> look into our documentation, it's said that drivers are supposed to u=
se
> write/read{b,w,l,q} for all memory-mapped io. I'd expect all platform=
s
> to provide those even if just to allow compilation of drivers.

Only if HAS_IOMEM is true, I believe.


Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
