From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Wed, 3 Jun 2009 16:06:54 +0200
Message-ID: <20090603140654.GA17962@game.jcrosoft.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <1244034286.24482.84.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1244034286.24482.84.camel@pc1117.cambridge.arm.com>
Sender: linux-embedded-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> 
>       * Asymmetric MP:
>               * Different CPU frequencies
>               * Different CPU features (e.g. floating point only one
>                 some CPUs): scheduler awareness, per-CPU hwcap bits (in
>                 case user space wants to set the affinity) 
>               * Asymmetric workload balancing for power consumption (may
>                 be better to load 1 CPU at 60% than 4 at 15%) 
I'll add
		* Different Core ARCH
		* FDT or similar to describe I/O (MEM, PCI, GPIO) acessible for
		  each instance
		* Mailbox Architecture
		* boot preocedure (bootloader as example done by Kumar Gala
		  for the mpc8572ds in linux & U-Boot)
		* sharing rootfs (RO) (reduce the rootfs size on embedded)

Best Regards,
J.
