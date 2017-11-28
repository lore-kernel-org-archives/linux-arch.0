From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 31/35] earlycon: add reg-offset to physical address
 before mapping
Date: Tue, 28 Nov 2017 15:25:07 +0100
Message-ID: <20171128142507.GA17797@kroah.com>
References: <cover.1511785528.git.green.hu@gmail.com>
 <5b5f07ffd75d509a661398d02d6f1336156554ae.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5b5f07ffd75d509a661398d02d6f1336156554ae.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 08:28:18PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> It will get the wrong virtual address because port->mapbase is not added
> the correct reg-offset yet. We have to update it before earlycon_map()
> is called
> ---
>  drivers/tty/serial/earlycon.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

No signed-off-by line?
