From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio / CrystalCove: support virtual GPIO
Date: Tue, 23 Sep 2014 12:13:55 +0200
Message-ID: <CACRpkdZZ-8MAXQ_T2CYyUb0pcdS707G+NCWTc0oHJ2eqr-dcUA@mail.gmail.com>
References: <1410229968-11638-1-git-send-email-aaron.lu@intel.com>
	<1410229968-11638-2-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1410229968-11638-2-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Lejun Zhu <lejun.zhu@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 9, 2014 at 4:32 AM, Aaron Lu <aaron.lu@intel.com> wrote:

> The virtual GPIO introduced in ACPI table of Baytrail-T based system is
> used to solve a problem under Windows. We do not have such problems
> under Linux so we do not actually need them. But we have to tell GPIO
> library that the Crystal Cove GPIO chip has this many GPIO pins or the
> common GPIO handler will refuse any access to those high number GPIO
> pins, which will resulted in a failure evaluation of every ACPI control
> method that is used to turn on/off power resource and/or report sensor
> temperatures.
>
> Due to the high number of virtual GPIOs, the value of ARCH_NR_GPIOS is
> bumped from 256 to 512 to avoid failures on platforms that have various
> GPIO controllers.
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

I have some other patch pending increasing the default GPIO# to
512, but anyhow: this needs review from someone. Where is
Lejun? Mika also reviewed last time. Someone I trust to understand
ACPI need to be involved, Rafael, Darren....

Yours,
Linus Walleij
