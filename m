From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] ARM64: fix building without CONFIG_UID16
Date: Mon, 30 Nov 2015 09:38:58 +0100
Message-ID: <20151130083858.GB4045@osiris>
References: <3891403.6hGat7eHq5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3891403.6hGat7eHq5@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: will.deacon@arm.com, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 20, 2015 at 12:12:21PM +0100, Arnd Bergmann wrote:
> As reported by Michal Simek, building an ARM64 kernel with CONFIG_UID16
> disabled currently fails because the system call table still needs to
> reference the individual function entry points that are provided by
> kernel/sys_ni.c in this case, and the declarations are hidden inside
> of #ifdef CONFIG_UID16:

Will we ever get rid of UID16? kernel/uid.c contains this nice comment:

/*
 *	Wrapper functions for 16bit uid back compatibility. All nicely tied
 *	together in the faint hope we can take the out in five years time.
 */

Which seems to exist since at least February 2000. ;)
