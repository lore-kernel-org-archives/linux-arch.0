From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
Date: Mon, 2 Apr 2018 21:54:59 +0200
Message-ID: <CAK8P3a2pdmLOHb2wkPVvqLDo71Rf3hLVfhG7vsMzaPD-DMEzSg@mail.gmail.com>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
 <CA+55aFzmQ9specaytsjEb=iNm-NHE5kxMSy_H_jKvqZa4-Fomw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzmQ9specaytsjEb=iNm-NHE5kxMSy_H_jKvqZa4-Fomw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, Hirokazu Takata <takata@linux-m32r.org>, Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>, Bryan Wu <cooloney@gmail.com>, Chris Metcalf <chris.d.metcalf@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 2, 2018 at 8:57 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 2, 2018 at 12:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> (dirstat only for brevity)
>
> Shortlog?
>
> I'd like to see that each architecture removal is independent of the
> others, so that if somebody wants to resurrect any particular
> architecture, he/she can do so with a revert.
>
> Can I just fetch things and see? Sure. But there's no excuse not to
> have a shortlog in the pull request, even if the full diffstat itself
> might be prohibitive.

Right, that was a mistake on my end, I just cut too much, see below
for the missing shortlog.

Regarding a possible revert, that would indeed involve reverting
multiple patches for most architectures, plus parts of at least these
three:

  Documentation: arch-support: remove obsolete architectures
  treewide: simplify Kconfig dependencies for removed archs
  ktest: remove obsolete architectures

For those, I went the other way, and removed all architectures at
once to simplify my work and to avoid touching the same files up
to eight times with interdependent patches (which couldn't
be reverted without conflicts either).

There are a couple of driver removal patches that got picked up
into subsystem trees instead of this tree, so a full revert would also
involve finding other drivers, but if you prefer to have the patches
completely split up by arch, I could rework the series that way.

      Arnd

Aaron Wu (2):
      misc: Remove Blackfin DSP echo support
      usb: Remove Blackfin references in USB support

Arnd Bergmann (58):
      Merge tag 'metag_remove_2' of
ssh://gitolite.kernel.org/.../jhogan/metag into asm-generic
      arch: remove frv port
      arch: remove m32r port
      arch: remove score port
      arch: remove blackfin port
      arch: remove tile port
      procfs: remove CONFIG_HARDWALL dependency
      mm: remove blackfin MPU support
      mm: remove obsolete alloc_remap()
      treewide: simplify Kconfig dependencies for removed archs
      asm-generic: siginfo: remove obsolete #ifdefs
      asm-generic: siginfo: define ia64 si_codes unconditionally
      asm-generic: clean up asm/unistd.h
      Documentation: arch-support: remove obsolete architectures
      recordmcount.pl: drop blackin and tile support
      ktest: remove obsolete architectures
      edac: remove tile driver
      net: tile: remove ethernet drivers
      net: adi: remove blackfin ethernet drivers
      net: 8390: remove m32r specific bits
      net: remove cris etrax ethernet driver
      net: smsc: remove m32r/mn10300 specific smc91x configuration
      raid: remove tile specific raid6 implementation
      rtc: remove tile driver
      rtc: remove bfin driver
      char: remove obsolete ds1302 rtc driver
      char: remove tile-srom.c
      char: remove blackfin OTP driver
      pcmcia: remove m32r drivers
      pcmcia: remove blackfin driver
      video/logo: remove obsolete logo files
      fbdev: remove blackfin drivers
      fbdev: s1d13xxxfb: remove m32r specific hacks
      media: platform: remove blackfin capture driver
      media: platform: remove m32r specific arv driver
      cpufreq: remove blackfin driver
      cpufreq: remove cris specific drivers
      gpio: remove etraxfs driver
      pinctrl: remove adi2/blackfin drivers
      ata: remove bf54x driver
      input: keyboard: remove bf54x driver
      input: misc: remove blackfin rotary driver
      mmc: remove bfin_sdh driver
      can: remove bfin_can driver
      watchdog: remove bfin_wdt driver
      spi: remove blackfin related host drivers
      i2c: remove bfin-twi driver
      pwm: remove pwm-bfin driver
      usb: host: remove tilegx platform glue
      usb: musb: remove blackfin port
      usb: isp1362: remove blackfin arch glue
      serial: remove cris/etrax uart drivers
      serial: remove blackfin drivers
      serial: remove m32r_sio driver
      serial: remove tile uart driver
      tty: remove bfin_jtag_comm and hvc_bfin_jtag drivers
      tty: hvc: remove tile driver
      staging: iio: remove iio-trig-bfin-timer driver

David Howells (1):
      mn10300: Remove the architecture

Guan Xuetao (1):
      MAINTAINERS: UNICORE32: Change email account

James Hogan (11):
      metag: Remove arch/metag/
      docs: Remove metag docs
      docs: Remove remaining references to metag
      Drop a bunch of metag references
      irqchip: Remove metag irqchip drivers
      clocksource: Remove metag generic timer driver
      tty: Remove metag DA TTY and console driver
      MAINTAINERS/CREDITS: Drop METAG ARCHITECTURE
      watchdog: imgpdc: Drop METAG dependency
      media: img-ir: Drop METAG dependency
      i2c: img-scb: Drop METAG dependency

Jesper Nilsson (1):
      CRIS: Drop support for the CRIS port

Tobias Klauser (1):
      scripts/checkstack.pl: remove blackfin support
