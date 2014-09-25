From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpio / CrystalCove: support virtual GPIO
Date: Thu, 25 Sep 2014 15:16:26 +0200
Message-ID: <CACRpkdYeOfsx-PpEKaJY14sUqQ2VRiNmXnn_m-mrMzpBtcuBpg@mail.gmail.com>
References: <1410229968-11638-1-git-send-email-aaron.lu@intel.com>
	<1410229968-11638-2-git-send-email-aaron.lu@intel.com>
	<CACRpkdaJjqs9WNcVvjsSWhzLD2QpcyR11MVm4xhm4GqB28eOCA@mail.gmail.com>
	<54238496.70505@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <54238496.70505@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Lejun Zhu <lejun.zhu@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 25, 2014 at 4:57 AM, Aaron Lu <aaron.lu@intel.com> wrote:

> The virtual GPIO introduced in ACPI table of Baytrail-T based system is
> used to solve a problem under Windows. We do not have such problems
> under Linux so we do not actually need them. But we have to tell GPIO
> library that the Crystal Cove GPIO chip has this many GPIO pins or the
> common GPIO handler will refuse any access to those high number GPIO
> pins, which will resulted in a failure evaluation of every ACPI control
> method that is used to turn on/off power resource and/or report sensor
> temperatures.
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
> v2: remove the hunk to increase NR_GPIO to 512.

Patch applied with Mika's ACK, also renumbered 0x5e to 94.

Yours,
Linus Walleij
