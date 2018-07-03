From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
Date: Tue, 3 Jul 2018 17:14:09 +0800
Message-ID: <20180703091407.GA31664@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
 <CABGGiswb+SmdAi9qV80Yum3Uf=ohrSMpZKWkvJXK8n=GjTzxhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABGGiswb+SmdAi9qV80Yum3Uf=ohrSMpZKWkvJXK8n=GjTzxhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 02, 2018 at 09:33:51PM -0600, Rob Herring wrote:
> > +config CSKY_BUILTIN_DTB
> > +       bool "Use kernel builtin dtb"
> > +
> > +config CSKY_BUILTIN_DTB_NAME
> > +       string "kernel builtin dtb name"
> > +       depends on CSKY_BUILTIN_DTB
> > +endmenu
> 
> These options generally exist for backwards compatibility with legacy
> bootloaders that don't support DT which shouldn't apply here given
> this is a new arch. If we need this for other reasons, it should not
> be an architecture specific option.
We want the BUILTIN_DTB for some boards and they don't need change dtb
at all. And I just follow other archs BUILTIN_DTB in their Kconfig. eg:
xtensa, h8300, mips, nds32, sh, openrisc, arc ...

I just keep this in Kconfig.debug and it's not a recommended method.

Guo Ren
