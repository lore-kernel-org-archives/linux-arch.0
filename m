From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 15/17] driver/cpufreq: enable Hygon support to cpufreq driver
Date: Tue, 14 Aug 2018 12:11:44 +0200
Message-ID: <2048121.dGp66DhuPz@aspire.rjw.lan>
References: <cover.1533989492.git.puwen@hygon.cn> <CAJZ5v0izyq2SoUspLPDRM9U7W+-bZPCcQ4C5Zu1hVFDoUj=w1g@mail.gmail.com> <04744a9f-5865-bbc8-7735-e92c6cf6472d@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <04744a9f-5865-bbc8-7735-e92c6cf6472d@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Monday, August 13, 2018 6:22:16 PM CEST Pu Wen wrote:
> On 2018/8/12 17:55, Rafael J. Wysocki wrote:
> > On Sat, Aug 11, 2018 at 3:36 PM Pu Wen <puwen@hygon.cn> wrote:
> >>
> >> Enable ACPI cpufreq driver support for Hygon by adding family ID check
> >> along with AMD.
> >>
> >> As Hygon platforms have SMBus device(PCI device ID 0x790b), enable Hygon
> >> support to function amd_freq_sensitivity_init().
> >>
> >> Signed-off-by: Pu Wen <puwen@hygon.cn>
> > 
> > Is there any technical difference between HYGON and AMD?
> 
> For ACPI cpufreq patch, you are right. But for the whole point of view,
> there has some technical difference between Hygon Dhyana and AMD Family
> 17h.
> For cpufreq if not added X86_VENDOR_HYGON codes, this driver will not
> work functionally on Hygon platforms.
> 
> > 
> > You seem to be mechanically adding X86_VENDOR_HYGON wherever
> > X86_VENDOR_AMD is used.
> 
> X86_VENDOR_HYGON is not mechanically added wherever X86_VENDOR_AMD is
> used, we have reviewed and tested the features wherever X86_VENDOR_HYGON
> is needed.
> 
> As Hygon Dhyana can share code path with AMD family 17h, to minimize the
> code duplication, we choose to reuse the AMD's codes here.

OK

The cpufreq changes are fine by me.

Thanks!
