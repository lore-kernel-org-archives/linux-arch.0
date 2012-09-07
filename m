From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 18/31] arm64: VDSO support
Date: Fri, 7 Sep 2012 19:44:23 +0000
Message-ID: <201209071944.23703.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-19-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347035226-18649-19-git-send-email-catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> This patch adds VDSO support for 64-bit applications. The VDSO code is
> currently used for sys_rt_sigreturn() and optimised gettimeofday()
> (using the user-accessible generic counter).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
