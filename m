From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Date: Thu, 15 Feb 2018 14:22:58 +0200
Message-ID: <CAHp75VfFKcnUVQwPUxynzp88RXWdV8VEqtXxd0=_Q_GJKO6UpQ@mail.gmail.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com> <20180214161635.GA13849@e107981-ln.cambridge.arm.com>
 <65185a4d-c712-4486-d713-3fa9de14e35d@huawei.com> <e3fb78b3-5f5c-fe96-9f02-e96092963c17@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:42544 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967889AbeBOMXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Feb 2018 07:23:00 -0500
In-Reply-To: <e3fb78b3-5f5c-fe96-9f02-e96092963c17@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Dann Frazier <dann.frazier@canonical.com>, Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>devicetree <d>

On Thu, Feb 15, 2018 at 1:19 PM, John Garry <john.garry@huawei.com> wrote:

> +static const struct acpi_device_id indirect_io_hosts[] = {
> +    {"HISI0191", 0},    /* HiSilicon LPC host */
> +    {},

Just a nit.

It seems lately this happens more often than usual, I mean a comma in
the terminator line.

If we remove it. we terminate not only at runtime, but at compile
time, which is slightly better.

> +};

-- 
With Best Regards,
Andy Shevchenko
