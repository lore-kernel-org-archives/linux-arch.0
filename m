From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 54/57] Documentation: irq: Change documents related to IRQF_DISABLED
Date: Wed, 28 Sep 2011 16:33:08 -0600
Message-ID: <CAErSpo7EUw_4sKXXd2pYkTuqvBFOHgZ1zwrv68K3OU57-QE2Dw@mail.gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com> <1316597339-29861-55-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1316597339-29861-55-git-send-email-yong.zhang0@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 21, 2011 at 3:28 AM, Yong Zhang <yong.zhang0@gmail.com> wro=
te:
> IRQF_DISABLED is a NOOP now, place where suggest to use this
> flag also doesn't make sense any more.
>
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

I assume this will be applied via some non-PCI tree (let me know if
otherwise).  The MSI-HOWTO.txt change looks fine to me.

> --- a/Documentation/scsi/ncr53c8xx.txt
> +++ b/Documentation/scsi/ncr53c8xx.txt
> @@ -786,7 +786,9 @@ port address 0x1400.
> =A0 =A0 =A0 =A0 irqm:1 =A0 =A0 same as initial settings (assumed BIOS=
 settings)
> =A0 =A0 =A0 =A0 irqm:2 =A0 =A0 always totem pole
> =A0 =A0 =A0 =A0 irqm:0x10 =A0driver will not use IRQF_SHARED flag whe=
n requesting irq
> - =A0 =A0 =A0 =A0irqm:0x20 =A0driver will not use IRQF_DISABLED flag =
when requesting irq
> + =A0 =A0 =A0 =A0irqm:0x20 =A0driver will not use IRQF_DISABLED (does=
 not make sense
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0any more since genirq will keep =
irq disabled and the flag
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is dead from linux-2.6.35) flag =
when requesting irq
>
> =A0 =A0 (Bits 0x10 and 0x20 can be combined with hardware irq mode op=
tion)

The new text doesn't make sense to me.  I think it should say something=
 like:

    irqm:0x20  driver will not use IRQF_DISABLED flag when requesting
irq (only useful for linux-2.6.34 and earlier)

Bjorn
