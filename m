From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 56/76] ARC: Unaligned access emulation
Date: Fri, 18 Jan 2013 14:54:36 +0000
Message-ID: <201301181454.36279.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-57-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358511930-7424-57-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Yao <tim.yao@amlogic.com>
List-Id: linux-arch.vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> ARC700 doesn't natively support unaligned access, but can be emulated
> -Unaligned Access Exception
> -Disassembly at the Fault address to find the exact insn (long/short)
> 
> Also per Arnd's comment, we runtime control it using 2 sysctl knobs:
> * SYSCTL_ARCH_UNALIGN_ALLOW: Runtime enable/disble
> * SYSCTL_ARCH_UNALIGN_NO_WARN: Warn on each emulation attempt
> 
> Originally contributed by Tim Yao <tim.yao@amlogic.com>
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Tim Yao <tim.yao@amlogic.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
