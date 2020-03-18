From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 09/10] arm64: efi: Export screen_info
Date: Wed, 18 Mar 2020 10:26:52 +0100
Message-ID: <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com> <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Kelley <mikelley@microsoft.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 18, 2020 at 1:18 AM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> > On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
> > >
> > > The Hyper-V frame buffer driver may be built as a module, and
> > > it needs access to screen_info. So export screen_info.
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> >
> > Is there any chance of using a more modern KMS based driver for the screen
> > than the old fbdev subsystem? I had hoped to one day completely remove
> > support for the old CONFIG_VIDEO_FBDEV and screen_info from modern
> > architectures.
> >
>
> The current hyperv_fb.c driver is all we have today for the synthetic Hyper-V
> frame buffer device.  That driver builds and runs on both ARM64 and x86.
>
> I'm not knowledgeable about video/graphics drivers, but when you
> say "a more modern KMS based driver", are you meaning one based on
> DRM & KMS?  Does DRM make sense for a "dumb" frame buffer device?
> Are there any drivers that would be a good pattern to look at?

It used to be a lot harder to write a DRM driver compared to an fbdev
driver, but this has changed to the opposite over the years.

A fairly minimal example would be drivers/gpu/drm/pl111/pl111_drv.c
or anything in drivers/gpu/drm/tiny/, but you may want to look at the
other hypervisor platforms first, i.e drivers/gpu/drm/virtio/virtgpu_drv.c,
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c, drivers/gpu/drm/xen/xen_drm_front.c,
drivers/gpu/drm/qxl/qxl_drv.c, and drivers/gpu/drm/bochs/bochs_drv.c.

       Arnd
