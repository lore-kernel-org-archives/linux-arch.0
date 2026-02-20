Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0FA31B123;
	Fri, 20 Feb 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595569; cv=none; b=V4fzHgdosyn0iaNvm1Bhz0VRQkUwpNjcUl4cJoAhRCzb7yiXS41cEF+x0L5Zej5fR/ri874bHWXpeuHVyYIAbd9rCMZgsSOVmJvtF8fyVijGEM0V3C/HxNC89R2UcQH/V+jiF/RlSH7Pc15jVRqudOCq2BGuuVFdLwmqqaIjbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595569; c=relaxed/simple;
	bh=aJGPw6xiAsZTtMPiPneO1+9rWvTeQEo9/V119zgzdQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXSK+/4r26DUxvhf5xyMszbhgd3y4Mv2lhUXbGkb6EGNarDFMfmhLi8FAnx9UoQK41zMJFAU6bp0aB6z8GVoCAuE9gktM8TSCIfk7P3JqjEAoVEagwmxjzHWBbYSoqs5m0nI2ZrBCgH4cQP4ddMsElw1LRuHYQ29zL2JHw0yH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlprimWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlprimWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641F9C116D0;
	Fri, 20 Feb 2026 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771595568;
	bh=aJGPw6xiAsZTtMPiPneO1+9rWvTeQEo9/V119zgzdQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlprimWhb4kQEKZDGi7XLSDwdRunTxR1cv0GBpYcShzsfNy+KhKEBUCZmWOYh3uPk
	 uWxZCIjnDSZTcJ9hk7EDBb0EROaBxaJqvJBZO0LmObsZALxa35hDpEOFn41nhvzsa0
	 /hoxG4Jwf4SwRIDqCdA0vFiZ7AUQKC1y2WmVZ0U4e/cw9FkCkA3ba+XE5rXjydLBO5
	 fLy+MZS16WTJ0873myGAdlx//NOrrRS6zd7S7XZcXhUHGPi42hY5t6Z3u3qWvS+anD
	 FxSycZGAlEJhwVnPJlOc2wBKfCQ1GTTU7rplN8sPIC/Izg3EBuw5M0/6RNrDZYSDgD
	 0LyGqNCIYILng==
Date: Fri, 20 Feb 2026 21:34:14 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: use runtime constant to optimize
 handle_arch_irq access
Message-ID: <aZhi1p0NJH5ug8CA@xhacker>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-4-jszhang@kernel.org>
 <20260220123414.GF136967@e132581.arm.com>
 <aZheqINXslxlrmTt@xhacker>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZheqINXslxlrmTt@xhacker>

On Fri, Feb 20, 2026 at 09:16:24PM +0800, Jisheng Zhang wrote:
> On Fri, Feb 20, 2026 at 12:34:14PM +0000, Leo Yan wrote:
> > Hi Jisheng,
> 
> Hi Leo,
> 
> > 
> > On Fri, Feb 20, 2026 at 05:09:22PM +0800, Jisheng Zhang wrote:
> > > Currently, on arm64 platforms, the handle_arch_irq is a pointer which
> > > is set during booting, and every irq processing needs to access it,
> > > so it sits in hot code path. We can use the runtime constant mechanism
> > > which was introduced by Linus to speed up its accessing.
> > > 
> > > Tested on Quad CA55 platform, the perf sched benchmark is improved
> > > by ~6.5%
> > 
> > 6.5% is a quite high margin, especially for only one pointer's change.
> > Maybe it is good to share more info for which compiler you are using,
> > how you tested and the detailed results.
> 
> Sure. 
> aarch64-linux-gnu-gcc version 15.2.0
> 
> my kernel defconfig is a minimal arm64 version which disables most
> drivers, only keep timer, gic, pll/clk, uart, regulator and i2c controller
> The reason is to avoid OS noise as much as possible.
> It's also put at the end of the email for reference.
> 
> testing cmd:
> perf bench sched pipe
> 
> testing steps:
> booting into a buildroot minimal initramfs
> force cpufreq governor as performance
> run above cmd
> 
> testing resuls:
> before the patch:
> 9.471988 usecs/op
>   105574 ops/sec
> 
> after the patch:
> 8.896280 usecs/op
>   112406 ops/sec
> 
> (112406 - 105574) * 100 / 105574 = ~6.5 %
> 
> Let me know if you need more details
> 
> 
> > 
> > I played a bit on my juno board on CA73 cores with the command:
> 
> IIRC, Juno is powered by a big.little SoC, then we need to ensure
> the benchmark is always running on big or little cores when testing, to
> ensure apple to apple comparison.
> 
> I also have a CA73 platform, but can't access it now. I'll test the
> patch next week.
> > 
> >   perf bench sched all
> > 
> > Run 3 iterations, and measures three metrics (messaging/pipe/seccomp)
> > and results in seconds. Less is better.
> > 
> >   +---------------------+--------+--------+--------+--------+
> >   |Without change       |   run1 |   run2 |   run3 |    avg |
> >   +---------------------+--------+--------+--------+--------+
> >   |messaging (sec)      |  4.546 |  4.508 |  4.591 |  4.548 |
> >   |pipe (sec)           | 24.258 | 24.224 | 24.017 | 24.166 |
> >   |seccomp-notify (sec) | 48.393 | 48.457 | 48.232 | 48.361 |
> >   +---------------------+--------+--------+--------+--------+
> > 
> >   +---------------------+--------+--------+--------+--------+--------+
> >   |With change          |   run1 |   run2 |   run3 |    avg |   diff |
> >   +---------------------+--------+--------+--------+--------+--------+
> >   |messaging (sec)      |  4.493 |  4.523 |  4.556 |  4.524 | +0.52% |
> >   |pipe (sec)           | 23.159 | 23.702 | 28.649 | 25.170 | -4.15% |
> 
> If you check the result, this result variance is abnormal, it means
> your OS is noiser.

