From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 69/76] ARC: [Review] Multi-platform image #2: Board callback Infrastructure
Date: Fri, 18 Jan 2013 15:05:10 +0000
Message-ID: <201301181505.10350.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-70-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358511930-7424-70-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> The orig platform code orgnaization was singleton design pattern - only
> one platform (and board thereof) would build at a time.
> 
> Thus any platform/board specific code (e.g. irq init, early init ...)
> expected by ARC common code was exported as well defined set of APIs,
> with only ONE instance building ever.
> 
> Now with multiple-platform build requirement, that design of code no
> longer holds - multiple board specific calls need to build at the same
> time - so ARC common code can't use the API approach, it needs a
> callback based design where each board registers it's specific set of
> functions, and at runtime, depending on board detection, the callbacks
> are used from the registry.
> 
> This commit adds all the infrastructure, where board specific callbacks
> are specified as a "machine description".
> 
> All the hooks are placed in right spots, no board callbacks registered
> yet (with MACHINE_STARt/END constructs) so the hooks will not run.
> 
> Next commit will actually convert the platform to this infrastructure.
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +struct machine_desc {
> +	const char		*name;
> +	const char		**dt_compat;
> +
> +	void			(*init_early)(void);
> +	void			(*init_irq)(void);
> +	void			(*init_time)(void);
> +	void			(*init_machine)(void);
> +	void			(*init_late)(void);
> +
> +#ifdef CONFIG_SMP
> +	void			(*init_smp)(unsigned int);
> +#endif

On ARM, it turned out helpful to list these in the order in 
which they get called. I assume that at least init_smp
is currently not in that order.

Also, we are slowly making some of these obsolete on
ARM: For platforms that at DT-only, the timer and
irq code is now in drivers/irqchip and drivers/clocksource
and can get automatically initialized.

It probably makese sense for you to keep the above structure
for now, but you can also think about obsoleting some
of the calls in the future. It may be a good idea to have
a default version for each of these but still allow overriding
them for maximum flexibility in the platform.

	Arnd
