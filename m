From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: Re: [PATCH V7 00/20] C-SKY(csky) Linux Kernel Port
Date: Sat, 6 Oct 2018 22:06:49 +0200
Message-ID: <20181006200649.GL32759@asgard.redhat.com>
References: <cover.1538715563.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1538715563.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, green.hu@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 05, 2018 at 01:41:42PM +0800, Guo Ren wrote:
> This is the 7th version patchset to add the Linux kernel port for
> C-SKY(csky) based on linux-4.19-rc3.
> 
> In this patchset some fixup patches are folded into original patch in
> order to make review clearly and reduce the patches' number for upstream
> patchset. The changelog is added in the every patch's commit-msg.
> 
> Here is the LTP test report for this patchset:
> (and add "V10 C-SKY(csky) Linux Kernel Driver" patchset)
> -----------------------------------------------
> Total Tests: 1298
> Total Skipped Tests: 280
> Total Failures: 11
> Kernel Version: 4.19.0-rc3+
> Machine Architecture: csky
> Hostname: buildroot
> -----------------------------------------------
> 
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> 
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> 	 SMP ...)
> More information: http://en.c-sky.com
> The development repo: https://gitlab.com/c-sky/csky-linux

I'm sorry for my ignorance, but I'm struggling to find ISA reference/manual,
architecture programming manual, and System V ABI definition;
may I ask to give links to them?