BTW: if you remove the abnormal run3 result, you'll find that the
benchmark is improved by ~3.5% on CA73:
(23.159 + 23.702) / 2 = 23.43
(24.258 + 24.224) / 2 = 24.24
(24.24 - 23.43)*100 / 23.43 = ~3.5

> 
> >   |seccomp-notify (sec) | 46.848 | 46.938 | 46.973 | 46.920 | +2.98% |
> >   +---------------------+--------+--------+--------+--------+--------+
> > 
> > With this patch, the messaging test shows a minor improvement (0.52%).
> > 
> > The pipe test performs worse (-4.15%) after applying the patch. However,
> > one positive signal is that the minimum latency is 23.159, which is
> > lower than without the change (24.017).
> 
> The perf bench is sensitive to OS noise, so I disable most devices, only
> uart, timer, irq chip, i2c and regulator is kept,  and stop all daemons
> only keep a usespace process bash shell.
> 
> defconfig for reference:
> 
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_SYSVIPC=y
> CONFIG_NO_HZ_IDLE=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_PREEMPT=y
> # CONFIG_CPU_ISOLATION is not set
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_RD_GZIP is not set
> # CONFIG_RD_BZIP2 is not set
> # CONFIG_RD_LZMA is not set
> # CONFIG_RD_XZ is not set
> # CONFIG_RD_LZO is not set
> # CONFIG_RD_LZ4 is not set
> # CONFIG_INITRAMFS_PRESERVE_MTIME is not set
> CONFIG_EXPERT=y
> # CONFIG_UID16 is not set
> # CONFIG_SYSFS_SYSCALL is not set
> CONFIG_PROFILING=y
> CONFIG_ARCH_BERLIN=y
> # CONFIG_ARM64_ERRATUM_826319 is not set
> # CONFIG_ARM64_ERRATUM_827319 is not set
> # CONFIG_ARM64_ERRATUM_824069 is not set
> # CONFIG_ARM64_ERRATUM_819472 is not set
> # CONFIG_ARM64_ERRATUM_832075 is not set
> # CONFIG_ARM64_ERRATUM_845719 is not set
> # CONFIG_ARM64_ERRATUM_843419 is not set
> # CONFIG_ARM64_ERRATUM_1418040 is not set
> # CONFIG_ARM64_ERRATUM_1165522 is not set
> # CONFIG_ARM64_ERRATUM_1463225 is not set
> # CONFIG_CAVIUM_ERRATUM_22375 is not set
> # CONFIG_CAVIUM_ERRATUM_23154 is not set
> # CONFIG_CAVIUM_ERRATUM_27456 is not set
> # CONFIG_CAVIUM_ERRATUM_30115 is not set
> # CONFIG_CAVIUM_TX2_ERRATUM_219 is not set
> # CONFIG_FUJITSU_ERRATUM_010001 is not set
> # CONFIG_HISILICON_ERRATUM_161600802 is not set
> # CONFIG_QCOM_FALKOR_ERRATUM_1003 is not set
> # CONFIG_QCOM_FALKOR_ERRATUM_1009 is not set
> # CONFIG_QCOM_QDF2400_ERRATUM_0065 is not set
> # CONFIG_QCOM_FALKOR_ERRATUM_E1041 is not set
> # CONFIG_SOCIONEXT_SYNQUACER_PREITS is not set
> CONFIG_NR_CPUS=4
> CONFIG_HOTPLUG_CPU=y
> CONFIG_HZ_100=y
> # CONFIG_UNMAP_KERNEL_AT_EL0 is not set
> CONFIG_COMPAT=y
> CONFIG_ARMV8_DEPRECATED=y
> CONFIG_SWP_EMULATION=y
> CONFIG_CP15_BARRIER_EMULATION=y
> CONFIG_SETEND_EMULATION=y
> # CONFIG_ARM64_HW_AFDBM is not set
> # CONFIG_ARM64_PTR_AUTH is not set
> # CONFIG_ARM64_AMU_EXTN is not set
> # CONFIG_ARM64_SVE is not set
> # CONFIG_EFI is not set
> # CONFIG_SUSPEND is not set
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_TEO=y
> CONFIG_ARM_PSCI_CPUIDLE=y
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPUFREQ_DT=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_VMAP_STACK is not set
> # CONFIG_BLOCK is not set
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_COMPACTION is not set
> CONFIG_CMA=y
> # CONFIG_ZONE_DMA32 is not set
> # CONFIG_VM_EVENT_COUNTERS is not set
> CONFIG_SYNA_DOLPHIN_PLL=y
> CONFIG_SYNA_CLK_BASE=y
> CONFIG_SYNA_MYNA2_CLK=y
> CONFIG_PINCTRL_MYNA2=y
> CONFIG_USB_DWC3_SYNA=y
> # CONFIG_SYNAPTICS_PCIE is not set
> CONFIG_REGULATOR_HL7593=y
> CONFIG_PHY_SYNA_USB=y
> # CONFIG_SYNAPTICS_I2C is not set
> CONFIG_BERLIN_CHIPID=y
> CONFIG_BERLIN_AXI_METER=y
> # CONFIG_SYNAPTICS_NET is not set
> # CONFIG_SYNAPTICS_VIDEO is not set
> # CONFIG_SYNAPTICS_SOUND is not set
> # CONFIG_SYNAPTICS_DEVFREQ is not set
> # CONFIG_SYNAPTICS_DMABUF is not set
> # CONFIG_SYNAPTICS_IRQCHIP is not set
> # CONFIG_SYNAPTICS_INPUT is not set
> # CONFIG_SYNAPTICS_BLUETOOTH is not set
> # CONFIG_SYNAPTICS_CLOCKSOURCE is not set
> # CONFIG_SYNAPTICS_DMA is not set
> # CONFIG_SYNAPTICS_TTY is not set
> # CONFIG_SYNAPTICS_LEDS is not set
> # CONFIG_SYNAPTICS_MFD is not set
> # CONFIG_SYNAPTICS_MISC is not set
> # CONFIG_SYNAPTICS_MTD is not set
> # CONFIG_SYNAPTICS_PWM is not set
> # CONFIG_SYNAPTICS_RTC is not set
> # CONFIG_SYNAPTICS_SPI is not set
> # CONFIG_SYNAPTICS_STAGING is not set
> # CONFIG_SYNAPTICS_WATCHDOG is not set
> # CONFIG_SYNAPTICS_MAILBOX is not set
> # CONFIG_SYNAPTICS_RPMSG is not set
> # CONFIG_SYNAPTICS_CRYPTO is not set
> CONFIG_UEVENT_HELPER=y
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> # CONFIG_ALLOW_DEV_COREDUMP is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_SERIO is not set
> # CONFIG_VT is not set
> # CONFIG_LEGACY_PTYS is not set
> # CONFIG_LEGACY_TIOCSTI is not set
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_NR_UARTS=2
> CONFIG_SERIAL_8250_RUNTIME_UARTS=2
> CONFIG_SERIAL_8250_DW=y
> # CONFIG_HW_RANDOM is not set
> # CONFIG_DEVPORT is not set
> CONFIG_I2C=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_DESIGNWARE_CORE=y
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_DWAPB=y
> CONFIG_GPIO_FXL6408=y
> # CONFIG_HWMON is not set
> CONFIG_MFD_SYSCON=y
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_GPIO=y
> CONFIG_REGULATOR_TPS6286X=y
> # CONFIG_HID_SUPPORT is not set
> # CONFIG_USB_SUPPORT is not set
> CONFIG_DMABUF_HEAPS=y
> CONFIG_DMABUF_SYSFS_STATS=y
> CONFIG_DMABUF_HEAPS_CMA=y
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VHOST_MENU is not set
> # CONFIG_SURFACE_PLATFORMS is not set
> # CONFIG_ARM64_PLATFORM_DEVICES is not set
> # CONFIG_ARM_ARCH_TIMER_EVTSTREAM is not set
> # CONFIG_FSL_ERRATUM_A008585 is not set
> # CONFIG_HISILICON_ERRATUM_161010101 is not set
> # CONFIG_ARM64_ERRATUM_858921 is not set
> # CONFIG_IOMMU_SUPPORT is not set
> CONFIG_RESET_CONTROLLER=y
> # CONFIG_DNOTIFY is not set
> # CONFIG_PROC_PAGE_MONITOR is not set
> CONFIG_TMPFS=y
> CONFIG_CONFIGFS_FS=y
> # CONFIG_MISC_FILESYSTEMS is not set
> CONFIG_DMA_CMA=y
> CONFIG_PRINTK_TIME=y
> # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
> CONFIG_DEBUG_FS=y
> # CONFIG_SLUB_DEBUG is not set
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_STACKTRACE=y
> # CONFIG_RCU_TRACE is not set
> # CONFIG_FTRACE is not set
> # CONFIG_STRICT_DEVMEM is not set
> # CONFIG_RUNTIME_TESTING_MENU is not set
> > 
> > For seccomp, the results indicate a benefit (2.98%) from the change.
> > 
> > Hope this is helpful for maintainers to judge the change.
> > 
> > I'd leave maintainers to review the code.
> > 
> > Thanks,
> > Leo
> 
