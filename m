From: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
Date: Wed, 7 Mar 2012 11:52:03 +1100
Message-ID: <CAGRGNgWHXrQgVobz+54sFBzj=bTHCKwg+H4_CY5JoGtmETw2yA@mail.gmail.com>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org> <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, Russell King <linux@arm.linux.org.uk>, nico@fluxnic.net, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Stephen,

On Wed, Mar 7, 2012 at 11:30, Stephen Warren <swarren@wwwdotorg.org> wr=
ote:
> This allows the user to use U-Boot's mkimage's -T kernel_noload optio=
n
> if their arch Kconfig allows it, and they desire.
>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> diff --git a/init/Kconfig b/init/Kconfig
> index 6cfd71d..2035562 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -203,6 +203,21 @@ config KERNEL_LZO
>
> =A0endchoice
>
> +config ALLOW_UIMAGE_KERNEL_NOLOAD
> + =A0 =A0 =A0 bool
> +
> +config UIMAGE_KERNEL_NOLOAD
> + =A0 =A0 =A0 bool "Use mkimage's -T kernel_noload instead of -T kern=
el"
> + =A0 =A0 =A0 depends on ALLOW_UIMAGE_KERNEL_NOLOAD
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 uImage files of type "kernel" embed an absolute loa=
d and entry point
> + =A0 =A0 =A0 =A0 address. If the uImage is loaded to a different add=
ress, then the
> + =A0 =A0 =A0 =A0 image must be copied the uImage file to the specifi=
ed load address.

You seem to have an excess "the uImage file" in here.

> + =A0 =A0 =A0 =A0 This copy is a waste of time if the uImage is in fa=
ct completely
> + =A0 =A0 =A0 =A0 relocatable. If your kernel and bootloader support =
it, you can build
> + =A0 =A0 =A0 =A0 a "kernel_noload" uImage rather than a "kernel" uIm=
age, which
> + =A0 =A0 =A0 =A0 prevents any such copying. If unsure say N.
> +
> =A0config DEFAULT_HOSTNAME
> =A0 =A0 =A0 =A0string "Default hostname"
> =A0 =A0 =A0 =A0default "(none)"

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
=2EPlan: http://sites.google.com/site/juliancalaby/
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
