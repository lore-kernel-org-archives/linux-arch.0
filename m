From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] The patch solves the type error  of the parameter
 =?utf-8?B?4oCcb2Zm4oCd?= in syscall mmap on the ARM64 platform.
Date: Wed, 24 Apr 2019 09:31:28 +0100
Message-ID: <28023.1556094688@warthog.procyon.org.uk>
References: <20190423170445.GB21047@fuggles.cambridge.arm.com> <1555504525-17962-1-git-send-email-zhouby_cn@126.com> <20190418112818.GA31923@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423170445.GB21047@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: dhowells@redhat.com, Mark Rutland <mark.rutland@arm.com>, Boyang Zhou <zhouby_cn@126.com>, catalin.marinas@arm.com, haozhu@nudt.edu.cn, linux@dominikbrodowski.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Will Deacon <will.deacon@arm.com> wrote:

> -		unsigned long, fd, off_t, off)
> +		unsigned long, fd, off_t, pgoff)
>  {
> +	unsigned long off = pgoff;
> +

Would loff_t be better?

David
