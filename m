Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 28 Jan 2005 08:46:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050128084638.A9486@flint.arm.linux.org.uk>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050125155239.4bc469e6.davem@davemloft.net> <20050126063627.GA7198@wotan.suse.de> <20050125224112.306cd1ea.davem@davemloft.net> <20050126071359.GD7198@wotan.suse.de> <20050126074306.GE7198@wotan.suse.de> <20050126000117.62fff2a7.akpm@osdl.org> <16889.43580.716149.901314@cargo.ozlabs.ibm.com> <16889.44363.612523.453157@cargo.ozlabs.ibm.com> <20050127191738.13d65896.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127191738.13d65896.akpm@osdl.org>; from akpm@osdl.org on Thu, Jan 27, 2005 at 07:17:38PM -0800
Sender: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, ak@suse.de, davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jan 27, 2005 at 07:17:38PM -0800, Andrew Morton wrote:
> As an aside, all architectures except one define FIRST_USER_PGD_NR as 0:
> 
> include/asm-arm26/pgtable.h:#define FIRST_USER_PGD_NR       1

After seeing Andi's comments - if there is a chance that this patch gets
merged, please can the commentry be corrected to reflect reality instead
of being misleading?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
