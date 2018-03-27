From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 17/19] csky: defconfig
Date: Tue, 27 Mar 2018 10:21:31 +0800
Message-ID: <20180327022128.GB10185@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <8a9c9b588cdfdf8b25ca9d449bf5c862d329c1d8.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a3L-zO3K5qcmBPChhSqh+E6WtNRFV1cJRbksGZ74uaEAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3L-zO3K5qcmBPChhSqh+E6WtNRFV1cJRbksGZ74uaEAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 26, 2018 at 03:16:31PM +0200, Arnd Bergmann wrote:
> >  arch/csky/configs/gx66xx_defconfig     | 549 +++++++++++++++++++++++++++++++++
> >  arch/csky/configs/qemu_ck807_defconfig | 541 ++++++++++++++++++++++++++++++++
> >  2 files changed, 1090 insertions(+)
> >  create mode 100644 arch/csky/configs/gx66xx_defconfig
> >  create mode 100644 arch/csky/configs/qemu_ck807_defconfig
> 
> These look a lot longer than they should be, they contain many symbols
> that I suspenc
> are not needed or useful for you.
I'll cleanup the defconfig again.

> 
> > diff --git a/arch/csky/configs/gx66xx_defconfig b/arch/csky/configs/gx66xx_defconfig
> > new file mode 100644
> > index 0000000..7f2a987
> > --- /dev/null
> > +++ b/arch/csky/configs/gx66xx_defconfig
> > @@ -0,0 +1,549 @@
> > +# CONFIG_LOCALVERSION_AUTO is not set
> > +CONFIG_DEFAULT_HOSTNAME="github.com/c-sky"
> 
> This is not a well-formed hostname
I'll remove it.

> 
> > +# CONFIG_SWAP is not set
> > +CONFIG_SYSVIPC=y
> > +CONFIG_POSIX_MQUEUE=y
> > +# CONFIG_FHANDLE is not set
> > +CONFIG_USELIB=y
> > +CONFIG_AUDIT=y
> > +CONFIG_IRQ_DOMAIN_DEBUG=y
> > +CONFIG_NO_HZ_IDLE=y
> > +CONFIG_HIGH_RES_TIMERS=y
> > +CONFIG_BSD_PROCESS_ACCT=y
> > +CONFIG_BSD_PROCESS_ACCT_V3=y
> > +CONFIG_RELAY=y
> > +CONFIG_SYSCTL_SYSCALL=y
> > +CONFIG_KALLSYMS_ALL=y
> > +# CONFIG_AIO is not set
> 
> Disabling swap, fhandle or AIO seems odd, those are commonly
> used symbols.
I'll try to enable them.

> > +CONFIG_USERFAULTFD=y
> > +CONFIG_EMBEDDED=y
> 
> CONFIG_EMBEDDED should generally not be selected, it's only for
> very unusual configurations that need to disable symbols that are
> normally required.
I'll try to enable EMBEDDED.

> 
> > +# CONFIG_PERF_EVENTS is not set
> > +# CONFIG_SLUB_DEBUG is not set
> > +# CONFIG_COMPAT_BRK is not set
> > +CONFIG_PROFILING=y
> > +CONFIG_OPROFILE=y
> 
> oprofile can go now, since you said you'd remove the code.
Yes, remove it.

> > +CONFIG_BLK_DEV_BSGLIB=y
> > +CONFIG_BLK_DEV_INTEGRITY=y
> > +CONFIG_PARTITION_ADVANCED=y
> > +CONFIG_ACORN_PARTITION=y
> > +CONFIG_ACORN_PARTITION_ICS=y
> > +CONFIG_ACORN_PARTITION_RISCIX=y
> > +CONFIG_AIX_PARTITION=y
> > +CONFIG_OSF_PARTITION=y
> > +CONFIG_AMIGA_PARTITION=y
> > +CONFIG_ATARI_PARTITION=y
> > +CONFIG_MAC_PARTITION=y
> > +CONFIG_BSD_DISKLABEL=y
> > +CONFIG_MINIX_SUBPARTITION=y
> > +CONFIG_SOLARIS_X86_PARTITION=y
> > +CONFIG_UNIXWARE_DISKLABEL=y
> > +CONFIG_LDM_PARTITION=y
> > +CONFIG_SGI_PARTITION=y
> > +CONFIG_ULTRIX_PARTITION=y
> > +CONFIG_SUN_PARTITION=y
> > +CONFIG_KARMA_PARTITION=y
> > +CONFIG_SYSV68_PARTITION=y
> 
> These block device configuration options all seem misplaced
> here, it's extremely unlikely that you need them.
I'll try to remove it.

> > +# CONFIG_IPV6 is not set
I'll enable IPV6.

> > +CONFIG_CFG80211=y
> > +CONFIG_CFG80211_DEBUGFS=y
> > +CONFIG_CFG80211_WEXT=y
> 
> I would guess you want IPV6 but not WEXT here.
Gx6605s devlepment board support usb-wifi.
Perhaps WEXT is needed by iwconfig or iwlist? So I just enable it.
However, I'll consider to remove it.

> > +# CONFIG_STANDALONE is not set
> 
> No need to turn this off, it might just get in the way of build
> testing.
Ok, I'll try to enable it.

> > +CONFIG_KEYBOARD_ADP5588=m
> > +CONFIG_KEYBOARD_ADP5589=m
> > +CONFIG_KEYBOARD_QT1070=m
> > +CONFIG_KEYBOARD_QT2160=m
> > +CONFIG_KEYBOARD_LKKBD=m
> 
> There are many input devices listed here, most of which you almost
> certainly won't need.
Yes, remove them.

> > +CONFIG_IPMI_HANDLER=y
> > +CONFIG_IPMI_DEVICE_INTERFACE=m
> > +CONFIG_IPMI_SI=m
> > +CONFIG_IPMI_WATCHDOG=m
> > +CONFIG_IPMI_POWEROFF=m
> 
> Are you sure you have IPMI hardware?
No IPMI hardware, remove them.

> > +CONFIG_FB=y
> > +CONFIG_FB_TILEBLITTING=y
> > +CONFIG_FB_SIMPLE=y
> > +CONFIG_BACKLIGHT_LCD_SUPPORT=y
> > +# CONFIG_LCD_CLASS_DEVICE is not set
> > +# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
> > +# CONFIG_VGA_CONSOLE is not set
> > +CONFIG_FRAMEBUFFER_CONSOLE=y
> > +CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> > +CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> > +CONFIG_LOGO=y
> > +# CONFIG_LOGO_LINUX_MONO is not set
> > +# CONFIG_LOGO_LINUX_VGA16 is not set
> 
> For new platforms, using the DRM subsystem is the recommend
> way to do graphics, it mostly replaces the framebuffer subsystem
> here.
These used by:
https://github.com/c-sky/addons-linux/tree/master/addons/drivers/video/fbdev/nationalchip

I'll consider the DRM subsystem.

> > +CONFIG_STE_MODEM_RPROC=m
> 
> I think this is no longer there.
Yes, remove it.

> > +CONFIG_EXT2_FS=y
> > +CONFIG_EXT2_FS_XATTR=y
> > +CONFIG_EXT2_FS_POSIX_ACL=y
> > +CONFIG_EXT2_FS_SECURITY=y
> > +CONFIG_EXT3_FS=y
> > +CONFIG_EXT3_FS_POSIX_ACL=y
> > +CONFIG_EXT3_FS_SECURITY=y
> 
> Better use EXT4 for the defconfig instead.
OK.

Best Regards
 Guo Ren
