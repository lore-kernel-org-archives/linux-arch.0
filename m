From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 07/10] arm64: hyperv: Initialize hypervisor on boot
Date: Mon, 16 Mar 2020 09:29:50 +0100
Message-ID: <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com> <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Kelley <mikelley@microsoft.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de, Andy Whitcroft <apw@canonical.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com, "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com, Boqun Feng <boqun.feng@gmail.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
>
> Add ARM64-specific code to initialize the Hyper-V
> hypervisor when booting as a guest VM. Provide functions
> and data structures indicating hypervisor status that
> are needed by VMbus driver.
>
> This code is built only when CONFIG_HYPERV is enabled.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c | 156 ++++++++++++++++++++++++++++++++++++++++++++

As you are effectively adding a new clocksource driver here, please move the
code to drivers/clocksource and send the patch to the respective maintainers
(added to Cc here), splitting it out from the rest of the patch.

You should also describe why your platform doesn't just use the normal
architected timer interface.

> +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);

This looks like it registers a driver for the same device as the normal
arch timer. Won't that clash?

     Arnd
