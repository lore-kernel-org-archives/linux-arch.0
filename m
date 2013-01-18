From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 71/76] ARC: [Review] Multi-platform image #4: Isolate platform headers
Date: Fri, 18 Jan 2013 15:06:31 +0000
Message-ID: <201301181506.31438.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-72-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358511930-7424-72-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> -Top level ARC makefile removes -I for platform headers
> -asm/irq.h no longer includes plat/irq.h
> 
> -platform makefile adds -I for it's specfic platform headers
> -platform code to directly include it's plat/irq.h
> 
> -Linker script needed plat/memmap.h for CCM info, already in .config
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
